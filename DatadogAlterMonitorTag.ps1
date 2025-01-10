#SCRIPT DE ALTERAÇÃO DE TAGS CRIADO POR CARLOS ALVES 138150
#FUNÇÃO: SCRIPT ALTERA A TAG DE MONITORES SELECIONADOS, PARA ADICIONAR TAGS BASTAS EDITAR O VALOR DA VARIÁVEL BODY
$app_key = ""
$api_key = ""
#PRENCHER A LISTA DE IDS COM IDS DA APLICAÇÃO
$api_list = get-content -Path "ids.txt"
#ALTERAR PARA O ENV DESEJADO ANTES DE RODAR
$env = 'env:prd'

#      /\
#      ||
#      ||
#      ||
#      ||
#   ALTERAR
if ($api_list){
$body = '{"tags":["env:env_prd","service:datadogservicename_service","watchdog:teste","tribo:zarp"]}'
$body = $body -replace 'env_prd',$env
    if($env){
        foreach ($i in $api_list){
            $url = "https://api.datadoghq.com/api/v1/monitor/" + "$i" + "?api_key=$api_key" + "&" + "application_key=$app_key"
            $monitor = Invoke-RestMethod -Method Get -Uri $url
            $monitor_name = $monitor.name | Select-String -Pattern "(?<=Monitor Padrao - Watchdog - )(.*)" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value } | Select-Object -First 1
            $bodyservice = $body -replace 'datadogservicename_service',$monitor_name
            write-host 'ID:'$i  -ForegroundColor Yellow -NoNewline
            write-host ' | Monitor alterado:' $monitor.name -ForegroundColor Magenta -NoNewline
            write-host ' | Tags adicionadas: '$bodyservice -ForegroundColor Cyan
            #Invoke-RestMethod -Method Put -Uri $url -Body $bodyservice
             }
        Write-host '✅Script Executado com sucesso!✅' -ForegroundColor green   
        Clear-Content -Path '.\ids.txt'                                           
        }
    else{
       Write-host '😡ENV NAO POPULADO😡' -ForegroundColor red                                                   
       write-host 'Popule a variável no início do script de acordo com o env desejado! '-ForegroundColor Yellow 
        }
    }
    else{
    $id_file = Get-ChildItem -Recurse  |Where-Object {($_.name -eq "ids.txt")}| %{$_.FullName}
    Write-host '                                      ###########################' -ForegroundColor red 
    Write-host '                                      #😡ARQUIVO NAO POPULADO😡#' -ForegroundColor red 
    Write-host '                                      ###########################' -ForegroundColor red 
    write-host 'PREENCHA COM OS IDS DAS MONITORES, ARQUIVO SE ENCONTRA EM: ' $id_file -ForegroundColor Yellow
    }
