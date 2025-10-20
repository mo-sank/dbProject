# Quick Setup Guide

## Fast Track for Hackathon Demo

### 1. Install Flutter (if not already installed)
```bash
# Windows (using Chocolatey)
choco install flutter

# Or download from: https://docs.flutter.dev/get-started/install
```

### 2. Setup Project
```bash
# Navigate to project
cd dbProject

# Get dependencies
flutter pub get

# Check if everything is ready
flutter doctor
```

### 3. Run the App

#### Option A: Use an Emulator
```bash
# List available devices
flutter devices

# Run on emulator
flutter run
```

#### Option B: Use Physical Device
1. Enable Developer Mode on your phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

### 4. Quick Test Flow

1. **App launches** → See splash screen
2. **Welcome** → Tap "Get Started"
3. **Register** → Enter any name/email
4. **Chat** → Answer 4 questions:
   - Location: "New York"
   - Family: "3 people"
   - Income: "$3000-$4000"
   - Goal: "Save for emergency fund"
5. **Dashboard** → See your personalized budget
6. **Tap "Learn"** → Go to lessons
7. **Open a lesson** → Tap cards to reveal content
8. **Complete lesson** → See confetti! 🎉
9. **Tap "Explore"** → See local recommendations

### Troubleshooting

#### If dependencies fail to install:
```bash
flutter clean
flutter pub get
```

#### If you see build errors:
```bash
flutter doctor
# Fix any issues it identifies
```

#### For iOS (Mac only):
```bash
cd ios
pod install
cd ..
flutter run
```

### Demo Tips

- The app works offline with mock data
- All animations are smooth on real devices
- Best viewed on mobile (phone size)
- Portrait mode optimized
- Takes ~2-3 minutes to complete full flow

### Key Features to Show

1. ✨ **AI Chat** - Natural conversation onboarding
2. 📊 **Budget Visualization** - Pie chart and categories
3. 🎮 **Gamification** - Points and progress tracking
4. 🎓 **Interactive Lessons** - Tap-to-reveal content
5. 📍 **Local Deals** - Filterable recommendations
6. 🎉 **Celebrations** - Confetti on completion

### Performance Notes

- First run may take 1-2 minutes to build
- Subsequent runs are faster (hot reload)
- App size: ~15-20 MB
- Works on Android 5.0+ and iOS 11+

### Quick Commands

```bash
# Run in release mode (faster, for demo)
flutter run --release

# Run on specific device
flutter run -d <device-id>

# Hot reload during development
# Press 'r' in terminal while app is running

# Hot restart
# Press 'R' in terminal
```

### For Presentation

1. Have the app pre-built and ready
2. Start from splash or welcome screen
3. Go through complete user journey
4. Highlight the AI personality
5. Show a lesson completion for wow factor
6. Filter recommendations to show interactivity

Good luck! 🚀

