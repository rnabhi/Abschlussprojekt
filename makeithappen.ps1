$path = "C:\Users\10628594\Desktop\testausgaben\"

# Systeminformationen auffrufen und in Textdatei speichern

$RechnerInformationenAll = Get-ComputerInfo
$RechnerInformationenAll > C:\Users\10628594\Desktop\testausgaben\rechnerInformationen.txt


#Nur die wichtigen Daten werden für Computerinfo selektiert uns in html gespeichert
$RechnerInformationenSelected=@($RechnerInformationenAll | Select-Object -Property CsName, CsDomain, CSModel, CSTotalPysicalMemory, CSUserName)

$head01 = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style> "

$datum = Get-Date -Format "dd.MM.yyyy, HH:mm"

$RechnerInformationenSelected=$RechnerInformationenSelected |ConvertTo-Html -Head $head01 -PreContent "<h1>Systemdaten</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>"

$RechnerInformationenSelected| Out-File "C:\Users\10628594\Desktop\testausgaben\Computerinfo.html"

#IP Configuration analog zu ComputerInfo (Textdatei und HTML)

$IpInfos = Get-NetIPAddress
$IpInfos > C:\Users\10628594\Desktop\testausgaben\IPAdressen.txt

$IpInfosSelected=$IpInfos | Select-Object -Property AddressFamily, IPv4Address, IPv6Address, PrefixLength, InterfaceAlias, IPAddress

$IpInfosSelected=$IpInfosSelected | ConvertTo-Html -Head $head01 -PreContent "<h1>IP-Konfiguration</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>"
$IpInfosSelected | Out-File C:\Users\10628594\Desktop\testausgaben\IPAdressen.html



#routing tabelle

$routingtabelle = Get-NetRoute

$routingtabelle | ConvertTo-Html -Head $head01 -PreContent "<h1> Routing Tabelle </h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>" | Out-File $path\routingtabelle.html

#Zusammenführen der verschiedenen HTML-Seiten in einen HTML-Report

$output=@()  # Array

$content01 = Get-Content $path\Computerinfo.html    #herauslesen des HTML-Inhalts
$content02 = Get-Content $path\IPAdressen.html
$content03 = Get-Content $path\routingtabelle.html

$output += $content01 + $content02 + $content03 #Inhalt in Array speichern


$output | Out-File C:\Users\10628594\Desktop\testausgaben\Zusammen.html  # HTML-Seite mit Zusammenfassung aller Reports kreiieren





# Codierung auf privaten Rechner ausprobieren

<#

$aeskeypath = ".\aeskey.key"
$AESKey = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
Set-Content $aeskeypath $AESKey 

#>









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
