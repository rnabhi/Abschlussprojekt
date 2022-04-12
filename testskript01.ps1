<#function CheckPing {
    param (
        [string]$ServerName
    )
    $result = "Fail"
    $ping = new-object system.net.networkinformation.ping
    $reply = $ping.Send($ServerName)
    if ($reply.status -eq "Success")
    {
        $result = "Pass"

    }

    return $result
}

#>


Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3"
[CA ]         –ComputerName N0003198 |
Select-Object –property DeviceID,@{Name='ComputerName';
Expression={$_.__SERVER}},Size,FreeSpace


Get-WmiObject -Class Win32_LogicalDisk -Filter "drivetype=3" -ComputerName localhost | Select-Object -Property DeviceID, @{name ='ComputerName';expression={$_.__SERVER}},Size,FreeSpace