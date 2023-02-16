@echo off

:: This script must be executed with admin permissions
:: Windisable can optimize your winndows system and reinforce privacy

cls
title Windisable ^| Opensource script to disable IPv6 and geolocation
echo.
echo.
echo.
echo                  __    __ _          ___ _           _     _      
echo                 / / /\ \ (_)_ __    /   (_)___  __ _^| ^|__ ^| ^| ___ 
echo                 \ \/  \/ / ^| '_ \  / /\ / / __^|/ _` ^| '_ \^| ^|/ _ \
echo                  \  /\  /^| ^| ^| ^| ^|/ /_//^| \__ \ (_^| ^| ^|_) ^| ^|  __/
echo                   \/  \/ ^|_^|_^| ^|_/___,' ^|_^|___/\__,_^|_.__/^|_^|\___^|
echo.      
echo.                                                
echo                              --- Created by AfraL ---
echo.
echo. 
echo.                                         
echo.

echo    Permanently disabling IPv6 for User: %USERNAME%
echo.   
echo.   
timeout /t 2 /nobreak  > nul

echo        Disabling IPv6 for all Windows Network Adapters using powershell
timeout /t 2 /nobreak  > nul

powershell Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6 > nul

echo        Disabling all IPv6 transition technologies
timeout /t 1 /nobreak  > nul
echo        Disabling all IPv6 different states on Windows
timeout /t 3 /nobreak  > nul

netsh interface IPV6 set global randomizeidentifier=disabled > nul
netsh interface teredo set state disabled > nul
netsh interface IPV6 set privacy state=disable  > nul
netsh interface ipv6 6to4 set state state=disabled  > nul

echo        Disabling the 6to4 tunnels that support communication with IPv6 internet
timeout /t 2 /nobreak  > nul

netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled  > nul
netsh interface ipv6 isatap set state state=disabled > nul
netsh interface ipv6 isatap set state state=disabled  > nul
netsh interface ipv6 set teredo disable  > nul
netsh interface teredo set state disable  > nul
netsh interface 6to4 set state disabled  > nul
netsh interface isatap set state disabled  > nul

echo        Preventing reactivation by injecting disabled component key in regedit
timeout /t 3 /nobreak  > nul
echo.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f > nul
:: reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /f > nul

echo.   
echo.

timeout /t 1 /nobreak  > nul

echo    Permanently disabling geolocation services for User: %USERNAME%
echo.
echo.

echo        Disabling the geolocation windows service for apps
timeout /t 2 /nobreak  > nul

echo.
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location /v Value /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location /v Value /t Reg_Sz /d Deny /f

echo.
echo        Disabling the geolocation windows service for all tasks
timeout /t 2 /nobreak  > nul

echo.

reg delete HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location /v Value /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location /v Value /t Reg_Sz /d Deny /f

timeout /t 1 /nobreak  > nul

echo.
echo        Disabling the global geolocation windows service 

timeout /t 3 /nobreak  > nul

echo.
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration /v Status /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration /v Status /t REG_DWORD /d 0 /f

echo.
echo.
echo    ^>^> All disabling tasks have been successfuly completed
echo.

pause>nul