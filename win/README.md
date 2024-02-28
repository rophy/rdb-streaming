# fluentd for sqlserver

Docs for how to setup fluentd for sqlserver in windows machine without internet.

## Pre-requisutes

Download these installation files and copy to target machine:

1. [fluentd](https://s3.amazonaws.com/packages.treasuredata.com/lts/5/windows/fluent-package-5.0.2-x64.msi)
2. [msys2](https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe)
3. [msys2 development tools](https://github.com/rophy/rdb-streaming/releases/download/20240228/offline_packages.zip)
4. [gems for fluent-plugin-sql and activerecord-sqlserver-adapter](https://github.com/rophy/rdb-streaming/releases/download/20240228/repo_cache.zip)

## Installation steps

1. Install fluentd
2. Install msys2
3. Unzip contents of offline_packages.zip and put them in C:\msys64\usr\local\share\pacman\offline_packages
4. Unzip contents of repo_cache.zip and put them in C:\opt\fluent\lib\ruby\gems\3.2.0\cache

If done properly directories should look like this:

```
C:\msys64\msys2.exe
C:\msys64\user\local\share\pacman\offline_packages\database\...
C:\msys64\user\local\share\pacman\offline_packages\autoconf2.13-2.13-6-any.pkg.tar.zst
C:\msys64\user\local\share\pacman\offline_packages\autoconf2.13-2.13-6-any.pkg.tar.zst.sig
...
C:\opt\fluent\fluentd.bat
C:\opt\fluent\lib\ruby\gems\3.2.0\cache\activemodel-6.1.7.7.gem
C:\opt\fluent\lib\ruby\gems\3.2.0\cache\activemodel-7.1.3.2.gem
...
```

5. Copy `pacman.conf` in this repo to (overwriting) C:\msys64\etc\pacman.conf
6. Double check `pacman.conf` contents, the line `Server file:///usr/local/share/pacman/offline_packages` must match with your unzipped path `C:\msys64\user\local\share\pacman\offline_packages`
7. Run `Start` -> `MSYS2 CLANG64` to open a msys2 shell, and run following commands to setup msys2 local update site:


```bash
pacman -Syu
```

8. Open command prompt, and run following commands to install msys2 development tools (using msys2 local update site):

```bat
> C:\opt\fluent\fluent-gem.bat -v
3.4.10

> ridk install 3
MSYS2 seems to be properly installed
Install MSYS2 and MINGW development toolchain ...
pacman -S -needed --noconfirm ......
...
Install MSYS2 and MINGW development toolchain succeeded
```

9. Open command prompt (Run as Adminitrator), and install fluentd-plugin-sql relevant gems (this will take a while):

```bat
> C:\opt\fluent\fluent-gem.bat install --install-dir C:\opt\fluent\lib\ruby\gems\3.2.0 --no-user-install --no-document C:\opt\fluent\lib\ruby\gems\3.2.0\cache\*.gem
```

10. After installing, need to manually fix a crash bug in fluent-plugin-sql-2.3.0. Edit `C:\opt\fluent\lib\ruby\gems\3.2.0\gems\fluent-plugin-sql-2.3.0\lib\fluent\plugin\in_sql.rb` and change L285 from:

```ruby
if File.exists?(@path)
```

to:

```ruby
if File.exist?(@path)
```

and save the file. (the editor may need to "Run as Administrator" to save)

12. Copy fluentd.conf to (overwriting) `C:\opt\fluent\etc\fluentd.conf`

13. In command prompt, run `C:\opt\fluent\fluentd.bat`, you should see the following (only showing relevant sections):

```bat
> C:\opt\fluent\fluentd.bat
[info] parsing config file is succeeded path="C:/opt/fluent//etc/fluent/fluentd.conf"
[info] gem 'fluentd' version '1.16.3'
...
[info] using configuration file: <ROOT>
  <source>
    @type sql
    host "localhost"
    port 1443
    database "master"
    adapter "sqlserver"
    ...
</ROOT>
...
fluent.info: {"message":"starting fluentd worker pid=2824 ppid=4640 worker=0"}
fluent.info: {"message":"Selecting 'orders' table"}
[warn]: #0 can't connect to database. Reconnect at next try
fluent.warn: {"message":"can't connect to databse. Reconnect at next try"}
...
```

When you see the "can't connect to database", you have successfully setup fluentd, fluent-plugin-sql + sqlserver adapter, and it is trying to connect to sqlserver.
Press `CTRL+C` to terminate the fluentd process.

Next step: you should update `fluentd.conf` to reflect your sqlserver configuration.
