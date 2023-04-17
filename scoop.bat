@echo OFF

NET SESSION >nul 2>&1

IF %ERRORLEVEL% EQU 0 (

   ECHO.

) ELSE (

   ECHO.-----------------------------------------------------------------

   ECHO OPPS, NOT RUNNING AS ADMIN !!!

   ECHO.-----------------------------------------------------------------

   PAUSE

   EXIT /B 1

)

CLS

ECHO ..........................................
ECHO "batch installer for scoop"

:MENU
ECHO ...........................................
ECHO SELECT ACTION:
ECHO ...........................................
ECHO.
ECHO 1 - install app(s)
ECHO 2 - update app(s)
ECHO 3 - exit
ECHO ...........................................


SET /P M=Type 1, 2 or 3 then press ENTER:
IF %M%==1 GOTO INS
IF %M%==2 GOTO UPG
IF %M%==3 GOTO EXT

:INS
setlocal EnableDelayedExpansion

SET i=0
FOR /F %%a IN (%~dp0\install_list.txt) do (
   SET /A i+=1
   SET array[!i!]=%%a
)
SET n=%i%

FOR /L %%i IN (1,1,%n%) do scoop install !array[%%i]!

ECHO .....................
ECHO Installation is done.
ECHO .....................
PAUSE
CLS
GOTO MENU

:UPG
scoop update all
ECHO ..................
ECHO Updating finished.
ECHO ..................
PAUSE
CLS
GOTO MENU


:EXT
EXIT