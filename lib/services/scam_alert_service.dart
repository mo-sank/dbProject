import '../models/scam_alert_model.dart';

class ScamAlertService {
  static final ScamAlertService _instance = ScamAlertService._internal();
  factory ScamAlertService() => _instance;
  ScamAlertService._internal();

  /// Generate location-specific scam alerts
  List<ScamAlert> generateLocationAlerts(String location) {
    final alerts = <ScamAlert>[];
    final now = DateTime.now();
    
    // Extract city and state from location
    final locationParts = location.split(',').map((e) => e.trim()).toList();
    final city = locationParts.isNotEmpty ? locationParts[0] : location;
    final state = locationParts.length > 1 ? locationParts[1] : '';

    // Generate alerts based on location patterns
    alerts.addAll(_generateGeneralAlerts(city, state, now));
    alerts.addAll(_generateLocationSpecificAlerts(city, state, now));
    alerts.addAll(_generateFinancialAlerts(city, state, now));
    alerts.addAll(_generateImmigrationAlerts(city, state, now));

    // Sort by priority (high priority first)
    alerts.sort((a, b) => a.priority.compareTo(b.priority));
    
    return alerts.take(5).toList(); // Return max 5 alerts
  }

  List<ScamAlert> _generateGeneralAlerts(String city, String state, DateTime now) {
    return [
      ScamAlert(
        id: 'general_1',
        alert: '⚠️ Scam Alert: Fake government calls asking for personal information.',
        tip: 'Government agencies never call asking for personal details.',
        location: city,
        category: 'Government',
        createdAt: now,
        priority: 1,
      ),
      ScamAlert(
        id: 'general_2',
        alert: '⚠️ Scam Alert: Phishing emails pretending to be from banks.',
        tip: 'Never click links from unknown emails. Call your bank directly.',
        location: city,
        category: 'Financial',
        createdAt: now,
        priority: 1,
      ),
    ];
  }

  List<ScamAlert> _generateLocationSpecificAlerts(String city, String state, DateTime now) {
    final alerts = <ScamAlert>[];

    // Major metropolitan areas
    if (_isMajorCity(city)) {
      alerts.add(ScamAlert(
        id: 'metro_1',
        alert: '⚠️ Scam Alert: Fake job postings for remote work in $city.',
        tip: 'Verify company details before applying to remote jobs.',
        location: city,
        category: 'Employment',
        createdAt: now,
        priority: 2,
      ));
    }

    // Border states
    if (_isBorderState(state)) {
      alerts.add(ScamAlert(
        id: 'border_1',
        alert: '⚠️ Scam Alert: Unauthorized immigration services in $city.',
        tip: 'Only use licensed immigration attorneys or accredited representatives.',
        location: city,
        category: 'Immigration',
        createdAt: now,
        priority: 1,
      ));
    }

    // High immigrant population areas
    if (_isHighImmigrantArea(city, state)) {
      alerts.add(ScamAlert(
        id: 'immigrant_1',
        alert: '⚠️ Scam Alert: Fake remittance services advertising low fees.',
        tip: 'Use only licensed remittance providers with proper credentials.',
        location: city,
        category: 'Financial',
        createdAt: now,
        priority: 1,
      ));
    }

    return alerts;
  }

  List<ScamAlert> _generateFinancialAlerts(String city, String state, DateTime now) {
    return [
      ScamAlert(
        id: 'financial_1',
        alert: '⚠️ Scam Alert: Fake tax preparation services in $city.',
        tip: 'Use only certified tax preparers with valid PTIN numbers.',
        location: city,
        category: 'Financial',
        createdAt: now,
        priority: 2,
      ),
      ScamAlert(
        id: 'financial_2',
        alert: '⚠️ Scam Alert: Fake loan offers with upfront fees.',
        tip: 'Legitimate lenders never ask for money upfront.',
        location: city,
        category: 'Financial',
        createdAt: now,
        priority: 1,
      ),
    ];
  }

  List<ScamAlert> _generateImmigrationAlerts(String city, String state, DateTime now) {
    final alerts = <ScamAlert>[];

    // Common immigration scams
    alerts.add(ScamAlert(
      id: 'immigration_1',
      alert: '⚠️ Scam Alert: Fake USCIS calls asking for payment.',
      tip: 'USCIS never calls asking for payment over the phone.',
      location: city,
      category: 'Immigration',
      createdAt: now,
      priority: 1,
    ));

    // If it's a major city, add more specific alerts
    if (_isMajorCity(city)) {
      alerts.add(ScamAlert(
        id: 'immigration_2',
        alert: '⚠️ Scam Alert: Fake notary services claiming to help with immigration.',
        tip: 'Only notaries with proper credentials can help with immigration forms.',
        location: city,
        category: 'Immigration',
        createdAt: now,
        priority: 2,
      ));
    }

    return alerts;
  }

