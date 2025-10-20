# Troubleshooting Guide

## 🚨 Common Issues & Solutions

### 1. Flutter Not Found

**Error:**
```
'flutter' is not recognized as an internal or external command
```

**Solutions:**
- Install Flutter: https://docs.flutter.dev/get-started/install
- Add Flutter to PATH:
  - Windows: Add `C:\flutter\bin` to System Environment Variables
  - Mac/Linux: Add to `.bashrc` or `.zshrc`
- Verify: `flutter --version`

---

### 2. Dependencies Not Installing

**Error:**
```
Error: Could not resolve package dependencies
```

**Solutions:**

**Option A: Clean and retry**
```bash
flutter clean
flutter pub get
```

**Option B: Delete lock file**
```bash
rm pubspec.lock
flutter pub get
```

**Option C: Update Flutter**
```bash
flutter upgrade
flutter pub get
```

**Option D: Check network**
- Ensure internet connection
- Check if behind proxy
- Try different network

---

### 3. Build Errors

**Error:**
```
FAILURE: Build failed with an exception
```

**Solutions:**

**For Android:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

**For iOS:**
```bash
cd ios
pod deinstall
pod install
cd ..
flutter clean
flutter run
```

**Check Gradle version:**
- Update `android/gradle/wrapper/gradle-wrapper.properties`
- Use Gradle 7.5 or higher

**Check Java version:**
- Android requires Java 11 or higher
- Check: `java -version`

---

### 4. Emulator Issues

**Error:**
```
No devices found
```

**Solutions:**

**Android Emulator:**
1. Open Android Studio
2. Tools → Device Manager
3. Create a new virtual device
4. Start the emulator
5. Verify: `flutter devices`

**iOS Simulator (Mac only):**
1. Open Xcode
2. Xcode → Open Developer Tool → Simulator
3. Verify: `flutter devices`

**Physical Device:**

**Android:**
1. Enable Developer Mode (tap Build Number 7 times)
2. Enable USB Debugging
3. Connect via USB
4. Accept prompt on phone

**iOS:**
1. Trust computer on iPhone
2. Open Xcode
3. Window → Devices and Simulators
4. Select your device

---

### 5. Hot Reload Not Working

**Error:**
```
Hot reload not supported
```

**Solutions:**
- Press `R` (capital R) for hot restart
- Stop app and run again: `flutter run`
- Check if you edited `main()`
- Hot reload doesn't work after changing:
  - `main()`
  - `initState()`
  - Global variables

---

### 6. Package Version Conflicts

**Error:**
```
version solving failed
```

**Solutions:**

**Option A: Update all packages**
```bash
flutter pub upgrade --major-versions
```

**Option B: Check pubspec.yaml**
- Remove version constraints
- Use `any` for testing
- Run `flutter pub get`

**Option C: Check Flutter version**
```bash
flutter --version
```
- Ensure Flutter SDK >= 3.0.0
- Update if needed: `flutter upgrade`

---

### 7. App Crashing on Launch

**Symptoms:**
- App opens and immediately closes
- Black screen
- Exception in console

**Solutions:**

**Check console output:**
```bash
flutter run
```
- Look for error messages
- Note the line numbers

**Common causes:**
1. **Missing asset**: Check `pubspec.yaml` assets section
2. **Null safety**: Add null checks
3. **Missing dependency**: Run `flutter pub get`
4. **Platform-specific issue**: Check native code

**Debug mode:**
```bash
flutter run --debug
flutter logs
```

---

### 8. Confetti Not Showing

**Issue:** Confetti animation doesn't appear after completing lesson

**Solutions:**
- Ensure `confetti: ^0.7.0` in pubspec.yaml
- Check if confetti controller is initialized
- Verify `_confettiController.play()` is called
- Check if widget is visible on screen
- Try restarting app

---

### 9. Charts Not Rendering

**Issue:** Pie chart on budget screen is blank

**Solutions:**
- Ensure `fl_chart: ^0.65.0` installed
- Check if budget data is initialized
- Verify categories have non-zero values
- Check console for errors
- Try hot restart (not hot reload)

---

### 10. Google Fonts Not Loading

**Issue:** Fonts look different than expected

**Solutions:**

**Option A: Download fonts**
```bash
flutter pub run google_fonts:download
```

**Option B: Use system fonts**
- Edit `lib/main.dart`
- Remove `GoogleFonts.poppinsTextTheme()`
- Use default fonts

**Option C: Check internet**
- Fonts download on first run
- Requires internet connection
- Cached after first download

