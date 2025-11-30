#!/bin/bash

# 1️⃣ Set variables
ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
CMDLINE_TOOLS_DIR="$ANDROID_SDK_ROOT/cmdline-tools"
TOOLS_VERSION="latest"
NDK_VERSION="27.1.12297006"

mkdir -p "$ANDROID_SDK_ROOT"
cd "$ANDROID_SDK_ROOT"

# 2️⃣ Download command-line tools (Mac)
curl -o commandlinetools-mac.zip https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip

# 3️⃣ Extract
mkdir -p "$CMDLINE_TOOLS_DIR/$TOOLS_VERSION"
unzip -q commandlinetools-mac.zip -d "$CMDLINE_TOOLS_DIR/$TOOLS_VERSION"
rm commandlinetools-mac.zip

# 4️⃣ Add to PATH for this session
export PATH="$CMDLINE_TOOLS_DIR/$TOOLS_VERSION/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# 5️⃣ Accept licenses automatically
yes | sdkmanager --licenses

# 6️⃣ Install essential SDKs and NDK
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;$NDK_VERSION"

# 7️⃣ Clean Gradle caches and locks (fix “failed to release lock”)
echo "🧹 Cleaning Gradle caches and lock files..."
rm -rf "$HOME/.gradle/caches/"
rm -rf "$HOME/.gradle/daemon/"
rm -rf "$HOME/.gradle/native/"
rm -rf "$HOME/.gradle/worker/"
rm -rf "$PWD/android/.gradle/"
rm -rf "$PWD/node_modules/@react-native/gradle-plugin/.gradle/"

# 8️⃣ Verify NDK
ls "$ANDROID_SDK_ROOT/ndk"

# 9️⃣ Final message
echo "✅ Android SDK, NDK, and Gradle cleanup complete."
echo "PATH updated for this session. Run 'npx react-native run-android' to build your app."

