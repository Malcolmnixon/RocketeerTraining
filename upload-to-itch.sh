#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
APK="$CURRENT_DIR/build/quest/RocketeerTraining.apk"
WINDOWS="$CURRENT_DIR/build/windows/"
WEBXR="$CURRENT_DIR/build/webxr/"

echo Uploading to Itch...
butler -v push "$APK" "malcolmnixon/rocketeer-training:android"
butler -v push "$WINDOWS" "malcolmnixon/rocketeer-training:windows"
butler -v push "$WEBXR" "malcolmnixon/rocketeer-training:webxr"

echo Done.
