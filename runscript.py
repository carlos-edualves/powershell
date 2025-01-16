import subprocess

#subprocess.Popen(["powershell.exe", "-Command", "C:\Users\Administrador\charts\powershell\DatadogSendCheck.ps1"])


output = subprocess.Popen(['powershell.exe', "C:\\Users\\Administrador\\charts\\powershell\\DatadogSendCheck.ps1"], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

print(output.stdout.read().decode().strip())