  // Helper methods to determine location characteristics
  bool _isMajorCity(String city) {
    final majorCities = [
      'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
      'San Antonio', 'San Diego', 'Dallas', 'San Jose', 'Austin', 'Jacksonville',
      'Fort Worth', 'Columbus', 'Charlotte', 'San Francisco', 'Indianapolis',
      'Seattle', 'Denver', 'Washington', 'Boston', 'El Paso', 'Nashville',
      'Detroit', 'Oklahoma City', 'Portland', 'Las Vegas', 'Memphis', 'Louisville',
      'Baltimore', 'Milwaukee', 'Albuquerque', 'Tucson', 'Fresno', 'Sacramento',
      'Mesa', 'Kansas City', 'Atlanta', 'Long Beach', 'Colorado Springs', 'Raleigh',
      'Miami', 'Virginia Beach', 'Omaha', 'Oakland', 'Minneapolis', 'Tulsa',
      'Arlington', 'Tampa', 'New Orleans', 'Wichita', 'Cleveland', 'Bakersfield',
      'Aurora', 'Anaheim', 'Honolulu', 'Santa Ana', 'Corpus Christi', 'Riverside',
      'Lexington', 'Stockton', 'Toledo', 'St. Paul', 'Newark', 'Greensboro',
      'Plano', 'Henderson', 'Lincoln', 'Buffalo', 'Jersey City', 'Chula Vista',
      'Fort Wayne', 'Orlando', 'St. Petersburg', 'Chandler', 'Laredo', 'Norfolk',
      'Durham', 'Madison', 'Lubbock', 'Irvine', 'Winston-Salem', 'Glendale',
      'Garland', 'Hialeah', 'Reno', 'Chesapeake', 'Gilbert', 'Baton Rouge',
      'Irving', 'Scottsdale', 'North Las Vegas', 'Fremont', 'Boise', 'Richmond',
      'San Bernardino', 'Birmingham', 'Spokane', 'Rochester', 'Des Moines',
      'Modesto', 'Fayetteville', 'Tacoma', 'Oxnard', 'Fontana', 'Columbus',
      'Montgomery', 'Moreno Valley', 'Shreveport', 'Aurora', 'Yonkers', 'Akron',
      'Huntington Beach', 'Little Rock', 'Augusta', 'Amarillo', 'Glendale',
      'Mobile', 'Grand Rapids', 'Salt Lake City', 'Tallahassee', 'Huntsville',
      'Grand Prairie', 'Knoxville', 'Worcester', 'Newport News', 'Brownsville',
      'Overland Park', 'Santa Clarita', 'Providence', 'Garden Grove', 'Chattanooga',
      'Oceanside', 'Jackson', 'Fort Lauderdale', 'Santa Rosa', 'Rancho Cucamonga',
      'Port St. Lucie', 'Tempe', 'Ontario', 'Vancouver', 'Sioux Falls', 'Springfield',
      'Pembroke Pines', 'Rockford', 'Salem', 'Corona', 'Jacksonville', 'Paterson',
      'Henderson', 'Laredo', 'Salinas', 'Frisco', 'Cape Coral', 'Springfield',
      'Palmdale', 'Hollywood', 'Lakewood', 'Torrance', 'Naperville', 'Escondido',
      'Bridgeport', 'Killeen', 'Thousand Oaks', 'McKinney', 'Mesquite', 'McAllen',
      'New Haven', 'Miramar', 'Waco', 'Carrollton', 'Midland', 'Denton', 'Abilene',
      'Round Rock', 'Richardson', 'Odessa', 'Tyler', 'Lewisville', 'College Station',
      'Pearland', 'Frisco', 'Allen', 'Sugar Land', 'Beaumont', 'League City',
      'Longview', 'Bryan', 'Pharr', 'Baytown', 'Missouri City', 'Flower Mound',
      'Harlingen', 'Georgetown', 'Cedar Park', 'Pflugerville', 'New Braunfels',
      'Mansfield', 'Rowlett', 'Wylie', 'Sherman', 'Victoria', 'Galveston',
      'Temple', 'Keller', 'Coppell', 'Rockwall', 'Huntsville', 'Friendswood',
      'Weslaco', 'Conroe', 'Cedar Hill', 'Haltom City', 'DeSoto', 'Duncanville',
      'Grapevine', 'Colleyville', 'Southlake', 'Euless', 'Bedford', 'Hurst',
      'North Richland Hills', 'Richland Hills', 'Haltom City', 'Watauga',
      'Colleyville', 'Grapevine', 'Euless', 'Bedford', 'Hurst', 'North Richland Hills'
    ];
    
    return majorCities.any((majorCity) => 
      city.toLowerCase().contains(majorCity.toLowerCase()) ||
      majorCity.toLowerCase().contains(city.toLowerCase())
    );
  }

  bool _isBorderState(String state) {
    final borderStates = [
      'CA', 'AZ', 'NM', 'TX', 'FL', 'NY', 'VT', 'NH', 'ME', 'WA', 'ID', 'MT', 'ND', 'MN', 'MI', 'OH', 'PA', 'NY', 'VT', 'NH', 'ME'
    ];
    return borderStates.contains(state.toUpperCase());
  }

