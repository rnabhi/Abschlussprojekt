 Add-Type -assembly System.Windows.Forms


#was ist der Sinn den nächsten zwei Zeilen?
#[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
#[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#Fenster
$main_form = New-Object System.Windows.Forms.Form
$main_form.Size = New-Object System.Drawing.Size(300,200)

$main_form.Text ='GUI zum Auslesen von Daten'
$main_form.StartPosition = "CenterScreen" 


$start_button = New-Object System.Windows.Forms.Button
$start_button.Location = New-Object System.Drawing.Size(100,120)
$start_button.Size = New-Object System.Drawing.Size(100,30)
$start_button.Text = "Starte Analyse"
$start_button.Add_Click(
{
    $P = Get-ComputerInfo
    $P > C:\Users\10628594\Documents\test\test2.txt
})


$main_form.Controls.Add($start_button)

 
 
$main_form.ShowDialog()