---

### 11. Build Size Too Large

**Issue:** APK/IPA size is very large

**Solutions:**

**Reduce size:**
```bash
flutter build apk --split-per-abi
```

**Enable obfuscation:**
```bash
flutter build apk --obfuscate --split-debug-info=build/debug-info
```

**Remove unused code:**
- Run `flutter analyze`
- Remove unused imports
- Remove unused assets

---

### 12. Slow Performance

**Symptoms:**
- Animations are laggy
- UI is unresponsive
- Long load times

**Solutions:**

**Run in release mode:**
```bash
flutter run --release
```

**Profile the app:**
```bash
flutter run --profile
```

**Check for issues:**
- Avoid expensive operations in `build()`
- Use `const` constructors
- Optimize images
- Reduce widget rebuilds

**Use DevTools:**
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

---

### 13. Provider Not Updating UI

**Issue:** State changes but UI doesn't update

**Solutions:**

**Ensure `notifyListeners()` is called:**
```dart
void updateBudget() {
  _budget = newBudget;
  notifyListeners(); // ← Must call this!
}
```

**Use correct consumer:**
```dart
// Good
Consumer<BudgetProvider>(
  builder: (context, budget, child) => Text(budget.total)
)

// Also good
Provider.of<BudgetProvider>(context)

// Bad (won't update)
Provider.of<BudgetProvider>(context, listen: false)
```

**Check provider is registered:**
- Verify in `main.dart` MultiProvider
- Ensure widget is inside provider tree

---

### 14. Navigation Issues

**Issue:** Can't navigate between screens

**Solutions:**

**Check routes:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => NewScreen()),
);
```

**Check context:**
- Ensure `BuildContext` is valid
- Don't use after widget disposed

**Go back:**
```dart
Navigator.pop(context);
```

---

### 15. Assets Not Loading

**Error:**
```
Unable to load asset: assets/images/logo.png
```

**Solutions:**

**Check pubspec.yaml:**
```yaml
flutter:
  assets:
    - assets/images/
```

**Verify file exists:**
- Check `assets/images/` directory
- Ensure file name matches exactly (case-sensitive)

**Run:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🔍 Debugging Tips

### Enable Verbose Logging
```bash
flutter run -v
```

### Check Device Logs

**Android:**
```bash
adb logcat
```

**iOS:**
```bash
idevicesyslog
```

### Flutter Doctor
```bash
flutter doctor -v
```
- Shows all issues with your setup
- Follow suggestions to fix

### Analyze Code
```bash
flutter analyze
```
- Shows warnings and errors
- Fix before building

---

## 📞 Getting Help

### Documentation
- Flutter Docs: https://docs.flutter.dev
- Provider Docs: https://pub.dev/packages/provider
- Stack Overflow: Search for error messages

### Community
- Flutter Discord: https://discord.gg/flutter
- Reddit: r/FlutterDev
- GitHub Issues: Report bugs

### Logs
When asking for help, include:
1. Flutter version (`flutter --version`)
2. Error message (full text)
3. Steps to reproduce
4. Platform (Android/iOS/Web)

---

## 🛠️ Development Tools

### VS Code Extensions
- Flutter
- Dart
- Flutter Widget Snippets
- Error Lens

### Android Studio Plugins
- Flutter
- Dart
- Flutter Enhancement Suite

### Useful Commands
```bash
# Check everything
flutter doctor

# Clean build
flutter clean

# Update packages
flutter pub upgrade

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Run tests
flutter test

# Build release APK
flutter build apk --release

# Build release iOS
flutter build ios --release
```

---

## 🎯 Quick Fixes Checklist

Before asking for help, try:
- [ ] Run `flutter doctor`
- [ ] Run `flutter clean && flutter pub get`
- [ ] Restart IDE
- [ ] Restart computer
- [ ] Update Flutter: `flutter upgrade`
- [ ] Check internet connection
- [ ] Try on different device/emulator
- [ ] Read error message carefully
- [ ] Search error on Google/Stack Overflow

---

## 💡 Pro Tips

1. **Always read error messages** - They usually tell you exactly what's wrong
2. **Use hot reload** - Saves time during development
3. **Test on real devices** - Emulators don't show everything
4. **Keep Flutter updated** - `flutter upgrade` regularly
5. **Use version control** - Git saves you from mistakes

---

Still having issues? Check:
- README.md - General setup instructions
- SETUP.md - Detailed setup guide
- ARCHITECTURE.md - Technical details
- GitHub Issues - Known problems

Good luck! 🚀

