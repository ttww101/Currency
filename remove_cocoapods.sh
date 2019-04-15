#!/bin/bash

echo "Execute pod deintegrate"
pod deintegrate

echo "Remove Podfile.lock"
rm Podfile.lock

echo "Remove *.xcworkspace"
rm *.xcworkspace

echo "

1. Open your xcodeproj file, 
2. Delete the references to Pods.xcconfig and libPods.a (in the Frameworks group)
3. Under your Build Phases delete the Copy Pods Resources, Embed Pods Frameworks and Check Pods Manifest.lock phases.

This may seem obvious but you'll need to integrate the 3rd party libraries some other way or remove references to them from your code.

"