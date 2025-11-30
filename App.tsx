/**
 * MedTrackBareRN – Clean Minimal Starter
 */

import React from 'react';
import { Text, View, StatusBar, StyleSheet, useColorScheme } from 'react-native';

import { SafeAreaProvider, SafeAreaView } from 'react-native-safe-area-context';

export default function App() {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <SafeAreaProvider>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={isDarkMode ? '#000' : '#FFF'}
      />

      <SafeAreaView
        style={[
          styles.container,
          {
            backgroundColor: isDarkMode ? '#111' : '#F5F5F5',
          },
        ]}
      >
        <View style={styles.content}>
          <Text style={[styles.title, { color: isDarkMode ? '#FFF' : '#000' }]}>MedTrack App</Text>

          <Text style={[styles.subtitle, { color: isDarkMode ? '#AAA' : '#555' }]}>
            Build test — {new Date().toLocaleTimeString()}
          </Text>
        </View>
      </SafeAreaView>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: '600',
    marginBottom: 12,
  },
  subtitle: {
    fontSize: 18,
  },
});
