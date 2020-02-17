 # Get All Mission Stats
Write-host -NoNewLine "$(Get-Date) - Sending Once: "
Get-ChildItem "..\Slmod\Mission Stats\*.lua" | ForEach-Object {
    Write-host -NoNewLine " $($_.Name)"
    lua lua2json.lua "..\Slmod\Mission Stats\$($_.Name)" | aws s3 cp - s3://dcs.362fs.com.stats/Slmod/MissionStats/$($_.Name).json
}
    Write-host "... done"
while ($true) {
    Write-host -NoNewLine "$(Get-Date) - Sending: "
    # Get Slmod Stats
    Get-ChildItem ..\Slmod\*Stats.lua | ForEach-Object {
        Write-host -NoNewLine " $($_.Name)"
        lua lua2json.lua "..\Slmod\$($_.Name)" | aws s3 cp - s3://dcs.362fs.com.stats/Slmod/$($_.Name).json
    }
    # Get Mission Stats
    Get-ChildItem "..\Slmod\Mission Stats\*.lua" | sort LastWriteTime -Descending | select -last 1 | ForEach-Object {
        Write-host -NoNewLine " $($_.Name)"
        lua lua2json.lua "..\Slmod\Mission Stats\$($_.Name)" | aws s3 cp - s3://dcs.362fs.com.stats/Slmod/MissionStats/$($_.Name).json
    }
    Write-host "... Sleeping 300 seconds"
    Start-Sleep -Seconds 300
}
