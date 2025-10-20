# Architecture Overview

## 🏗️ Project Structure

```
masari_family/
│
├── lib/
│   ├── main.dart                          # App entry point
│   │
│   ├── models/                            # Data Models (POJO)
│   │   ├── user_model.dart               # User profile data
│   │   ├── budget_model.dart             # Budget categories & savings
│   │   ├── lesson_model.dart             # Learning content
│   │   └── recommendation_model.dart     # Local service data
│   │
│   ├── providers/                         # State Management (Provider)
│   │   ├── user_provider.dart            # User state & authentication
│   │   ├── budget_provider.dart          # Budget calculations & tracking
│   │   └── lesson_provider.dart          # Lesson progress & points
│   │
│   └── screens/                           # UI Screens
│       ├── splash_screen.dart            # Launch & welcome
│       ├── registration_screen.dart      # User signup
│       ├── onboarding_chat_screen.dart   # AI conversation
│       ├── dashboard_screen.dart         # Main hub (home, profile)
│       ├── budget_detail_screen.dart     # Budget breakdown
│       ├── lessons_screen.dart           # Lesson list
│       ├── lesson_detail_screen.dart     # Lesson content
│       └── recommendations_screen.dart    # Local deals
│
├── assets/
│   └── images/                            # App assets
│
├── pubspec.yaml                           # Dependencies
├── analysis_options.yaml                  # Linting rules
└── README.md                              # Documentation
```

---

## 🎨 Design Patterns

### 1. Provider Pattern (State Management)
- **Why**: Simple, built-in, perfect for small-medium apps
- **How**: 
  - Providers hold app state (user, budget, lessons)
  - Widgets listen to providers using `Consumer` or `Provider.of()`
  - State changes trigger UI rebuilds automatically

```dart
// Example: Listening to budget changes
Consumer<BudgetProvider>(
  builder: (context, budgetProvider, child) {
    return Text('\$${budgetProvider.totalRemaining}');
  },
)
```

### 2. Model-View-Provider (MVP-like)
- **Models**: Pure data classes
- **Views**: Stateless/Stateful widgets (screens)
- **Providers**: Business logic and state

### 3. Composition over Inheritance
- Small, reusable widgets
- Example: `_TipCard`, `_QuickActionCard`, `_FeatureCard`

---

## 📊 Data Flow

```
User Action (tap, input)
        ↓
    Widget Event
        ↓
Provider Method Called
        ↓
State Updated (notifyListeners)
        ↓
    UI Rebuilds
        ↓
User Sees Change
```

### Example: Completing a Lesson

1. User taps through lesson content → `LessonDetailScreen`
2. Screen calls → `Provider.of<LessonProvider>().completeLesson(id)`
3. Provider updates → `lesson.isCompleted = true` & `totalPoints += points`
4. Provider notifies → `notifyListeners()`
5. All listening widgets rebuild → Points badge updates on dashboard

---

## 🔄 Screen Navigation Flow

```
SplashScreen
    ↓
WelcomeScreen
    ↓
RegistrationScreen
    ↓
OnboardingChatScreen (4 Q&A)
    ↓
DashboardScreen (Main Hub)
    ├── HomePage
    │   ├── → BudgetDetailScreen
    │   └── → RecommendationsScreen
    ├── LessonsScreen
    │   └── → LessonDetailScreen
    ├── RecommendationsScreen
    └── ProfilePage
```

---

## 🧩 Key Components

### 1. AI Chat System (`onboarding_chat_screen.dart`)
- **Question Queue**: Array of onboarding questions
- **State Machine**: Tracks current step
- **Response Handler**: Stores answers, advances flow
- **Dynamic UI**: Text input or option buttons based on question type

### 2. Budget System (`budget_provider.dart`)
- **Category Management**: 6 default categories (housing, childcare, etc.)
- **Auto-calculation**: Budget allocated based on income range
- **Real-time tracking**: Spent vs. budgeted with percentages
- **Savings Goals**: Progress tracking with visual indicators

### 3. Gamification System (`lesson_provider.dart`)
- **Points System**: Each lesson awards points
- **Progress Tracking**: Completed vs. total lessons
- **Recommendation Engine**: Suggests lessons based on goals
- **Achievement Celebrations**: Confetti on completion

### 4. Recommendation System (`recommendations_screen.dart`)
- **Category Filtering**: Groceries, Childcare, Transport, Banking
- **Distance Sorting**: Proximity-based (mock data currently)
- **Savings Calculation**: Shows potential savings vs. alternatives
- **Rating System**: Star ratings for trust

---

## 🎨 UI/UX Principles

### Material Design 3
- Uses Flutter's Material 3 components
- Color scheme from seed color (`#6C63FF`)
- Consistent spacing (8px grid system)

### Animation Strategy
- **Entry animations**: `FadeInUp`, `FadeInDown` from animate_do
- **Celebration**: Confetti widget on achievements
- **Progress**: Linear progress indicators
- **Transitions**: Smooth page routes

