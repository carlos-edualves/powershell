Write-host "coletando os monitores" -backgroundcolor red -ForegroundColor white
$Api_Key = ""
$App_Key = ""
$url = "https://api.datadoghq.com/api/v1/monitor?api_key=$Api_Key&application_key=$App_Key"
$monitors = Invoke-RestMethod -Uri $url -Method Get
$totalmonitors = $monitors.Count
Write-host "Monitores coletados, Total de monitores: " -NoNewline
write-host $totalmonitors -backgroundcolor magenta -ForegroundColor white
$count=0
$countrota=0
$countnorota=0
$cabecalho = @("Nome do Monitor;Rotas") #cabeçalho do arquivo
foreach ($monitor in $monitors){
        $monitor_message = $monitor.message | Select-String -Pattern "@teams\w+(?={{)|@teams-\S+|@victorops\S+(?={{)|@victorops\S+" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value }  #pega o campo message e filtra por victorops e team     
        $monitor_name = $monitor.name #salva nome do monitor
        $percentcomplete = ($count / $totalmonitors) * 100
        $actualpercent = ([math]::Round($percentcomplete))
        if ($monitor_message){          
                    write-host $monitor_name " | " -ForegroundColor cyan -NoNewline
                    write-host $monitor_message -ForegroundColor magenta 
                    $cabecalho += @("$monitor_name;$monitor_message")
                    $count++
                    $countrota++
                    Write-Progress -Activity "Filtrando monitores" -Status "$actualpercent% Completo:" -PercentComplete $percentcomplete
         }
        else {
                    write-host $monitor_name " | " -ForegroundColor yellow -NoNewline
                    write-host "Sem rota" -ForegroundColor red 
                    $cabecalho += @("$monitor_name;sem rota")
                    $count++
                    $countnorota++
                    Write-Progress -Activity "Filtrando monitores" -Status "$actualpercent% Completo:" -PercentComplete $percentcomplete
        }  

}
$cabecalho > "$HOME\documents\export_datadog_$((Get-Date).Day)-$((Get-Date).Month)-$((Get-Date).Year).csv"
write-host "-----------------------------------------------------"
write-host "                Script Finalizado                      " -BackgroundColor Green -ForegroundColor black
write-host "              Total de monitores: " -NoNewline 
write-host  $totalmonitors -ForegroundColor red
write-host "              Total de monitores com rota: " -NoNewline 
write-host $countrota -ForegroundColor Yellow
write-host "              Total de monitores sem rota: " -NoNewline 
write-host $countnorota -ForegroundColor cyan
write-host "-----------------------------------------------------"
write-host "Arquivo no criado no diretório: $HOME\documents\export_datadog_$((Get-Date).Day)-$((Get-Date).Month)-$((Get-Date).Year).csv"  -BackgroundColor Green -ForegroundColor black

Read-Host -Prompt "Aperte qualquer tecla para finalizar..."