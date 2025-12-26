## Azure Monitor Setup with CPU Alert Rules
## Requires: Az.Monitor module

## Install required modules
#Install-Module Az -Force -AllowClobber -Scope CurrentUser

## Connect to Azure
#Connect-AzAccount

## Set variables
#$resourceGroupName = "myUUUniqueNameGroup"
#$location = "southeastasia"
#$WEB_APP = "myUUUniqueApp"
#$alertName = "HighCPUAlert"
#$actionGroupName = "myActionGroup"
#$emailAddress = "brucelee012345@gmail.com"

## Create Action Group for notifications
#$actionGroup = New-AzActionGroup `
#	-ResourceGroupName $resourceGroupName `
#	-Name $actionGroupName `
#	-ShortName "MyAlert"

## Add email receiver to action group
#Add-AzActionGroupReceiver `
#	-ActionGroup $actionGroup `
#	-Name "EmailReceiver" `
#	-EmailReceiver `
#	-EmailAddress $emailAddress

## Get the Web App resource ID
#$webApp = Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $WEB_APP
#$resourceId = $webApp.Id

## Update metric alert criteria for Web App
#$criteria = New-AzMetricAlertRuleV2Criteria `
#    -MetricName "Http 5xx" `
#    -MetricNamespace "Microsoft.Web/sites" `
#    -Name "HTTP Error Alert Condition" `
#    -Operator GreaterThan `
#    -Threshold 5 `
#    -Aggregation Total `
#    -TimeAggregationOperator Average

## Create metric alert for HTTP errors
#$alert = Add-AzMetricAlertRuleV2 `
#    -Name $alertName `
#    -ResourceGroupName $resourceGroupName `
#    -WindowSize 00:05:00 `
#    -Frequency 00:01:00 `
#    -TargetResourceId $resourceId `
#    -Criteria $criteria `
#    -ActionGroup $actionGroup `
#    -Severity 3 `
#    -Description "Alert when HTTP 5xx errors exceed 5 in 5 minutes"

#Write-Host "Azure Monitor setup completed successfully"
#Write-Host "Alert Rule: $($alert.Name)"
#Write-Host "Action Group: $($actionGroup.Name)"

$resourceGroup = "myUUUniqueNameGroup"
$webAppName = "myUUUniqueApp"
az monitor metrics alert create `
  --name "HighCPUAlert" `
  --resource-group $resourceGroup `
  --scopes $(az webapp show --name $webAppName --resource-group $resourceGroup --query id -o tsv) `
  --condition "avg Percentage CPU > 80" `
  --description "CPU usage is high." `
  --window-size 5m `
  --evaluation-frequency 1m