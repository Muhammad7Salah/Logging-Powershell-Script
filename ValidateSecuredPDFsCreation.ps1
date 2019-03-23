###############################################################################################################################################
##check the secured pdf files that was encrypted successfully                                                                                 #
## if the pdf file name exist in that file (pdf_created) then write it in log file that have encrypted pdf (pdf_secured_created)              #
## if the pdf file name not exist in that file (pdf_created) then write it in log file that have a non encrypted pdf (pdf_secured_not_created)#
###############################################################################################################################################

Param
(
    [Parameter(Mandatory = $true)]
    [String]$ExistedPdfSecuredLogPath,
    [Parameter(Mandatory = $true)]
    [String]$PdfSecuredCreated,
    [Parameter(Mandatory = $true)]
    [String]$ExistedPdfNotSecuredLogPath,
    [Parameter(Mandatory = $true)]
	[String]$PdfSecuredNotCreated,
    [Parameter(Mandatory = $true)]
	[String]$ExistedPDFsLogPath,
    [Parameter(Mandatory = $true)]
    [String]$PDFCreatedLog,
    [Parameter(Mandatory = $true)]
	[String]$PDFSecuredPath
)


$ExistedPdfSecuredLogPath = $ExistedPdfSecuredLogPath+$PdfSecuredCreated #Destination path of log file of created pdfs
$ExistedPdfNotSecuredLogPath = $ExistedPdfNotSecuredLogPath+$PdfSecuredNotCreated #Destination path of log file of pdfs that were not created


#$ExistedPdfSecuredLogPath  #Destination path of pdf that was encrypted
#$ExistedPdfNotSecuredLogPath #Destination path of pdf that wasnot encrypted
if(Test-Path $ExistedPdfSecuredLogPath)
{
Clear-Content $ExistedPdfSecuredLogPath 
}

if(Test-Path $ExistedPdfNotSecuredLogPath)
{
Clear-Content $ExistedPdfNotSecuredLogPath
}
#$PdfSecuredNotCreated #list of created pdf files

$PDFCreatedLog="$ExistedPDFsLogPath"+"$PDFCreatedLog"

foreach($line in Get-Content $PDFCreatedLog) {
    $ReciepientEmail, $PDFName = $line.Split(',')[3],$line.Split(',')[4]
    
    
    #The structure of the output file
    $ReciepientLine = $ReciepientEmail + "," +$PDFName

    $PDFsFilePath = "$PDFSecuredPath"+"$PDFName"  #path of folder that have secured pdf
    
    if(Test-Path $PDFsFilePath)
    {
        #condition to check if the file exist,write it in log file of pdf that was encrypted
        Add-Content $ExistedPdfSecuredLogPath $line
        
    }
    else
    {
        #condition to check if the file not exist,write it in log file of pdf that was not encrypted
        Add-Content $ExistedPdfNotSecuredLogPath $ReciepientLine
       
    }
}