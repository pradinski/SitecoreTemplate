# env
$web_path = (Get-Location).Path
$root_path = (Get-Item $web_path).parent.FullName
$db_path = Join-Path $root_path "db"
$nuget_server = "http://159.224.42.176"
$db_server = ".\sqlexpress"

# params
$sitename = "SitecoreTemplate"
$hostname = "SitecoreTemplate.com"
$packages = @{
    "Sitecore.CMS.7.0.130918" = $web_path;
    "Sitecore.CMS.Db.7.0.130918" = $db_path;
}

# install
$script = {
    Build-Solution
    Install-Packages $packages
    Create-Website $sitename $hostname $web_path
    Launch-Website $sitename $hostname
}

# invoke script
try {
    . .\install_utils.ps1
    & $script
    Write-InstallCompleted
} catch {
    Write-Error $_
    echo "Installation failed."
}