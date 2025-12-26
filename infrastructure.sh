#!/bin/bash

# Set variables
RESOURCE_GROUP="myUUUniqueNameGroup"
LOCATION="southeastasia"
APP_SERVICE_PLAN="myUUUniqueAppServicePlan"
WEB_APP="myUUUniqueApp"

# Create Resource Group
echo "Creating Resource Group..."
az group create \
	--name $RESOURCE_GROUP \
	--location $LOCATION

# Create App Service Plan
echo "Creating App Service Plan..."
az appservice plan create \
	--name $APP_SERVICE_PLAN \
	--resource-group $RESOURCE_GROUP \
	--sku B1 \
	--is-linux

# Create Web App
echo "Creating Web App..."
az webapp create \
	--resource-group $RESOURCE_GROUP \
	--plan $APP_SERVICE_PLAN \
	--name $WEB_APP \
	--runtime "NODE|24-lts"

echo "Web App created: $WEB_APP"