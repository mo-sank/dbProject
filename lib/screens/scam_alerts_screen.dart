import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../providers/scam_alert_provider.dart';
import '../models/scam_alert_model.dart';
import '../l10n/app_localizations.dart';

class ScamAlertsScreen extends StatefulWidget {
  const ScamAlertsScreen({super.key});

  @override
  State<ScamAlertsScreen> createState() => _ScamAlertsScreenState();
}

class _ScamAlertsScreenState extends State<ScamAlertsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildCategoryFilter(),
              _buildTabBar(),
              Expanded(child: _buildTabContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Scam Alerts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => context.read<ScamAlertProvider>().refreshAlerts(),
              icon: const Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Consumer<ScamAlertProvider>(
      builder: (context, scamAlertProvider, child) {
        return FadeInDown(
          delay: const Duration(milliseconds: 100),
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: ScamAlertProvider.categories.length,
              itemBuilder: (context, index) {
                final category = ScamAlertProvider.categories[index];
                final isSelected = scamAlertProvider.selectedCategory == category;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      scamAlertProvider.setCategory(category);
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'All Alerts'),
            Tab(text: 'High Priority'),
            Tab(text: 'Recent'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildAllAlertsList(),
        _buildHighPriorityAlertsList(),
        _buildRecentAlertsList(),
      ],
    );
  }

  Widget _buildAllAlertsList() {
    return Consumer<ScamAlertProvider>(
      builder: (context, scamAlertProvider, child) {
        if (scamAlertProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (scamAlertProvider.error != null) {
          return _buildErrorWidget(scamAlertProvider.error!);
        }

        if (scamAlertProvider.filteredAlerts.isEmpty) {
          return _buildEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: () => scamAlertProvider.refreshAlerts(),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: scamAlertProvider.filteredAlerts.length,
            itemBuilder: (context, index) {
              final alert = scamAlertProvider.filteredAlerts[index];
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                child: _ScamAlertCard(alert: alert),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHighPriorityAlertsList() {
    return Consumer<ScamAlertProvider>(
      builder: (context, scamAlertProvider, child) {
        if (scamAlertProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (scamAlertProvider.error != null) {
          return _buildErrorWidget(scamAlertProvider.error!);
        }

        final highPriorityAlerts = scamAlertProvider.getHighPriorityAlerts();
        if (highPriorityAlerts.isEmpty) {
          return _buildEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: () => scamAlertProvider.refreshAlerts(),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: highPriorityAlerts.length,
            itemBuilder: (context, index) {
              final alert = highPriorityAlerts[index];
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                child: _ScamAlertCard(alert: alert),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRecentAlertsList() {
    return Consumer<ScamAlertProvider>(
      builder: (context, scamAlertProvider, child) {
        if (scamAlertProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (scamAlertProvider.error != null) {
          return _buildErrorWidget(scamAlertProvider.error!);
        }

        final recentAlerts = scamAlertProvider.getRecentAlerts();
        if (recentAlerts.isEmpty) {
          return _buildEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: () => scamAlertProvider.refreshAlerts(),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: recentAlerts.length,
            itemBuilder: (context, index) {
              final alert = recentAlerts[index];
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                child: _ScamAlertCard(alert: alert),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<ScamAlertProvider>().refreshAlerts(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No scam alerts found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Great! No active scams detected in your area.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<ScamAlertProvider>().clearFilters(),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}

class _ScamAlertCard extends StatelessWidget {
  final ScamAlert alert;

  const _ScamAlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: _getPriorityColor(alert.priority).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => _showAlertDetails(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(alert.priority).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getCategoryIcon(alert.category),
                      color: _getPriorityColor(alert.priority),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.alert,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alert.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildPriorityBadge(),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 20, color: Colors.blue[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        alert.tip,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.category, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    alert.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(alert.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge() {
    Color badgeColor;
    String badgeText;
    
    switch (alert.priority) {
      case 1:
        badgeColor = Colors.red;
        badgeText = 'HIGH';
        break;
      case 2:
        badgeColor = Colors.orange;
        badgeText = 'MED';
        break;
      case 3:
        badgeColor = Colors.green;
        badgeText = 'LOW';
        break;
      default:
        badgeColor = Colors.grey;
        badgeText = 'N/A';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        badgeText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Financial':
        return Icons.account_balance;
      case 'Immigration':
        return Icons.people;
      case 'Government':
        return Icons.account_balance_wallet;
      case 'Employment':
        return Icons.work;
      case 'General':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _showAlertDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AlertDetailsModal(alert: alert),
    );
  }
}

class _AlertDetailsModal extends StatelessWidget {
  final ScamAlert alert;

  const _AlertDetailsModal({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _getPriorityColor(alert.priority).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getCategoryIcon(alert.category),
                          color: _getPriorityColor(alert.priority),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert.alert,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              alert.location,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildPriorityBadge(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, size: 24, color: Colors.blue[600]),
                            const SizedBox(width: 8),
                            const Text(
                              'Safety Tip',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          alert.tip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _DetailRow(
                    icon: Icons.category,
                    label: 'Category',
                    value: alert.category,
                  ),
                  _DetailRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: alert.location,
                  ),
                  _DetailRow(
                    icon: Icons.schedule,
                    label: 'Alert Date',
                    value: _formatFullDate(alert.createdAt),
                  ),
                  _DetailRow(
                    icon: Icons.priority_high,
                    label: 'Priority',
                    value: _getPriorityText(alert.priority),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Alert marked as read!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Mark as Read',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge() {
    Color badgeColor;
    String badgeText;
    
    switch (alert.priority) {
      case 1:
        badgeColor = Colors.red;
        badgeText = 'HIGH PRIORITY';
        break;
      case 2:
        badgeColor = Colors.orange;
        badgeText = 'MEDIUM PRIORITY';
        break;
      case 3:
        badgeColor = Colors.green;
        badgeText = 'LOW PRIORITY';
        break;
      default:
        badgeColor = Colors.grey;
        badgeText = 'UNKNOWN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        badgeText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Financial':
        return Icons.account_balance;
      case 'Immigration':
        return Icons.people;
      case 'Government':
        return Icons.account_balance_wallet;
      case 'Employment':
        return Icons.work;
      case 'General':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return 'High Priority';
      case 2:
        return 'Medium Priority';
      case 3:
        return 'Low Priority';
      default:
        return 'Unknown';
    }
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
