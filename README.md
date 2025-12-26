Goal: to use Copilot to automate infrastructure, CI/CD, and monitoring as part of a complete DevOps workflow.
az login
generate code 
run infrastructure.sh in terminal: ./infrastructure.sh

You Try It! Automating and Optimizing DevOps Workflows - Answer Key
Step 2: Generate Automation Scripts
infrastructure.sh
#!/bin/bash
RESOURCE_GROUP="CopilotDevOpsRG"
LOCATION="eastus"
APP_SERVICE_PLAN="CopilotPlan"
WEBAPP_NAME="copilot-webapp-demo"
az group create --name $RESOURCE_GROUP --location $LOCATION
az appservice plan create --name $APP_SERVICE_PLAN --resource-group $RESOURCE_GROUP --sku B1 --is-linux
az webapp create --resource-group $RESOURCE_GROUP --plan $APP_SERVICE_PLAN --name $WEBAPP_NAME --runtime "NODE|14-lts"

.github/workflows/ci-cd-pipeline.yml
name: Deploy to Azure Web App
on:
  push:
    branches:
      - main
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '14'
    - run: npm install
    - run: npm run build
    - name: Deploy to Azure
      uses: azure/webapps-deploy@v2
      with:
        app-name: 'copilot-webapp-demo'
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: '.'

monitoring-setup.ps1
$resourceGroup = "CopilotDevOpsRG"
$webAppName = "copilot-webapp-demo"
az monitor metrics alert create `
  --name "HighCPUAlert" `
  --resource-group $resourceGroup `
  --scopes $(az webapp show --name $webAppName --resource-group $resourceGroup --query id -o tsv) `
  --condition "avg Percentage CPU > 80" `
  --description "CPU usage is high." `
  --window-size 5m `
  --evaluation-frequency 1m
