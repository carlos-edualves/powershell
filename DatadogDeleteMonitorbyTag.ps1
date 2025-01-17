$Api_Key = ""
$App_Key = ""
$url = "https://api.datadoghq.com/api/v1/monitor?api_key=$Api_Key&application_key=$App_Key"
$monitors = Invoke-RestMethod -Uri $url -Method Get
$count=0
foreach ($monitor in $monitors){
        $monitor_name = $monitor.name | Select-String -Pattern "Monitor Padrao - Watchdog -.*" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value } | Get-Unique
        if ($monitor_name){
            $monitor_message = $monitor.tags | Select-String -Pattern ".*pattern.*" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value }
                if ($monitor_message){
                    #write-host $monitor.id " | "  -ForegroundColor cyan -NoNewline
                    #write-host $monitor.name -ForegroundColor magenta
                    $monitor_id = $monitor.id
                    $url = "https://api.datadoghq.com/api/v1/monitor/$monitor_id" + "?" + "api_key=$Api_Key&application_key=$App_Key"
                    Invoke-RestMethod -Method Delete -Uri $url
                    $count++
                 }
         }


}
$count