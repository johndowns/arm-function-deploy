param
(
    $FunctionFilePath,
    $ArmTemplateFilePath,
    $ResourceGroupName,
    $ResourceGroupLocation
)

# Ensure the resource group exists
New-AzureRmResourceGroup `
    -Name $ResourceGroupName `
    -Location $ResourceGroupLocation `
    -Force

# Read the contents of the function file and assemble deployment parameters
$functionFileContents = [System.IO.File]::ReadAllText($FunctionFilePath)
$templateParameters = @{}
$templateParameters.Add("functionFile", $functionFileContents)

# Deploy the ARM template
New-AzureRmResourceGroupDeployment `
    -TemplateFile $ArmTemplateFilePath `
    -ResourceGroupName $ResourceGroupName `
    -TemplateParameterObject $templateParameters `
    -Verbose
