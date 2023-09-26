import-module au

$releases = 'https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices'
             
function global:au_BeforeUpdate {
  $Latest.Checksum = Get-RemoteChecksum $Latest.Url32
  $Latest.ChecksumType = "sha256"
}

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
        "(\s*url\s*=\s*)`"([^*]+)`""          = "`$1`"$($Latest.URL32)`""
        "(\s*checksum\s*=\s*)`"([^*]+)`""     = "`$1`"$($Latest.Checksum)`""
        "(\s*checksumType\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.ChecksumType)`""
      }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'SqlServerIntegrationServicesProjects/.+?/vspackage$'
  $url = $download_page.links | Where-Object href -match $re | ForEach-Object { "https://marketplace.visualstudio.com" + $_.href  }
  $version = $url -split '/' | Select-Object -Last 1 -Skip 1

  @{
    Version   = $version
    URL32     = $url
  }
}

update -ChecksumFor none
