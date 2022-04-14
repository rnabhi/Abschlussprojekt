# Systeminformationen auffrufen und in Textdatei speichern

$RechnerInformationenAll = Get-ComputerInfo
$RechnerInformationenAll > C:\Users\10628594\Desktop\testausgaben\rechnerInformationen.txt

#Nur die wichtigen Daten werden für Computerinfo selektiert uns in html gespeichert
$RechnerInformationenSelected=@($RechnerInformationenAll | Select-Object -Property CsName, CsDomain, CSModel, CSTotalPysicalMemory, CSUserName)

$head01 = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style>

<h1>Systemdaten</h1>"

$datum = Get-Date -Format "dd.MM.yyyy, HH:mm"

$RechnerInformationenSelected=$RechnerInformationenSelected |ConvertTo-Html -Head $head01 -PreContent "<h1>Report erzeugt von $env:USERNAME am $datum</h1>"

$RechnerInformationenSelected| Out-File "C:\Users\10628594\Desktop\testausgaben\Computerinfo.html"

#IP Configuration analog zu ComputerInfo (Textdatei und HTML)

$head02 = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style>

<h1>IP-Konfiguration</h1>"

$IpInfos = Get-NetIPAddress
$IpInfos > C:\Users\10628594\Desktop\testausgaben\IPAdressen.txt

$IpInfosSelected=$IpInfos | Select-Object -Property AddressFamily, IPv4Address, IPv6Address, PrefixLength, InterfaceAlias, IPAddress

$IpInfosSelected=$IpInfosSelected | ConvertTo-Html -Head $head02 -PreContent "<h1>Report erzeugt von $env:USERNAME am $datum</h1>"
$IpInfosSelected | Out-File C:\Users\10628594\Desktop\testausgaben\IPAdressen.html

#Zusammenführen der verschiedenen HTML-Seiten in einen HTML-Report

$file01 = C:\Users\10628594\Desktop\testausgaben\Computerinfo.html
$file02 = C:\Users\10628594\Desktop\testausgaben\IPAdressen.html

$output=@()

$content01 = Get-Content C:\Users\10628594\Desktop\testausgaben\Computerinfo.html
$content02 = Get-Content C:\Users\10628594\Desktop\testausgaben\IPAdressen.html

$output += $content01
$output += $content02
$output.count

$output | Out-File C:\Users\10628594\Desktop\testausgaben\Zusammen.html


<#
$test=@($RechnerInformationenSelected, $IpInfosSelected)
$test.Count
$test | ConvertTo-Html | Out-File C:\Users\10628594\Desktop\testausgaben\siehmalan.html

</#>

$RechnerInformationenSelected+=$IpInfos
$RechnerInformationenSelected
$RechnerInformationenSelected.Count

#$RechnerInformationenSelected+$IpInfos| ConvertTo-Html > C:\Users\10628594\Desktop\testausgaben\Computerinfo.html







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
