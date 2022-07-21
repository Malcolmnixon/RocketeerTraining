SET CURRENT_DIR=%~dp0
SET APK=%CURRENT_DIR%/build/RocketeerTraining.apk
SET WINDOWS=%CURRENT_DIR%/build/windows/

echo Uploading to Itch...
butler -v push "%APK%" "malcolmnixon/rocketeer-training:android"
butler -v push "%WINDOWS%" "malcolmnixon/rocketeer-training:windows"

echo Done.
