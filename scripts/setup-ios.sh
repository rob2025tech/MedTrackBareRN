#!/bin/bash
# scripts/setup-ios.sh

echo "🚀 Resetting iOS simulators..."
xcrun simctl shutdown all
xcrun simctl erase all

echo "🧹 Cleaning Xcode build and derived data..."
cd ios
xcodebuild clean
rm -rf ~/Library/Developer/Xcode/DerivedData/*

echo "📦 Installing pods..."
pod install --repo-update
cd ..

echo "🏃‍♂️ Running React Native app on iOS..."
npx react-native run-ios --simulator="iPhone 15"

echo "✅ Done!"
