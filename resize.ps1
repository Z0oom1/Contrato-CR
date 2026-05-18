Add-Type -AssemblyName System.Drawing
$srcPath = "..\main\public\LogotipoAI.png"
$destPath = "logo_base64_small.txt"

if (Test-Path $srcPath) {
    $srcImage = [System.Drawing.Image]::FromFile($srcPath)
    $newImage = New-Object System.Drawing.Bitmap(128, 128)
    $graphics = [System.Drawing.Graphics]::FromImage($newImage)
    
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    
    $graphics.DrawImage($srcImage, 0, 0, 128, 128)
    
    $ms = New-Object System.IO.MemoryStream
    $newImage.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $base64 = [Convert]::ToBase64String($ms.ToArray())
    $base64 | Out-File -FilePath $destPath -Encoding ascii -NoNewline
    
    $srcImage.Dispose()
    $newImage.Dispose()
    $graphics.Dispose()
    $ms.Dispose()
    Write-Host "Logotipo convertido e otimizado com sucesso!"
} else {
    Write-Error "Logotipo não encontrado no caminho relativo: $srcPath"
}
