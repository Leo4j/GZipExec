# GZipExec

```
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Leo4j/GZipExec/refs/heads/main/GZipExec.ps1')
```

```
GZipExec H4sIAAAAAAAEACvPyE/MzQQAAirKwAYAAAA=
```

## How to GZip compress a string

### Define the text you want to compress
```
$textToCompress = "This is the text you want to compress"
```

### Finally run the following
```
$bytesToCompress = [System.Text.Encoding]::UTF8.GetBytes($textToCompress)
$memoryStream = [System.IO.MemoryStream]::new()
$gzipCompressor = [System.IO.Compression.GzipStream]::new($memoryStream, [System.IO.Compression.CompressionMode]::Compress)
$gzipCompressor.Write($bytesToCompress, 0, $bytesToCompress.Length)
$gzipCompressor.Close()
$compressedBytes = $memoryStream.ToArray()
$compressedBase64 = [Convert]::ToBase64String($compressedBytes)
$compressedBase64
```
