
# Lädt eine .NET-Klasse System.Windows.Forms in die PowerShell Session.
# Die Klasse kann Windows-Fenster instanziieren

Add-Type -assembly System.Windows.Forms

#Fenster zum Starten der Tests und Analysen

$main_form = New-Object System.Windows.Forms.Form
$main_form.Size = New-Object System.Drawing.Size(600,400)

$main_form.Text ='Tests und Analysen für Computersysteme und Netzwerkkommunikation'
$main_form.StartPosition = "CenterScreen" 

$start_button = New-Object System.Windows.Forms.Button
$start_button.Location = New-Object System.Drawing.Size(200,240)
$start_button.Size = New-Object System.Drawing.Size(100,30)
$start_button.Text = "Starte Analyse"

#Variable für den Verzeichnispfad im lokalen System

$path = "C:\Users\$env:USERNAME\Desktop\testausgaben\" 

# Funktion, die das Start-Fenster öffnet

$start_button.Add_Click(
 {

# Systeminformationen auffrufen und in Textdatei speichern

$RechnerInformationenAll = Get-ComputerInfo 
$RechnerInformationenAll > $path\rechnerInformationen.txt

#Nur die wichtigen Daten werden für Computerinfo selektiert,
# in ein Array gespeichert und als html-Datei exportiert

$RechnerInformationenSelected=@($RechnerInformationenAll | Select-Object -Property CsName, CsDomain, CSModel, CSTotalPysicalMemory, CSUserName)

#html- und css- code für die HTML-Seite

$head01 = "<style>
td {width:100px; max-width:300px; background-color:lightgrey;}
table {width:100%;}
th {font-size:14pt;background-color:yellow;}
</style> "

$datum = Get-Date -Format "dd.MM.yyyy, HH:mm"

$RechnerInformationenSelected=$RechnerInformationenSelected |ConvertTo-Html -Head $head01 -PreContent "<h1>Systemdaten</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>"

$RechnerInformationenSelected| Out-File "$path\Computerinfo.html"

#IP Configuration analog zu ComputerInfo (Textdatei und HTML)
<#
$GlobalIP = Invoke-RestMethod -Uri http://www.google.de
$PrivatIP = (Get-NetIPAddress -InterfaceIndex 11 -AddressFamily IPv4).IPAddress
Write-Host "Meine öffentliche IPv4 Adresse ist:" $GlobalIP
Write-Host "Meine private IPv4 Adresse ist:" $PrivatIP
#>

$IpInfos = Get-NetIPAddress
Get-NetIPAddress | Format-Table

$IpInfos > $path\IPAdressen.txt

$IpInfosSelected=$IpInfos | Select-Object -Property AddressFamily, IPv4Address, IPv6Address, PrefixLength, InterfaceAlias, IPAddress

$IpInfosSelected=$IpInfosSelected | ConvertTo-Html -Head $head01 -PreContent "<h1>IP-Konfiguration</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>"
$IpInfosSelected | Out-File $path\IPAdressen.html

#routing tabelle

$routingtabelle = Get-NetRoute

$routingtabelle | ConvertTo-Html -Head $head01 -PreContent "<h1> Routing Tabelle </h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>" | Out-File $path\routingtabelle.html

#  Alle DNS-Server IP-Adressen, die mit allen Interfaces
# des Rechners verbunden sind

$dns = Get-DnsClientServerAddress
$dns | ConvertTo-Html -Head $head01 -PreContent "<h1> DNS-Server IP-Adressen </h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>" | Out-File $path\dns.html


# Proxy-Einstellungen zeigen

netsh.exe winhttp show proxy > $path\proxyJaNein.txt

# Datei proxyJaNein.txt lesen und schauen, ob ein Proxy existiert oder nicht.

$wort = @('(ein Proxyserver).')  

$OCSlatest = (Get-ChildItem -Path 'C:\Users\10628594\Desktop\testausgaben\' -Filter 'proxyJaNein.txt' | Select-Object -First 1).fullname
if ($OCSlatest) {
    #we know we have a file
    $OCSlatest
    $search = (Get-Content $OCSlatest | Select-String -CaseSensitive $wort).Matches.Success
    if($search){
        $proxyJaNein  | ConvertTo-Html -Head $head01 -PreContent "<h1>Proxy</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2> <b>Proxy enthalten" | Out-File $path\proxyinfo.html
    } else {
        $proxyJaNein| ConvertTo-Html -Head $head01 -PreContent "<h1>Proxy</h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2> <b> KEIN Proxy!!!" | Out-File $path\proxyinfo.html
    }
}
else {
    "Keine Datei in $path gefunden"
}

#Anzahl der Networkinterfaces/ Nachbarn / Network interface MAC address
$adapter = Get-NetAdapter

$adapter | ConvertTo-Html -Head $head01 -PreContent "<h1> Netzwerk-Imnterfaces </h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>" | Out-File $path\netzwerkadapter.html

$macAdressen = Get-NetNeighbor

$macAdressen | ConvertTo-Html -Head $head01 -PreContent "<h1> Alle Mac-Adressen </h1> <h2>Report erzeugt von $env:USERNAME am $datum</h2>" | Out-File $path\Macadressen.html

#Ping bzw. Test-Connection zu bestimmten DNS-Servern


#Zusammenführen der verschiedenen HTML-Inhalte in einen HTML-Report

$output=@()  # Array

$content01 = Get-Content $path\Computerinfo.html    #herauslesen des HTML-Inhalts
$content02 = Get-Content $path\IPAdressen.html
$content03 = Get-Content $path\routingtabelle.html
$content04 = Get-Content $path\proxyinfo.html
$content05 = Get-Content $path\netzwerkadapter.HTML
$content06 = Get-Content $path\Macadressen.html

$output += $content01 + $content02 + $content03 + $content04 + $content05 + $content06 #Inhalt in Array speichern

$output | Out-File $path\Zusammenfassung.html  # HTML-Seite mit Zusammenfassung aller Reports kreiieren
$main_form.Close()
})

$main_form.Controls.Add($start_button)
 
$main_form.ShowDialog()





$FullPath='C:\Users\10628594\Desktop\testausgaben\'

 
#Das Outlook application object
Start-Process Outlook
$o = New-Object -com Outlook.Application
 
$mail = $o.CreateItem(0)
 
#2 = Die Wichtigkeit der Mail einstellen
$mail.importance = 2
 
$mail.subject = "HTML-Report"
$mail.body = "Diese Email wurde automatisch versendet"
 
#Email-Empfänger - mit ";" trennen
$mail.To = "abhilash.roy-nalpathamkalam@steeleurope.com"
#$mail.CC = <OTHER RECIPIENT 1>;<OTHER RECIPIENT 2>
 
# Iterate over all files and only add the ones that have an .html extension
$files = Get-ChildItem $FullPath
 
for ($i=0; $i -lt $files.Count; $i++) {
 
$outfileName = $files[$i].FullName
$outfileNameExtension = $files[$i].Extension
 
# if the extension is the one we want, add to attachments
if($outfileNameExtension -eq ".html")
{
$mail.Attachments.Add($outfileName);
}
}
$mail.Send()
 


# Codierung auf privaten Rechner ausprobieren

<#

$aeskeypath = ".\aeskey.key"
$AESKey = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
Set-Content $aeskeypath $AESKey 

#>



#Get-NetAdapter -Physical 
#Get-WiFiProfile -ProfileName rcaan

# Ping to default gateway

#Get-NetRoute -DestinationPrefix 0.0.0.0/0
#Test-Connection -ComputerName 192.168.0.1

#tracert google.com


<#
Test für PROGRESSBAR

Write-Output $RechnerInformationenAll

For($i = 1; $i -le $RechnerInformationenAll.count; $i++)
{
    Write-Progress -Activity "Haben Sie Geduld, Rechnerinformationen werden gesammelt" -PercentComplete (($i*100)/$RechnerInformationenAll.count) -Status "Finding file $($RechnerInformationenAll[$i].Name)"
    sleep -Milliseconds 100
}
#>



