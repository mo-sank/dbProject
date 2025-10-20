import 'package:flutter/foundation.dart';
import '../models/scam_alert_model.dart';
import '../services/scam_alert_service.dart';
import '../services/firebase_service.dart';

class ScamAlertProvider with ChangeNotifier {
  final ScamAlertService _scamAlertService = ScamAlertService();
  FirebaseService? _firebaseService;

  List<ScamAlert> _alerts = [];
  List<ScamAlert> _filteredAlerts = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'All';
  String _userLocation = '';

  // Getters
  List<ScamAlert> get alerts => _alerts;
  List<ScamAlert> get filteredAlerts => _filteredAlerts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;
  String get userLocation => _userLocation;

  // Categories for filtering
  static const List<String> categories = [
    'All',
    'Financial',
    'Immigration',
    'Government',
    'Employment',
    'General',
  ];

  /// Set Firebase service
  void setFirebaseService(FirebaseService firebaseService) {
    _firebaseService = firebaseService;
  }

  /// Initialize alerts for user location
  Future<void> initializeAlerts(String location) async {
    _userLocation = location;
    _setLoading(true);
    _clearError();

    try {
      // Generate location-specific alerts
      _alerts = _scamAlertService.generateLocationAlerts(location);
      
      // Save to Firebase if available
      if (_firebaseService != null) {
        await _saveAlertsToFirebase();
      }

      _applyFilters();
    } catch (e) {
      _setError('Failed to initialize scam alerts: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Save alerts to Firebase
  Future<void> _saveAlertsToFirebase() async {
    if (_firebaseService == null) return;

    try {
      for (final alert in _alerts) {
        await _firebaseService!.saveScamAlert(alert);
      }
    } catch (e) {
      print('Error saving alerts to Firebase: $e');
    }
  }

  /// Load alerts from Firebase
  Future<void> loadAlertsFromFirebase() async {
    if (_firebaseService == null) return;

    _setLoading(true);
    _clearError();

    try {
      _alerts = await _firebaseService!.getScamAlerts(_userLocation);
      _applyFilters();
    } catch (e) {
      _setError('Failed to load alerts from Firebase: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Set category filter
  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  /// Apply current filters to alerts
  void _applyFilters() {
    _filteredAlerts = List.from(_alerts);

    // Apply category filter
    if (_selectedCategory != 'All') {
      _filteredAlerts = _filteredAlerts
          .where((alert) => alert.category == _selectedCategory)
          .toList();
    }

    // Sort by priority and creation date
    _filteredAlerts.sort((a, b) {
      final priorityComparison = a.priority.compareTo(b.priority);
      if (priorityComparison != 0) return priorityComparison;
      return b.createdAt.compareTo(a.createdAt);
    });

    notifyListeners();
  }

  /// Get alerts by category
  List<ScamAlert> getAlertsByCategory(String category) {
    return _alerts.where((alert) => alert.category == category).toList();
  }

  /// Get high priority alerts
  List<ScamAlert> getHighPriorityAlerts() {
    return _alerts.where((alert) => alert.priority == 1).toList();
  }

  /// Get recent alerts (within last 7 days)
  List<ScamAlert> getRecentAlerts() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return _alerts.where((alert) => alert.createdAt.isAfter(weekAgo)).toList();
  }

  /// Get alerts count by category
  Map<String, int> getAlertsCountByCategory() {
    Map<String, int> counts = {};
    for (String category in categories) {
      if (category == 'All') {
        counts[category] = _alerts.length;
      } else {
        counts[category] = _alerts.where((alert) => alert.category == category).length;
      }
    }
    return counts;
  }

  /// Get alert by ID
  ScamAlert? getAlertById(String id) {
    try {
      return _alerts.firstWhere((alert) => alert.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Mark alert as inactive
  Future<void> markAlertAsInactive(String alertId) async {
    final alertIndex = _alerts.indexWhere((alert) => alert.id == alertId);
    if (alertIndex != -1) {
      _alerts[alertIndex] = _alerts[alertIndex].copyWith(isActive: false);
      
      // Update in Firebase if available
      if (_firebaseService != null) {
        await _firebaseService!.updateScamAlert(_alerts[alertIndex]);
      }
      
      _applyFilters();
      notifyListeners();
    }
  }

  /// Refresh alerts
  Future<void> refreshAlerts() async {
    if (_userLocation.isNotEmpty) {
      await initializeAlerts(_userLocation);
    }
  }

  /// Clear all filters
  void clearFilters() {
    _selectedCategory = 'All';
    _applyFilters();
    notifyListeners();
  }

  /// Get alerts for dashboard (high priority only)
  List<ScamAlert> getDashboardAlerts() {
    return getHighPriorityAlerts().take(3).toList();
  }

  /// Check if there are new alerts since last check
  bool hasNewAlerts(DateTime lastCheck) {
    return _alerts.any((alert) => alert.createdAt.isAfter(lastCheck));
  }

  /// Get alerts summary for user
  Map<String, dynamic> getAlertsSummary() {
    final highPriority = getHighPriorityAlerts().length;
    final recent = getRecentAlerts().length;
    final total = _alerts.length;

    return {
      'total': total,
      'highPriority': highPriority,
      'recent': recent,
      'categories': getAlertsCountByCategory(),
    };
  }

  /// Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
