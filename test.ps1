<#class Benutzer
{

[int32] $ID
[string] $Name
[Datetime] $Erstellungsdatum

}


$a= [Benutzer]::new()
$a.ID = 001
$a.Name = "Abhilash"
$a.Erstellungsdatum = Get-Date
$a #>

Get-ComputerInfo -Property *Domain*
