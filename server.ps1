$port = 8760
$root = $PSScriptRoot
$url  = "http://localhost:$port/"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
$listener.Start()

Write-Host "Server running at $url"
Write-Host "Close this window to stop."

$mime = @{
  '.html' = 'text/html; charset=utf-8'
  '.js'   = 'application/javascript'
  '.css'  = 'text/css'
  '.png'  = 'image/png'
  '.ico'  = 'image/x-icon'
}

while ($listener.IsListening) {
  $ctx  = $listener.GetContext()
  $req  = $ctx.Request
  $resp = $ctx.Response

  $path = $req.Url.LocalPath -replace '^/', ''
  if ($path -eq '') { $path = 'contacts-viewer.html' }
  $file = Join-Path $root $path

  if (Test-Path $file -PathType Leaf) {
    $ext  = [IO.Path]::GetExtension($file)
    $ct   = if ($mime[$ext]) { $mime[$ext] } else { 'application/octet-stream' }
    $buf  = [IO.File]::ReadAllBytes($file)
    $resp.ContentType   = $ct
    $resp.ContentLength64 = $buf.Length
    $resp.OutputStream.Write($buf, 0, $buf.Length)
  } else {
    $resp.StatusCode = 404
  }
  $resp.Close()
}
