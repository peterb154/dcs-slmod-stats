while ($true) {
    Write-host -NoNewLine "$(Get-Date) - Sending: "
    Get-ChildItem ..\Slmod\*Stats.lua | ForEach-Object {
        Write-host -NoNewLine " $($_.Name)"
        lua lua2json.lua "..\Slmod\$($_.Name)" | aws s3 cp - s3://dcs.362fs.com.stats/$($_.Name).json
    }
    Write-host "... Sleeping 60 seconds"
    Start-Sleep -Seconds 60
}
