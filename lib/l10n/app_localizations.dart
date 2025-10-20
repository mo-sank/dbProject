import 'package:flutter/material.dart';
import 'translations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appName => translations[locale.languageCode]?['app_name'] ?? translations['en']!['app_name']!;
  String get appTagline => translations[locale.languageCode]?['app_tagline'] ?? translations['en']!['app_tagline']!;
  
  // Welcome Screen
  String get welcomeTitle => translations[locale.languageCode]?['welcome_title'] ?? translations['en']!['welcome_title']!;
  String get welcomeSubtitle => translations[locale.languageCode]?['welcome_subtitle'] ?? translations['en']!['welcome_subtitle']!;
  String get getStarted => translations[locale.languageCode]?['get_started'] ?? translations['en']!['get_started']!;
  
  // Features
  String get featureTrackBudget => translations[locale.languageCode]?['feature_track_budget'] ?? translations['en']!['feature_track_budget']!;
  String get featureTrackBudgetDesc => translations[locale.languageCode]?['feature_track_budget_desc'] ?? translations['en']!['feature_track_budget_desc']!;
  String get featureLearnEarn => translations[locale.languageCode]?['feature_learn_earn'] ?? translations['en']!['feature_learn_earn']!;
  String get featureLearnEarnDesc => translations[locale.languageCode]?['feature_learn_earn_desc'] ?? translations['en']!['feature_learn_earn_desc']!;
  String get featureLocalRecs => translations[locale.languageCode]?['feature_local_recs'] ?? translations['en']!['feature_local_recs']!;
  String get featureLocalRecsDesc => translations[locale.languageCode]?['feature_local_recs_desc'] ?? translations['en']!['feature_local_recs_desc']!;
  
  // Registration
  String get letsGetStarted => translations[locale.languageCode]?['lets_get_started'] ?? translations['en']!['lets_get_started']!;
  String get createAccountSubtitle => translations[locale.languageCode]?['create_account_subtitle'] ?? translations['en']!['create_account_subtitle']!;
  String get fullName => translations[locale.languageCode]?['full_name'] ?? translations['en']!['full_name']!;
  String get enterName => translations[locale.languageCode]?['enter_name'] ?? translations['en']!['enter_name']!;
  String get email => translations[locale.languageCode]?['email'] ?? translations['en']!['email']!;
  String get enterEmail => translations[locale.languageCode]?['enter_email'] ?? translations['en']!['enter_email']!;
  String get continueBtn => translations[locale.languageCode]?['continue'] ?? translations['en']!['continue']!;
  String get dataSecure => translations[locale.languageCode]?['data_secure'] ?? translations['en']!['data_secure']!;
  
  // Onboarding Chat
  String get chatWithAI => translations[locale.languageCode]?['chat_with_ai'] ?? translations['en']!['chat_with_ai']!;
  String get typeAnswer => translations[locale.languageCode]?['type_answer'] ?? translations['en']!['type_answer']!;
  String get tapToContinue => translations[locale.languageCode]?['tap_to_continue'] ?? translations['en']!['tap_to_continue']!;
  
  // Dashboard
  String get welcomeBack => translations[locale.languageCode]?['welcome_back'] ?? translations['en']!['welcome_back']!;
  String get monthlyBudget => translations[locale.languageCode]?['monthly_budget'] ?? translations['en']!['monthly_budget']!;
  String get remaining => translations[locale.languageCode]?['remaining'] ?? translations['en']!['remaining']!;
  String get savingsGoal => translations[locale.languageCode]?['savings_goal'] ?? translations['en']!['savings_goal']!;
  String get complete => translations[locale.languageCode]?['complete'] ?? translations['en']!['complete']!;
  String get aiMentorSays => translations[locale.languageCode]?['ai_mentor_says'] ?? translations['en']!['ai_mentor_says']!;
  String get quickActions => translations[locale.languageCode]?['quick_actions'] ?? translations['en']!['quick_actions']!;
  String get viewBudget => translations[locale.languageCode]?['view_budget'] ?? translations['en']!['view_budget']!;
  String get findDeals => translations[locale.languageCode]?['find_deals'] ?? translations['en']!['find_deals']!;
  
  // Navigation
  String get home => translations[locale.languageCode]?['home'] ?? translations['en']!['home']!;
  String get learn => translations[locale.languageCode]?['learn'] ?? translations['en']!['learn']!;
  String get explore => translations[locale.languageCode]?['explore'] ?? translations['en']!['explore']!;
  String get profile => translations[locale.languageCode]?['profile'] ?? translations['en']!['profile']!;
  
  // Budget
  String get totalBudget => translations[locale.languageCode]?['total_budget'] ?? translations['en']!['total_budget']!;
  String get spent => translations[locale.languageCode]?['spent'] ?? translations['en']!['spent']!;
  String get budgetDistribution => translations[locale.languageCode]?['budget_distribution'] ?? translations['en']!['budget_distribution']!;
  String get categoryBreakdown => translations[locale.languageCode]?['category_breakdown'] ?? translations['en']!['category_breakdown']!;
  String get budgetOverview => translations[locale.languageCode]?['budget_overview'] ?? translations['en']!['budget_overview']!;
  
  // Lessons
  String get learnAndEarn => translations[locale.languageCode]?['learn_and_earn'] ?? translations['en']!['learn_and_earn']!;
  String get lessonsSubtitle => translations[locale.languageCode]?['lessons_subtitle'] ?? translations['en']!['lessons_subtitle']!;
  String get points => translations[locale.languageCode]?['points'] ?? translations['en']!['points']!;
  String get completed => translations[locale.languageCode]?['completed'] ?? translations['en']!['completed']!;
  String get total => translations[locale.languageCode]?['total'] ?? translations['en']!['total']!;
  String get keyPoints => translations[locale.languageCode]?['key_points'] ?? translations['en']!['key_points']!;
  String get backToLessons => translations[locale.languageCode]?['back_to_lessons'] ?? translations['en']!['back_to_lessons']!;
  String get congratulations => translations[locale.languageCode]?['congratulations'] ?? translations['en']!['congratulations']!;
  String get earnedPoints => translations[locale.languageCode]?['earned_points'] ?? translations['en']!['earned_points']!;
  String get awesome => translations[locale.languageCode]?['awesome'] ?? translations['en']!['awesome']!;
  String get tapToReveal => translations[locale.languageCode]?['tap_to_reveal'] ?? translations['en']!['tap_to_reveal']!;
  
  // Recommendations
  String get localDeals => translations[locale.languageCode]?['local_deals'] ?? translations['en']!['local_deals']!;
  String get affordableServicesNear => translations[locale.languageCode]?['affordable_services_near'] ?? translations['en']!['affordable_services_near']!;
  String get all => translations[locale.languageCode]?['all'] ?? translations['en']!['all']!;
  String get groceries => translations[locale.languageCode]?['groceries'] ?? translations['en']!['groceries']!;
  String get childcare => translations[locale.languageCode]?['childcare'] ?? translations['en']!['childcare']!;
  String get transport => translations[locale.languageCode]?['transport'] ?? translations['en']!['transport']!;
  String get banking => translations[locale.languageCode]?['banking'] ?? translations['en']!['banking']!;
  
  // Profile
  String get location => translations[locale.languageCode]?['location'] ?? translations['en']!['location']!;
  String get familySize => translations[locale.languageCode]?['family_size'] ?? translations['en']!['family_size']!;
  String get incomeRange => translations[locale.languageCode]?['income_range'] ?? translations['en']!['income_range']!;
  String get primaryGoal => translations[locale.languageCode]?['primary_goal'] ?? translations['en']!['primary_goal']!;
  String get pointsEarned => translations[locale.languageCode]?['points_earned'] ?? translations['en']!['points_earned']!;
  String get lessonsCompleted => translations[locale.languageCode]?['lessons_completed'] ?? translations['en']!['lessons_completed']!;
  String get language => translations[locale.languageCode]?['language'] ?? translations['en']!['language']!;
  String get selectLanguage => translations[locale.languageCode]?['select_language'] ?? translations['en']!['select_language']!;
  
  // Validation
  String get pleaseEnterName => translations[locale.languageCode]?['please_enter_name'] ?? translations['en']!['please_enter_name']!;
  String get pleaseEnterEmail => translations[locale.languageCode]?['please_enter_email'] ?? translations['en']!['please_enter_email']!;
  String get pleaseEnterValidEmail => translations[locale.languageCode]?['please_enter_valid_email'] ?? translations['en']!['please_enter_valid_email']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Supported languages
const List<String> supportedLanguages = [
  'en', // English
  'es', // Spanish
  'fr', // French
  'de', // German
  'it', // Italian
  'pt', // Portuguese
  'zh', // Chinese
  'ar', // Arabic
  'hi', // Hindi
  'ru', // Russian
  'ja', // Japanese
  'ko', // Korean
  'tr', // Turkish
  'pl', // Polish
  'nl', // Dutch
];

const Map<String, String> languageNames = {
  'en': 'English',
  'es': 'Español',
  'fr': 'Français',
  'de': 'Deutsch',
  'it': 'Italiano',
  'pt': 'Português',
  'zh': '中文',
  'ar': 'العربية',
  'hi': 'हिन्दी',
  'ru': 'Русский',
  'ja': '日本語',
  'ko': '한국어',
  'tr': 'Türkçe',
  'pl': 'Polski',
  'nl': 'Nederlands',
};

