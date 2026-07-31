# merge_museum.ps1
$files = @(
    "Themes.xml",
    "Collections.xml",
    "Artifacts.xml",
    "Exhibitions.xml",
    "Restoration.xml"
)

$output = "Museum_merged.xml"

$sb = New-Object System.Text.StringBuilder

$sb.AppendLine('<?xml version="1.0" encoding="UTF-8"?>') | Out-Null
$sb.AppendLine(
    '<Museum xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="./schemas/Museum.xsd">'
) | Out-Null

foreach ($f in $files) {
    [xml]$doc = Get-Content $f

    $root = $doc.DocumentElement

    # Remove schema information from the imported root element
    $root.RemoveAttribute(
        "noNamespaceSchemaLocation",
        "http://www.w3.org/2001/XMLSchema-instance"
    )
    $root.RemoveAttribute("xmlns:xsi")

    $sb.AppendLine($root.OuterXml) | Out-Null
}

$sb.AppendLine('</Museum>') | Out-Null

$sb.ToString() | Out-File -Encoding utf8 $output

Write-Host "Merged file written to $output"