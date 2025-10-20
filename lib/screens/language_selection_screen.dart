import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';
import 'splash_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: const _LanguageList(),
    );
  }
}

class _LanguageList extends StatelessWidget {
  const _LanguageList();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: supportedLanguages.length,
      itemBuilder: (context, index) {
        final langCode = supportedLanguages[index];
        final langName = languageNames[langCode]!;
        final isSelected = languageProvider.locale.languageCode == langCode;
        
        return _LanguageOption(
          languageCode: langCode,
          languageName: langName,
          nativeName: _getNativeName(langCode),
          flag: _getFlag(langCode),
          isSelected: isSelected,
          onTap: () {
            languageProvider.setLanguage(langCode);
            
            // Navigate to welcome screen after selection
            Future.delayed(const Duration(milliseconds: 300), () {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                );
              }
            });
          },
        );
      },
    );
  }

  String _getFlag(String langCode) {
    const flags = {
      'en': '🇺🇸',
      'es': '🇪🇸',
      'fr': '🇫🇷',
      'de': '🇩🇪',
      'it': '🇮🇹',
      'pt': '🇧🇷',
      'zh': '🇨🇳',
      'ar': '🇸🇦',
      'hi': '🇮🇳',
      'ru': '🇷🇺',
      'ja': '🇯🇵',
      'ko': '🇰🇷',
      'tr': '🇹🇷',
      'pl': '🇵🇱',
      'nl': '🇳🇱',
    };
    return flags[langCode] ?? '🌍';
  }

  String _getNativeName(String langCode) {
    const names = {
      'en': 'English',
      'es': 'Español',
      'fr': 'Français',
      'de': 'Deutsch',
      'it': 'Italiano',
      'pt': 'Português',
      'zh': '中文 (简体)',
      'ar': 'العربية',
      'hi': 'हिन्दी',
      'ru': 'Русский',
      'ja': '日本語',
      'ko': '한국어',
      'tr': 'Türkçe',
      'pl': 'Polski',
      'nl': 'Nederlands',
    };
    return names[langCode] ?? langCode;
  }
}

class _LanguageOption extends StatelessWidget {
  final String languageCode;
  final String languageName;
  final String nativeName;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 0.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Text(
                  flag,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    nativeName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

