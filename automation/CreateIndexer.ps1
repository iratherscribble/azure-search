param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $definitionName = $(throw "-definitionName is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Indexer.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Definition.psm1") -DisableNameChecking

 $ErrorActionPreference = 'Continue'

 Set-Credentials $serviceName $serviceKey
  
 $definition = Get-Definition $definitionName

 try
 {
    $indexer = Get-Indexer $definition.name
 }
 catch [System.Net.WebException]
 {
    $indexer = $null
 }
 if ($indexer -ne $null)
 {
    Delete-Indexer $definition.name
 }

 Create-Indexer $definition