# Email configuration NO AUTH NO SECURE
$emailHost = "smtp-mail.outlook.com"
$emailUser = "abhilash.roy-nalpathamkalam@tk-steel.com"
$emailPass = "xxxxxx!"
$emailFrom = "abhilash.roy-nalpathamkalam@steeleurope.com"
$emailsTo=@("abhiarn@gmx.de")
$emailSubject = $title
$emailbody=$body
$attachment1 = 'C:\Users\10628594\Desktop\testausgaben\Zusammen.html'


$msg = New-Object System.Net.Mail.MailMessage
$msg.from = ($emailFrom)
    foreach ($d in $emailsTo) {    
    $msg.to.add($d)
    }
$msg.Subject = $emailSubject
$msg.Body = $emailbody
$msg.isBodyhtml = $true   

$att = new-object System.Net.Mail.Attachment($attachment1)
$msg.Attachments.add($att)

$smtp = New-Object System.Net.Mail.SmtpClient $emailHost
$smtp.Credentials = New-Object System.Net.NetworkCredential($emailUser, $emailPass);
  $smtp.send($msg)
  $att.Dispose()