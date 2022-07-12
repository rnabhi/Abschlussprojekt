$files = Get-ChildItem -Path C:\Windows
$files
$files.count

For($i = 1; $i -le $files.count; $i++)
{  

    #$i =($i / $files.count*100)
    Write-Progress -Activity "Collecting files here :)" -PercentComplete (($i*100)/$files.count) -Status "Finding file $($files[$i].Name)"
    sleep -Milliseconds 100
}
$files | Select name