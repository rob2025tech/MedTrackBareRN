#!/bin/bash
# scripts/setup-all.sh
set -e

echo "======================================="
echo "🚀 Starting full React Native setup..."
echo "======================================="

# ------------------------------
# Android Setup
# ------------------------------
echo "🤖 Setting up Android..."

# Kill any stale adb servers
adb kill-server && adb start-server

# Launch Android emulator in the background
EMULATOR_NAME="Pixel_8a"
echo "🖥️  Launching Android emulator: $EMULATOR_NAME..."
/Users/r/Library/Android/sdk/emulator/emulator @$EMULATOR_NAME -no-snapshot-load &

# Wait for emulator to boot
echo "⌛ Waiting for emulator to boot..."
adb wait-for-device

# Start Metro bundler in a new terminal window
osascript -e 'tell application "Terminal" to do script "cd \"'$PWD'\" && npx react-native start"'

# Give Metro a few seconds to start, then install & launch the app
sleep 5
DEVICE_ID=$(adb devices | grep emulator | awk '{print $1}' | head -n1)
echo "📱 Running React Native on Android device $DEVICE_ID..."
npx react-native run-android --device "$DEVICE_ID"

echo "✅ Android setup complete!"
echo

# ------------------------------
# iOS Setup
# ------------------------------
echo "🍏 Setting up iOS..."

# Reset and shutdown simulators
xcrun simctl shutdown all
xcrun simctl erase all

# Clean Xcode build and DerivedData
cd ios
xcodebuild clean
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Install pods
echo "📦 Installing CocoaPods..."
pod install --repo-update
cd ..

# Launch app on iOS simulator
IOS_SIMULATOR="iPhone 15"
echo "🏃‍♂️ Running React Native on iOS simulator: $IOS_SIMULATOR..."
npx react-native run-ios --simulator="$IOS_SIMULATOR"

echo
echo "======================================="
echo "🎉 All platforms setup complete!"
echo "======================================="
