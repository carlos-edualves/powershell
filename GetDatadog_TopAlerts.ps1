$app_key = ""
$api_key = "" 
$url = "https://api.datadoghq.com/api/v1/monitor" + "?api_key=$api_key" + "&" + "application_key=$app_key"
$monitor = Invoke-RestMethod -Method get -Uri $url 
$monitor_id=import-csv .\datadog-export.csv | ForEach-Object {$_."MONITOR ID" , $_."COUNT"}
$monitor_count=import-csv .\datadog-export.csv | ForEach-Object {$_."COUNT" }
$cabecalho = @("MonitorID;MonitorName")
foreach ($monitor_ids in $monitor_id) { 
    $url_monitor = "https://api.datadoghq.com/api/v1/monitor/$monitor_ids" + "?api_key=$api_key" + "&" + "application_key=$app_key" 
    $monitor_name = Invoke-RestMethod -Method get -Uri $url_monitor
    $monitor_name1 = $monitor_name.name
    $monitor_tags = $monitor_name.tags 
    write-host $monitor_ids $monitor_name1 $monitor_tags
    $cabecalho += @("$monitor_ids;$monitor_name1;$monitor_tags")
    }
    $cabecalho > .\MonitorxName.csv
    Clear-Variable cabecalho


$monitor_count