### Responsive Design
- Flexible layouts with `Expanded`, `Flexible`
- ScrollViews for dynamic content
- SafeArea for notch/status bar handling

---

## 📦 Dependencies Explained

| Package | Purpose | Usage |
|---------|---------|-------|
| `provider` | State management | Global app state |
| `google_fonts` | Typography | Poppins font family |
| `fl_chart` | Data visualization | Budget pie chart |
| `animate_do` | Animations | Entry animations |
| `confetti` | Celebrations | Lesson completion |
| `intl` | Formatting | Number/currency display |
| `shared_preferences` | Local storage | (Future: persist data) |

---

## 🔐 Security Considerations

### Current (MVP):
- No authentication (demo mode)
- Data stored in memory only
- No network calls

### Future:
- Firebase Authentication
- Encrypted local storage (Hive/SQLite)
- HTTPS API calls only
- Token-based auth
- GDPR compliance

---

## 🚀 Scalability Strategy

### Phase 1 (Current):
- Mock data in providers
- Single user flow
- Offline-first

### Phase 2 (Next):
- REST API integration
- User accounts with backend
- Shared preferences for local cache
- Multi-language support (i18n)

### Phase 3 (Future):
- Real-time updates (WebSocket)
- Social features (community tips)
- Push notifications
- Analytics integration
- A/B testing framework

---

## 🧪 Testing Strategy

### Unit Tests (Future):
- Model validation
- Provider business logic
- Calculation accuracy

### Widget Tests (Future):
- Screen rendering
- User interactions
- State changes

### Integration Tests (Future):
- Full user journey
- Navigation flow
- Data persistence

---

## 🔧 Build Configuration

### Development:
```bash
flutter run
```
- Hot reload enabled
- Debug logging
- Dev API endpoints

### Release:
```bash
flutter run --release
```
- Optimized performance
- No debug info
- Production endpoints

### Build APK:
```bash
flutter build apk --release
```

### Build iOS:
```bash
flutter build ios --release
```

---

## 📈 Performance Optimization

### Current Optimizations:
- Const constructors where possible
- Lazy loading of lesson content
- Efficient list rendering (ListView.builder)
- Image caching (Future: cached_network_image)

### Future Optimizations:
- Pagination for recommendations
- Image compression
- Background data sync
- Code splitting

---

## 🌐 API Integration (Planned)

### Endpoints Needed:

**User Service:**
- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/user/profile`
- `PUT /api/user/profile`

**Budget Service:**
- `GET /api/budget/{userId}`
- `POST /api/budget/transaction`
- `GET /api/budget/categories`

**Lesson Service:**
- `GET /api/lessons`
- `POST /api/lessons/{id}/complete`
- `GET /api/lessons/recommended`

**Recommendation Service:**
- `GET /api/recommendations?location={loc}&category={cat}`
- `GET /api/recommendations/{id}`
- `POST /api/recommendations/{id}/review`

---

## 🗄️ Data Models

### User Model
```dart
{
  "name": String,
  "email": String,
  "location": String,
  "familySize": int,
  "incomeRange": String,
  "primaryGoal": String,
  "expenses": List<String>
}
```

### Budget Category
```dart
{
  "name": String,
  "budgeted": double,
  "spent": double,
  "icon": String (emoji),
  "color": int (hex)
}
```

### Lesson Model
```dart
{
  "id": String,
  "title": String,
  "description": String,
  "category": String,
  "duration": int (minutes),
  "points": int,
  "content": List<String>,
  "icon": String (emoji),
  "isCompleted": bool
}
```

### Recommendation Model
```dart
{
  "id": String,
  "title": String,
  "description": String,
  "category": String,
  "location": String,
  "distance": double (km),
  "priceRange": String,
  "rating": double,
  "savingsInfo": String,
  "icon": String (emoji)
}
```

---

## 🔄 State Lifecycle

### App Launch:
1. `main()` → Initialize providers
2. `SplashScreen` → Show branding
3. Auto-navigate to `WelcomeScreen`

### User Flow:
1. Registration → Creates `UserModel`
2. Onboarding → Populates user data
3. `UserProvider.setUser()` → Triggers dashboard
4. `BudgetProvider.initializeBudget()` → Creates categories
5. Dashboard renders with personalized data

### Session:
- State persists in memory during app lifetime
- Navigate freely between screens
- Providers maintain global state

---

## 🎯 Next Steps for Production

1. **Backend Development**
   - Node.js/Express or Python/Flask
   - PostgreSQL database
   - Redis for caching

2. **API Integration**
   - Google Places API (local businesses)
   - Plaid API (banking, optional)
   - SendGrid (email notifications)

3. **Features**
   - User authentication
   - Data persistence
   - Push notifications
   - Multi-language

4. **Deployment**
   - App Store (iOS)
   - Google Play (Android)
   - Backend on AWS/GCP

---

This architecture is designed to be:
- ✅ Simple to understand
- ✅ Easy to extend
- ✅ Scalable for growth
- ✅ Maintainable long-term

Perfect for a hackathon MVP that can evolve into production! 🚀

