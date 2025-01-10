#script criado para distribuir ícones de acesso remoto em máquinas linux que dão boot remoto pxe
Write-Host "Rodando script no servidor" $env:COMPUTERNAME -BackgroundColor black -ForegroundColor Green
$arraylojas = 1..45
$arraylojas2 = "00","01","02","03","04","05","06","07","08","09"
$arrayusers = "a","b","c","d","e","f","g","h","i"
$diretorioloja = "C:\Users\loja";
$diretoriocaixa = "C:\Users\caixa";
$filedir = "C:\Icones\*";
for ($i = 0; $i -lt ($arraylojas.length); $i +=1)
{
    for ($y = 0; $y -lt ($arrayusers.length); $y +=1)
    {
        $fileexists1 = Test-Path $diretorioloja$($arraylojas[$i])$($arrayusers[$y])
        if ($fileexists1 -eq $true)
        {
          Write-Host $diretorioloja$($arraylojas[$i])$($arrayusers[$y]) "existe" -ForegroundColor Green  
          #Copy-Item -Path $filedir -Destination $diretorioloja$($arraylojas[$i])$($arrayusers[$y])"\Desktop" -Recurse
        }
        else {
          Write-Host $diretorioloja$($arraylojas[$i])$($arrayusers[$y]) "nao existe" -ForegroundColor Red
        }

      
    }
}
Write-Host "Copiando diretorios lojas fora do padrao" -BackgroundColor black -ForegroundColor Green
Start-Sleep -s 2
for ($j = 0; $j -lt ($arraylojas2.length); $j +=1)
{
  for ($y = 0; $y -lt ($arrayusers.length); $y +=1)
  {
    $fileexists2 = Test-Path $diretorioloja$($arraylojas2[$j])$($arrayusers[$y])
 
    if ($fileexists2 -eq $true)
    {
      Write-Host $diretorioloja$($arraylojas2[$j])$($arrayusers[$y]) "existe" -ForegroundColor Green 
      #Copy-Item -Path $filedir -Destination $diretorioloja$($arraylojas2[$j])$($arrayusers[$y])"\Desktop" -Recurse
    }
    else 
    {
      Write-Host $diretorioloja$($arraylojas2[$j])$($arrayusers[$y]) "nao existe" -ForegroundColor red 
     
    }
  
  }
}

Copy-Item -Path $filedir -Destination $diretorioloja"00d.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"8c.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"14a.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"15c.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"37a.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"43b.EMPRESA\Desktop" -Recurse
Copy-Item -Path $filedir -Destination $diretorioloja"44c.EMPRESA\Desktop" -Recurse


Write-Host "copiando pros diretorios caixas" -BackgroundColor black -ForegroundColor Green
Start-Sleep -s 2
for ($i = 1; $i -lt ($arraylojas.length); $i +=1){
    $fileexists3 = Test-Path $diretoriocaixa$($i)
  if ($fileexists3 -eq $true){
      Write-Host $diretoriocaixa$($i) "encontrado" -ForegroundColor Green
      #Copy-Item -Path $filedir -Destination $diretoriocaixa$($i)"\Desktop" -Recurse
  }
  else {
    Write-Host $diretoriocaixa$($i) "nao encontrado" -ForegroundColor red
  }
}

for ($i = 0; $i -lt ($arraylojas2.length); $i +=1){
 
  $fileexists3 = Test-Path $diretoriocaixa$($arraylojas2[$i])
  if ($fileexists3 -eq $true)
  {
      Write-Host $diretoriocaixa$($arraylojas2[$i]) "encontrado" -ForegroundColor Green
      #Copy-Item -Path $filedir -Destination $diretoriocaixa$($arraylojas2[$i])$($arrayusers[$y])"\Desktop" -Recurse
  }
  else 
  {
      Write-Host $diretoriocaixa$($arraylojas2[$i]) "nao encontrado" -ForegroundColor red
  }
}
