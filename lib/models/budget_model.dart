class BudgetCategory {
  final String name;
  final double budgeted;
  double spent;
  final String icon;
  final int color;

  BudgetCategory({
    required this.name,
    required this.budgeted,
    this.spent = 0,
    required this.icon,
    required this.color,
  });

  double get remaining => budgeted - spent;
  double get percentage => budgeted > 0 ? (spent / budgeted) * 100 : 0;
}

class SavingsGoal {
  final String name;
  final double target;
  double current;
  final String icon;

  SavingsGoal({
    required this.name,
    required this.target,
    this.current = 0,
    required this.icon,
  });

  double get percentage => (current / target) * 100;
  double get remaining => target - current;
}

