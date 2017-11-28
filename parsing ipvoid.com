$ie = New-Object -ComObject InternetExplorer.Application
$ie.visible = $false
$ie.Navigate2(http://www.ipvoid.com/ip-blacklist-check/)
while($ie.Busy){Start-sleep 1}
$ie.Document.getElementById("ipAddr").value =  "122.58.116.240"
$btn=$ie.Document.getElementsByTagName("button") |  Where-Object { $_.className -eq "btn btn-primary" }
$btn.click()
$str= %{ ($ie.Document.body.document.getElementsByTagName("table") |  Where-Object {$_.getAttributeNode('class').value -eq "table table-striped table-bordered"})[0].innertext.replace("`n",";").split(";")}
