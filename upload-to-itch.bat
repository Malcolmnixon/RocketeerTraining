SET CURRENT_DIR=%~dp0
SET APK=%CURRENT_DIR%/build/quest/RocketeerTraining.apk
SET WINDOWS=%CURRENT_DIR%/build/windows/
SET WEBXR=%CURRENT_DIR%/build/webxr/

echo Uploading to Itch...
butler -v push "%APK%" "malcolmnixon/rocketeer-training:android"
butler -v push "%WINDOWS%" "malcolmnixon/rocketeer-training:windows"
butler -v push "%WEBXR%" "malcolmnixon/rocketeer-training:html5"

echo Done.
