$Api_Key = ""
$App_Key = ""
$url = "https://api.datadoghq.com/api/v1/monitor?api_key=$Api_Key&application_key=$App_Key"
$monitors = Invoke-RestMethod -Uri $url -Method Get
$count=0
foreach ($monitor in $monitors){
        $monitor_query = $monitor.query | Select-String -Pattern ".*apdex.*" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value } | Get-Unique
        if ($monitor_query){
            $monitor_message = $monitor.message | Select-String -Pattern "@victorops\S+(?={{)|@victorops\S+" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value }
                if ($monitor_message){
                    $monitor_id = $monitor.id
                    $url_message = "https://api.datadoghq.com/api/v1/monitor/" + "$monitor_id" + "?api_key=$api_key" + "&" + "application_key=$app_key"
                    $monitor_message_default = $monitor.message
                    $monitors_message_changed = $monitor_message_default -replace $monitor_message,""
                    $body_message = '{"message": "altera_mensagem"}' 
                    $body_message = $body_message -replace "altera_mensagem",$monitors_message_changed -replace "`n"," "
                    #Invoke-RestMethod -Method Put -Uri $url_message -Body $body_message
                    #write-host "-----------------------------------------------------"
                    write-host $monitor.id  -ForegroundColor cyan -NoNewline
                    write-host $monitor.message -ForegroundColor magenta
                    #write-host "-----------------------------------------------------"
                    $count++ 
                 }
         }


}
$count