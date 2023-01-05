/*
   Begin common prolog commands
   export APPSERVICE_SKU=P1V3
   export RUNTIME="DOTNET:6.0"
   export LINUX_PLAN=
   export ACR_SKU=Basic
   export name=qsuwc712o
   export REGISTRY=${name}reg
   export PLAN=${name}-plan
   export WEB=${name}-web
   export REPO=${name}-repo
   export IMAGE=${name}-image
   export loc=westus
   export rg=rg_BlazorSvrGitPlayWindowsDocker
   export loc=westus
   export PASSWORD=`az acr credential show --resource-group $rg --name $REGISTRY --query passwords[0].value --output tsv | sed 's/\r$//'`
   export USERNAME=`az acr credential show --resource-group $rg --name $REGISTRY --query username  --output tsv | sed 's/\r$//'`
   End common prolog commands

   emacs F10
   Begin commands to deploy this file using Azure CLI with bash
   echo WaitForBuildComplete
   WaitForBuildComplete
   echo "Previous build is complete. Begin deployment build."
   #az deployment group create --name $name --resource-group $rg   --template-file  deploy-BlazorSvrGitPlayWindowsDocker.bicep
   az acr create --resource-group $rg --name $REGISTRY  --sku $ACR_SKU --admin-enabled true
   echo end deploy
   az resource list -g $rg --query "[?resourceGroup=='$rg'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
   End commands to deploy this file using Azure CLI with bash

   emacs ESC 2 F10
   Begin commands to shut down this deployment using Azure CLI with bash
   echo CreateBuildEvent.exe
   CreateBuildEvent.exe&
   echo "begin shutdown"
   az deployment group create --mode complete --template-file ./clear-resources.json --resource-group $rg
   BuildIsComplete.exe
   az resource list -g $rg --query "[?resourceGroup=='$rg'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
   echo "showdown is complete"
   End commands to shut down this deployment using Azure CLI with bash

   emacs ESC 3 F10
   Begin commands for one time initializations using Azure CLI with bash
   az group create -l $loc -n $rg
   export id=`az group show --name $rg --query 'id' --output tsv`
   echo "id=$id"
   #export sp="spad_$name"
   #az ad sp create-for-rbac --name $sp --sdk-auth --role contributor --scopes $id
   echo "go to github settings->secrets and create a secret called AZURE_CREDENTIALS with the above output"
   cat >clear-resources.json <<EOF
   {
    "\$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "resources": [] 
   }
   EOF
   End commands for one time initializations using Azure CLI with bash

   https://stackoverflow.com/questions/52941130/how-to-run-my-application-on-windows-container-in-azure#:~:text=For%20the%20container%20on%20Windows%2C%20you%20can%20create,windows%20service%20plan%20is%20in%20the%20preview%20version.
   ERROR: Apps running on Windows Containers are available only in Hyper-V Container enabled SKU.
   emacs ESC 4 F10
   Begin commands to deploy this file using Azure CLI with bash
   echo az appservice plan create --name $PLAN $LINUX_PLAN  --resource-group $rg  --hyper-v --sku $APPSERVICE_SKU
   az appservice plan create --name $PLAN $LINUX_PLAN  --resource-group $rg  --hyper-v --sku $APPSERVICE_SKU
   az resource list -g $rg --query "[?resourceGroup=='$rg'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
   End commands for one time initializations using Azure CLI with bash

   emacs ESC 5 F10
   Begin commands to deploy this file using Azure CLI with bash
   echo az acr build -g $rg --image $REPO/$IMAGE:v1 --registry $REGISTRY --file Dockerfile .
   az acr build -g $rg --image $REPO/$IMAGE:v1 --registry $REGISTRY --file Dockerfile .
   az acr repository list -n $REGISTRY
   export PASSWORD=`az acr credential show --resource-group $rg --name $REGISTRY --query passwords[0].value --output tsv | sed 's/\r$//'`
   export USERNAME=`az acr credential show --resource-group $rg --name $REGISTRY --query username  --output tsv | sed 's/\r$//'`
   echo acr password=$PASSWORD
   echo acr username=$USERNAME
   az resource list -g $rg --query "[?resourceGroup=='$rg'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
   End commands to deploy this file using Azure CLI with bash

  ERROR: The parameter WindowsFxVersion has an invalid value. Unexpected exception while validating OS and version. Image: qsuwc712oreg.azurecr.io/qsuwc712o-repo/qsuwc712o-image:latest. Error Response: NotFound. Request: https://qsuwc712oreg.azurecr.io/v2/qsuwc712o-repo/qsuwc712o-image/manifests/latest. AuthType UserName. Response: NotFound. Request: https://qsuwc712oreg.azurecr.io/v2/qsuwc712o-repo/qsuwc712o-image/manifests/latest. AuthType UserName
   emacs ESC 6 F10
   Begin commands to deploy this file using Azure CLI with bash
   echo az webapp create  --name $WEB --resource-group  $rg  --runtime $RUNTIME --plan $PLAN --deployment-container-image-name $REGISTRY.azurecr.io/$REPO/$IMAGE -s $USERNAME -w $PASSWORD
   az webapp create  --name $WEB --resource-group  $rg    --runtime $RUNTIME --plan $PLAN --deployment-container-image-name $REGISTRY.azurecr.io/$REPO/$IMAGE -s $USERNAME -w $PASSWORD
   End commands to deploy this file using Azure CLI with bash

 */
