function GZipExec {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$GZipParts
    )

    $GZipString = $GZipParts -join ' '

    try {
        $bytes = [Convert]::FromBase64String($GZipString)
    }
    catch {
        Write-Error "Invalid base64 string provided."
        return
    }

    $inputStream = New-Object System.IO.MemoryStream(, $bytes)
    
    try {
        $gzipStream = New-Object System.IO.Compression.GzipStream($inputStream, [System.IO.Compression.CompressionMode]::Decompress)
        $outputStream = New-Object System.IO.MemoryStream

        $gzipStream.CopyTo($outputStream)
        
        $gzipStream.Close()
        $inputStream.Close()

        $outputStream.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null

        $scriptText = [System.Text.Encoding]::UTF8.GetString($outputStream.ToArray())
        $outputStream.Close()

        Invoke-Expression $scriptText
    }
    catch {
        Write-Error "An error occurred while decompressing or executing the code."
    }
}
