#script altera policy e action para envio de alertas no appdynamics
$usuario = Read-Host "Usuario do AppDynamics"
$senha = Read-Host "senha"
$token = "$usuario@<empresa>:$senha"
$base64token = [System.Convert]::ToBase64String([char[]]$token);
$i = "sim"
Clear-Host
$Headers = @{
    Authorization = 'Basic {0}' -f $base64token;
};

while ($i -eq 'sim') {
    $id = Read-Host "Id da aplicacao"
    $reqtemplate = Read-Host "Request template da tribo exemplo: <template a alterar>"
    $controlleraction = "https://<empresa>.saas.appdynamics.com/controller/alerting/rest/v1/applications/$id/actions"
    $controllerpolicy = "https://<empresa>.saas.appdynamics.com/controller/alerting/rest/v1/applications/$id/policies"
    $action = @{"actionType" = "HTTP_REQUEST"; "name" = "VictorOps"; "httpRequestTemplateName" = "$reqtemplate"; }
    $policy = (Get-Content ".\Policy.json") -replace "{{squad}}", $reqtemplate
    Invoke-RestMethod -headers $Headers -Uri $controlleraction -Method "POST" -Body ($action | ConvertTo-Json) -ContentType "application/json"
    Invoke-RestMethod -headers $Headers -Uri $controllerpolicy -Method "POST" -Body ($policy) -ContentType "application/json"


    $i = Read-Host "deseja adicionar outra? sim/nao"
}