  bool _isHighImmigrantArea(String city, String state) {
    final highImmigrantCities = [
      'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
      'San Antonio', 'San Diego', 'Dallas', 'San Jose', 'Austin', 'Jacksonville',
      'San Francisco', 'Seattle', 'Denver', 'Washington', 'Boston', 'Miami',
      'Atlanta', 'Detroit', 'Minneapolis', 'Portland', 'Las Vegas', 'Nashville',
      'Memphis', 'Louisville', 'Baltimore', 'Milwaukee', 'Albuquerque', 'Tucson',
      'Fresno', 'Sacramento', 'Mesa', 'Kansas City', 'Long Beach', 'Colorado Springs',
      'Raleigh', 'Virginia Beach', 'Omaha', 'Oakland', 'Tulsa', 'Arlington',
      'Tampa', 'New Orleans', 'Wichita', 'Cleveland', 'Bakersfield', 'Aurora',
      'Anaheim', 'Honolulu', 'Santa Ana', 'Corpus Christi', 'Riverside', 'Lexington',
      'Stockton', 'Toledo', 'St. Paul', 'Newark', 'Greensboro', 'Plano',
      'Henderson', 'Lincoln', 'Buffalo', 'Jersey City', 'Chula Vista', 'Fort Wayne',
      'Orlando', 'St. Petersburg', 'Chandler', 'Laredo', 'Norfolk', 'Durham',
      'Madison', 'Lubbock', 'Irvine', 'Winston-Salem', 'Glendale', 'Garland',
      'Hialeah', 'Reno', 'Chesapeake', 'Gilbert', 'Baton Rouge', 'Irving',
      'Scottsdale', 'North Las Vegas', 'Fremont', 'Boise', 'Richmond',
      'San Bernardino', 'Birmingham', 'Spokane', 'Rochester', 'Des Moines',
      'Modesto', 'Fayetteville', 'Tacoma', 'Oxnard', 'Fontana', 'Columbus',
      'Montgomery', 'Moreno Valley', 'Shreveport', 'Aurora', 'Yonkers', 'Akron',
      'Huntington Beach', 'Little Rock', 'Augusta', 'Amarillo', 'Glendale',
      'Mobile', 'Grand Rapids', 'Salt Lake City', 'Tallahassee', 'Huntsville',
      'Grand Prairie', 'Knoxville', 'Worcester', 'Newport News', 'Brownsville',
      'Overland Park', 'Santa Clarita', 'Providence', 'Garden Grove', 'Chattanooga',
      'Oceanside', 'Jackson', 'Fort Lauderdale', 'Santa Rosa', 'Rancho Cucamonga',
      'Port St. Lucie', 'Tempe', 'Ontario', 'Vancouver', 'Sioux Falls', 'Springfield',
      'Pembroke Pines', 'Rockford', 'Salem', 'Corona', 'Jacksonville', 'Paterson',
      'Henderson', 'Laredo', 'Salinas', 'Frisco', 'Cape Coral', 'Springfield',
      'Palmdale', 'Hollywood', 'Lakewood', 'Torrance', 'Naperville', 'Escondido',
      'Bridgeport', 'Killeen', 'Thousand Oaks', 'McKinney', 'Mesquite', 'McAllen',
      'New Haven', 'Miramar', 'Waco', 'Carrollton', 'Midland', 'Denton', 'Abilene',
      'Round Rock', 'Richardson', 'Odessa', 'Tyler', 'Lewisville', 'College Station',
      'Pearland', 'Frisco', 'Allen', 'Sugar Land', 'Beaumont', 'League City',
      'Longview', 'Bryan', 'Pharr', 'Baytown', 'Missouri City', 'Flower Mound',
      'Harlingen', 'Georgetown', 'Cedar Park', 'Pflugerville', 'New Braunfels',
      'Mansfield', 'Rowlett', 'Wylie', 'Sherman', 'Victoria', 'Galveston',
      'Temple', 'Keller', 'Coppell', 'Rockwall', 'Huntsville', 'Friendswood',
      'Weslaco', 'Conroe', 'Cedar Hill', 'Haltom City', 'DeSoto', 'Duncanville',
      'Grapevine', 'Colleyville', 'Southlake', 'Euless', 'Bedford', 'Hurst',
      'North Richland Hills', 'Richland Hills', 'Haltom City', 'Watauga',
      'Colleyville', 'Grapevine', 'Euless', 'Bedford', 'Hurst', 'North Richland Hills'
    ];
    
    return highImmigrantCities.any((immigrantCity) => 
      city.toLowerCase().contains(immigrantCity.toLowerCase()) ||
      immigrantCity.toLowerCase().contains(city.toLowerCase())
    );
  }

  /// Get alerts by category
  List<ScamAlert> getAlertsByCategory(List<ScamAlert> alerts, String category) {
    return alerts.where((alert) => alert.category == category).toList();
  }

  /// Get high priority alerts
  List<ScamAlert> getHighPriorityAlerts(List<ScamAlert> alerts) {
    return alerts.where((alert) => alert.priority == 1).toList();
  }

  /// Get recent alerts (within last 7 days)
  List<ScamAlert> getRecentAlerts(List<ScamAlert> alerts) {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return alerts.where((alert) => alert.createdAt.isAfter(weekAgo)).toList();
  }
}
