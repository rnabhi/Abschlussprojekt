$fromaddress = "abhilash.roy-nalpathamkalam@tk-steel.com" 
$toaddress = "abhiar@gmx.de" 
$Subject = "Test message" 
$body = "Please find attached - test"
$attachment = "C:\Users\10628594\Desktop\testausgaben\Zusammen.html" 
$smtpserver = "smtp-mail.outlook.com"

$message = new-object System.Net.Mail.MailMessage 
$message.From = $fromaddress 
$message.To.Add($toaddress)
$message.IsBodyHtml = $True 
$message.Subject = $Subject 
$attach = new-object Net.Mail.Attachment($attachment) 
$message.Attachments.Add($attach) 
$message.body = $body 
$smtp = new-object Net.Mail.SmtpClient($smtpserver) 
$smtp.Send($message)