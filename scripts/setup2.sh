#!/bin/bash
set -e

# -------------------------------
# Config
# -------------------------------
METRO_PORT=8081
ANDROID_EMULATOR_NAME="Pixel_8a"

echo "======================================="
echo "🚀 Starting full React Native setup..."
echo "======================================="

# -------------------------------
# Start Metro
# -------------------------------
while lsof -i :"$METRO_PORT" >/dev/null 2>&1; do
  echo "⚠️ Port $METRO_PORT is already in use!"
  echo "Process using it:"
  lsof -i :"$METRO_PORT" | grep LISTEN

  read -p "Do you want to kill this process? [y/N]: " kill_choice
  if [[ "$kill_choice" =~ ^[Yy]$ ]]; then
    PID=$(lsof -t -i :"$METRO_PORT")
    echo "Killing process $PID..."
    kill -9 $PID
    echo "✅ Process killed. Continuing..."
  else
    echo "Please free the port manually and press Enter to continue..."
    read -r
  fi
done

echo "🟢 Starting Metro on port $METRO_PORT..."
npx react-native start --port $METRO_PORT &

# -------------------------------
# Android Emulator
# -------------------------------
if command -v adb >/dev/null 2>&1; then
  echo "🤖 Setting up Android..."
  adb start-server

  echo "🖥️ Launching Android emulator: $ANDROID_EMULATOR_NAME..."
  emulator -avd "$ANDROID_EMULATOR_NAME" &

  echo "⌛ Waiting for emulator to boot..."
  adb wait-for-device
  echo "📱 Emulator booted!"

  echo "📱 Running React Native on Android device/emulator..."
  npx react-native run-android
fi

# -------------------------------
# iOS Simulator (macOS only)
# -------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v xcrun >/dev/null 2>&1; then
    echo "🍎 Setting up iOS Simulator..."
    echo "⌛ Launching iOS Simulator..."
    npx react-native run-ios
  else
    echo "⚠️ xcrun not found. Skipping iOS setup."
  fi
fi

echo "✅ Setup completed!"
