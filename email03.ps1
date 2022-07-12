Function sendmail($FROM,$TO,$SUBJECT,$BODY,[System.IO.FileInfo[]]$ATTACHMENTS = $null){
    $SMTPHOST = "mail.gmx.net "
    $SMTPPORT = 587
    $SMTPUSER = "abhiarn@gmx.de"
    $SMTPPass = "xxxxxxx"
    $SMTPClient = New-object System.Net.Mail.SmtpClient($SMTPHOST,$SMTPPORT)
    $SMTPClient.EnableSsl = $true
    $Mail = new-object System.Net.Mail.MailMessage
    $Mail.from = $FROM 
    $Mail.to.add($TO)
    $SMTPClient.Credentials = new-object System.Net.NetworkCredential($SMTPUSER,$SMTPPass)
    $Mail.Subject = $SUBJECT
    $Mail.Body = $BODY
    # Add Attachments
    if ($ATTACHMENTS){
        foreach ($att in $ATTACHMENTS){
          $Mail.Attachments.Add($att.FullName)
        }
    }
    $SMTPClient.Send($Mail)
    $smtpclient.Dispose()
    $mail.Dispose()
  }
  Send-MailMessage -From "abhiarn@gmx.de" -to "abhilash.roy.n@gmail.com" -Subject "Dienst läuft nicht"-SmtpServer smtp-mail.outlook.com -Credential (New-Object PSCredential("USERNAME",(ConvertTo-SecureString 'PASSWORD' -AsPlainText -Force))) -UseSSL -Attachments "C:\Users\10628594\Desktop\testausgaben\Zusammen.html"
  