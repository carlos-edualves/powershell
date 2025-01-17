$Api_Key = ""
$App_Key = ""
$monitors =@(
 131411610
,131411611
,131411612
,131411614
,131411615
,131411616
,131411617
,131411618
,131411619
,131411620
,131411621
,131411622
,131411623
,131411624
)
foreach ($monitor in $monitors){
$url = "https://api.datadoghq.com/api/v1/monitor/$monitor" + "?" + "api_key=$Api_Key&application_key=$App_Key"
Invoke-RestMethod -Method Delete -Uri $url
}
