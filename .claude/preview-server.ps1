# Minimal static file server for previewing the site locally (http://localhost:8765/).
# Used by the "weekly-site-preview" entry in .claude/launch.json. Not part of the site.
param([int]$Port = 8765)
$root = Split-Path -Parent $PSScriptRoot
$types = @{ ".html" = "text/html; charset=utf-8"; ".css" = "text/css"; ".js" = "text/javascript";
  ".json" = "application/json"; ".md" = "text/markdown; charset=utf-8"; ".png" = "image/png";
  ".jpg" = "image/jpeg"; ".svg" = "image/svg+xml"; ".webp" = "image/webp"; ".ico" = "image/x-icon" }
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Serving $root at http://localhost:$Port/"
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath).TrimStart("/")
  if ($rel -eq "" -or $rel.EndsWith("/")) { $rel += "index.html" }
  $path = [IO.Path]::GetFullPath((Join-Path $root $rel))
  $res = $ctx.Response
  if ($path.StartsWith($root) -and (Test-Path $path -PathType Leaf)) {
    $bytes = [IO.File]::ReadAllBytes($path)
    $ext = [IO.Path]::GetExtension($path).ToLower()
    $res.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { "application/octet-stream" }
    $res.Headers.Add("Cache-Control", "no-store")
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $res.StatusCode = 404
  }
  $res.Close()
}
