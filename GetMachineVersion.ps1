$values = Get-Content .\serverlist.json  | ConvertFrom-Json
$values.Count
$i = 1..198
$server = $values.properties.hostname
$agent = $values.properties."AppDynamics|Agent|Agent version" 

for ($y = 0; $y -le $i.lenght ; $y +=1){
write-host [$y]
}



foreach ($servers in $server){
    $servers
}

 foreach($agents in $agent){
    $agents
}