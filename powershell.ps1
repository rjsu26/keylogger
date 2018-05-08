Param(   [String]$Att, 
         [String]$Subj,
         [String]$Body
     )
     
Function Send_EMail 
{
    Param( 
            [Parameter(`
            Mandatory=$true)]
            [String]$To , 
            [Parameter ( `
            Mandatory=$true)]
            [String]$From,
            [Parameter(`
            Mandatory=$true)]
            [String]$Password,
            [Parameter ( `
            Mandatory=$true)]
            [String]$subject,
            [Parameter ( `
            Mandatory=$true)]
            [String]$Body,
            [Parameter ( `
            Mandatory=$true)]
            [String]$attachment
          )

  try
   {
    $Msg = New-Object System.Net.Mail.MailMessage($From, $To, $subject, $Body)
    $Srv = " smtp.gmail.com"
    if ( $attachment -ne $null)
    {
        try 
        {
            $Attachments= $attachment -split ( "\:\:");

            ForEach ( $val in $Attachments)
            {
                $attch = New-Object System.Net.Mail.Attachment($val)
                $Msg.Attachments.Add($attch)
            }
        }

        catch
        {
            exit 2;
        }

        $client = New-Object net.Mail.SmtpClient($Srv, 587)
        $client.EnableSsl= $true
        $client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password);
        $client.Send($Msg)
        Remove-Variable -Name client 
        Remove -Variable -Name Password
        exit 7;
    }
    }

  catch 
    {
        exit 3;
    }


}

try 
{
    Send-Email
        -attachment $Att
        -To "Address of the recipient"
        -Body $Body
        -Subject $Subj
        -password "your password"
        -From "Address of the sender"
}  

catch 
{
    exit 4;
}