#!/bin/bash
set -e

echo "🚀 Starting full project reset..."

# ---- Node / npm ----
echo "🧹 Removing node_modules..."
rm -rf node_modules
echo "🧹 Removing package-lock.json..."
rm -f package-lock.json
echo "🧹 Clearing npm cache..."
npm cache clean --force

# ---- Pods / iOS ----
echo "🧹 Cleaning iOS Pods and build..."
cd ios
rm -rf Pods
rm -rf build
rm -f Podfile.lock

echo "💿 Installing iOS pods..."
pod install --repo-update
cd ..

# ---- Android ----
echo "🧹 Cleaning Android build..."
rm -rf android/app/build
rm -rf android/build
rm -rf ~/.gradle/caches

# ---- Metro / RN cache ----
echo "🧹 Clearing React Native cache..."
rm -rf /tmp/metro-*
rm -rf /tmp/haste-map-*

# ---- Install dependencies ----
echo "📦 Installing Node dependencies..."
npm install

echo "✅ Project reset complete!"
echo "You can now run: npx react-native run-ios | run-android"
