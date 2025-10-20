# Masari Family - Your Local Financial Guide

**Tagline**: "Helping immigrant families budget smarter, live better, and build a future — one local choice at a time."

## 🎯 Overview

Masari Family is a Flutter mobile app designed for single parents and immigrant families to manage their finances more effectively. The app combines:

- 💰 **Smart Budget Tracking** - Monitor expenses across categories
- 🤖 **AI Onboarding** - Personalized setup with virtual financial buddy
- 🎓 **Gamified Learning** - Earn points while learning financial skills
- 📍 **Local Recommendations** - Find affordable services nearby
- 🎯 **Savings Goals** - Track progress toward financial goals

## ✨ Features

### User Journey
1. **Welcome & Registration** - Simple account creation
2. **AI Onboarding Chat** - Masari, your AI buddy, asks questions to understand your situation
3. **Personalized Dashboard** - See your budget, savings, and tips
4. **Gamified Lessons** - Learn through interactive micro-lessons
5. **Local Recommendations** - Discover budget-friendly services near you

### Key Screens
- **Home Dashboard** - Budget overview, savings goals, AI mentor tips
- **Learn Section** - Interactive lessons with points system
- **Explore Section** - Local recommendations filtered by category
- **Profile** - View your information and achievements

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for iOS)
- A physical device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd dbProject
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create assets directory** (if not exists)
   ```bash
   mkdir -p assets/images
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 How to Use

1. **Launch the app** - You'll see a beautiful welcome screen
2. **Register** - Enter your name and email
3. **Chat with Masari** - Answer questions about:
   - Your location
   - Family size
   - Income range
   - Financial goals
4. **Explore your dashboard** - See personalized budget and recommendations
5. **Complete lessons** - Tap cards to reveal content and earn points
6. **Find local deals** - Browse affordable services near you

## 🎨 Design Highlights

- **Modern UI** - Beautiful gradients and smooth animations
- **Intuitive Navigation** - Bottom navigation with 4 main sections
- **Engaging Interactions** - Confetti celebrations, progress bars, badges
- **Responsive Design** - Works on different screen sizes
- **Accessibility** - Clear text, good contrast, readable fonts

## 🏗️ Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/                        # Data models
│   ├── user_model.dart
│   ├── budget_model.dart
│   ├── lesson_model.dart
│   └── recommendation_model.dart
├── providers/                     # State management
│   ├── user_provider.dart
│   ├── budget_provider.dart
│   └── lesson_provider.dart
└── screens/                       # UI screens
    ├── splash_screen.dart
    ├── registration_screen.dart
    ├── onboarding_chat_screen.dart
    ├── dashboard_screen.dart
    ├── budget_detail_screen.dart
    ├── lessons_screen.dart
    ├── lesson_detail_screen.dart
    └── recommendations_screen.dart
```

## 📦 Dependencies

- **provider** - State management
- **google_fonts** - Beautiful typography
- **fl_chart** - Budget visualization
- **animate_do** - Smooth animations
- **confetti** - Celebration effects
- **intl** - Number formatting

## 🎯 Hackathon Alignment

This app aligns perfectly with the hackathon theme:

- **Localized Financial Education** - Tailored lessons and recommendations
- **Social Impact** - Helps immigrant families thrive
- **AI Integration** - Conversational onboarding and personalized tips
- **Practical Utility** - Solves real daily pain points
- **Scalability** - Easy to add more features and integrations

## 🚀 Future Enhancements

- Real API integration for local businesses
- Push notifications for deals and reminders
- Multi-language support
- Community features (tips sharing)
- Integration with banking APIs
- Expense tracking with receipt scanning
- Family member accounts

## 🎮 Demo Flow

1. **Splash Screen** → Welcome animation
2. **Welcome** → Feature overview
3. **Registration** → Name + Email
4. **AI Chat** → 4 questions with smooth conversation
5. **Dashboard** → Budget, goals, tips
6. **Lessons** → Tap to learn and earn points
7. **Recommendations** → Filterable local deals

## 🎨 Color Scheme

- Primary: `#6C63FF` (Purple)
- Accent: Various category colors
- Success: Green shades
- Background: White with gradient overlays

## 📝 Notes for Demo

- All data is currently mocked for demo purposes
- Budget calculations are based on income range provided
- Recommendations are static but designed to be dynamic
- Lessons award points upon completion
- Confetti animation triggers when completing lessons

## 💡 Tips for Presentation

1. Show the smooth onboarding flow
2. Demonstrate the AI chat interaction
3. Highlight the gamification (points system)
4. Show budget visualization with charts
5. Filter recommendations by category
6. Complete a lesson to show confetti effect

## 👥 Target Audience

- Immigrant families
- Single parents
- Anyone new to a country/city
- Budget-conscious families
- People seeking financial literacy

## 🏆 Why This Stands Out

1. **Human-centered** - Designed for real pain points
2. **Beautiful UX** - Professional, modern interface
3. **Practical** - Actionable recommendations
4. **Educational** - Gamified learning
5. **Localized** - Context-aware suggestions

---

Built with ❤️ for the hackathon

Good luck with your presentation! 🚀

