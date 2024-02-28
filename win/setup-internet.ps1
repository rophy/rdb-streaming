
$fluentdUrl = "https://s3.amazonaws.com/packages.treasuredata.com/lts/5/windows/fluent-package-5.0.2-x64.msi"
$msys2Url = "https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe"
$pacmanUpdateUrl = "https://github.com/rophy/rdb-streaming/releases/download/20240228/offline_packages.zip"
$gemFilesUrl = "https://github.com/rophy/rdb-streaming/releases/download/20240228/repo_cache.zip"

Invoke-WebRequest $fluentdUrl -OutFile $env:USERPROFILE\Downloads\fluent-package-5.0.2-x64.msi
Invoke-WebRequest $msys2Url -OutFile $env:USERPROFILE\Downloads\msys2-x86_64-20240113.exe
Invoke-WebRequest $pacmanUpdateUrl -OutFile $env:USERPROFILE\Downloads\offline_packages.zip
Invoke-WebRequest $gemFilesUrl -OutFile $env:USERPROFILE\Downloads\repo_cache.zip

Expand-Archive $env:USERPROFILE\Downloads\offline_packages.zip -DestinationPath $env:USERPROFILE\Downloads
Expand-Archive $env:USERPROFILE\Downloads\repo_cache.zip -DestinationPath $env:USERPROFILE\repo_cache

start /wait msiexec $env:USERPROFILE\Downloads\fluent-package-5.0.2-x64.msi
start /wait $env:USERPROFILE\Downloads\msys2-x86_64-20240113.exe
