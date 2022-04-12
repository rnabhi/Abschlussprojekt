# Systeminformationen auffrufen und in Textdatei speichern

#Hello World
$RechnerInformationenAll = Get-ComputerInfo
$RechnerInformationenAll > C:\Users\10628594\Desktop\testausgaben\rechnerInformationen.txt

#Nur die wichtigen Daten werden für Computerinfo selektiert
$RechnerInformationenSelected=@($RechnerInformationenAll | Select-Object -Property CsName, CsDomain, CSModel, CSTotalPysicalMemory, CSUserName)

#IP Configuration

$head = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style>
<title>Systemdaten</title>"
$IpInfos = Get-NetIPAddress
$IpInfos > C:\Users\10628594\Desktop\testausgaben\IPAdressen.txt
$IpInfos | Select-Object -

$IpInfos|ConvertTo-Html -Head $head | Out-File C:\Users\10628594\Desktop\testausgaben\IPAdressen.html


$RechnerInformationenSelected+=$IpInfos
$RechnerInformationenSelected
$RechnerInformationenSelected.Count

#$RechnerInformationenSelected+$IpInfos| ConvertTo-Html > C:\Users\10628594\Desktop\testausgaben\Computerinfo.html

$head = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style>
<title>Systemdaten</title>"

$datum = Get-Date -Format "dd.MM.yyyy, HH:mm"

$RechnerInformationenSelected|ConvertTo-Html -Head $head -PreContent "<h1>Report erzeugt von $env:USERNAME am $datum</h1>" | Out-File "C:\Users\10628594\Desktop\testausgaben\Computerinfo.html"





# Codierung auf privaten Rechner ausprobieren

<#

$aeskeypath = ".\aeskey.key"
$AESKey = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
Set-Content $aeskeypath $AESKey 

#>



#CsDNSHostName, CsModel, CsName, CsPCSystemType

##Lädt Infos der Textdatei in die Variable.
<#
$ComputerListe = Get-Content -C:\Users\10628594\Desktop\testausgaben\rechnerInformationen.txt
 $logfile = "C:\Users\10628594\Desktop\testausgaben\testlog.txt"
 Add-Content $logfile -value 
 $logfile> 

 #>



#IP Configuration

Get-NetIPConfiguration
Get-NetIPAddress

#routing tabelle

#Get-NetRoute

#Test-DnsServer -ComputerName "10.255.255.254"  #funktioniert nicht

# Proxy-Einstellungen zeigen

# netsh winhttp show proxy

#Anzahl der Networkinterfaces/ Nachbarn / Network interface MAC address
#Get-NetAdapter
#Get-NetNeighbor

#Get-NetAdapter -Physical 
#Get-WiFiProfile -ProfileName rcaan

# Ping to default gateway

#Get-NetRoute -DestinationPrefix 0.0.0.0/0
#Test-Connection -ComputerName 192.168.0.1

#tracert google.com
