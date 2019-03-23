##################################################################################################################################################
## read the data of the clients (from mailData.txt file) that have report stmts and then check which pdf stmts have created successfully or not..#
## if the pdf was created successfully it writes its name, mail and ID in txt file (pdf_created.txt)                                             #
## if it is not created then write it in another txt file (pdf_not_created.txt)                                                                  #
##################################################################################################################################################

Param
(
    [Parameter(Mandatory = $true)]
    [String]$ExistedPDFsLogPath,
    [Parameter(Mandatory = $true)]
    [String]$PDFCreatedLog,
    [Parameter(Mandatory = $true)]
    [String]$NotExistedPDFsLogPath,
    [Parameter(Mandatory = $true)]
    [String]$PDFNotCreatedLog,
    [Parameter(Mandatory = $true)]
	[String]$MailDataPath,
    [Parameter(Mandatory = $true)]
	[String]$PDFPath
)


$ExistedPDFsLogPath = $ExistedPDFsLogPath+$PDFCreatedLog #Destination path of log file of created pdfs
$NotExistedPDFsLogPath = $NotExistedPDFsLogPath+$PDFNotCreatedLog #Destination path of log file of pdfs that were not created


#clear any data written in log files
if(Test-Path $ExistedPDFsLogPath)
{
Clear-Content $ExistedPDFsLogPath 
}
if(Test-Path $NotExistedPDFsLogPath)
{
Clear-Content $NotExistedPDFsLogPath
} 


#read line by line from MailData file
foreach($line in Get-Content $MailDataPath) {
    $PDFName, $ReciepientEmail = $line.Split(',')[4],$line.Split(',')[3]
    
    #The structure of the output file
    $RecipientLine = $ReciepientEmail + "," +$PDFName

    
    $PDFsFilePath = "$PDFPath"+"$PDFName"  #path of folder that have the created PDFs
    
    if(Test-Path $PDFsFilePath)
    {
        #condition to check if the file exist,write it in log file of created pdf
        Add-Content $ExistedPDFsLogPath $line

    }
    else
    {
        #condition to check if the file not exist,write it in log file of pdf that not created
        Add-Content $NotExistedPDFsLogPath $RecipientLine
        
    }
}