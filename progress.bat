@Echo OFF

SETLOCAL ENABLEDELAYEDEXPANSION

REM Setting progress file name
SET progressFile=progress.txt

REM Setting initial value to be written in progress file
SET initialValue=1

REM Checking if progress file exists
IF NOT EXIST %progressFile% (    

    REM Creating progress file and writing initial value in it
    > %progressFile% ECHO %initialValue%

    GOTO :EOF
) ELSE (

    REM Reading current value in file and incrementing it 
    SET /P currentValue=<%progressFile%
    
    SET /A currentValue = currentValue + 1

    REM Storing incremented value back in progress file
    > %progressFile% ECHO !currentValue!

    GOTO :EOF
)


:EOF

