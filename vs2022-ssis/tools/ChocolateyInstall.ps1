$ErrorActionPreference = 'Stop';
$installArgs = "/quiet`"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.log`""

# Install Microsoft .NET Framework 4.8.1 Developer Pack
choco install netfx-4.8.1-devpack

# Install Visual Studio 2022 SSIS Extension
$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    softwareName  = 'Microsoft.DataTools.IntegrationServices*'
    fileType      = 'EXE'
    silentArgs    = $installArgs
    validExitCodes= @(0)
    url           = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/SSIS/vsextensions/MicrosoftDataToolsIntegrationServices/1.1/vspackage"
    checksum      = "cc4d4adbf7f447dd373d4a60ecbf142f665aef89ed499a48e39996f25d252752"
    checksumType  = "sha256"
  }
  
Install-ChocolateyPackage @packageArgs
