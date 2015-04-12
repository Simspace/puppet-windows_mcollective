SET BASEDIR=%~dp0..
SET BASEDIR=%BASEDIR:\bin\..=%

CALL "%BASEDIR%\..\Puppet\bin\environment.bat"

SET SERVER_CONFIG=%BASEDIR%\etc\server.cfg
SET CLIENT_CONFIG=%BASEDIR%\etc\client.cfg

SET MCOLLECTIVED=%BASEDIR%\bin\mcollectived
REM SET MC_STARTTYPE=manual
SET MC_STARTTYPE=auto

SET PATH=%BASEDIR%\bin;%PATH%

SET RUBYLIB=%BASEDIR%\lib;%RUBYLIB%
SET RUBYLIB=%RUBYLIB:\=/%

SET RUBY="ruby"
