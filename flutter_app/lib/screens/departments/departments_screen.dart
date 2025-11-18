import 'package:flutter/material.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDepartmentCard(
            context,
            'Public Works',
            45,
            89,
            75,
            Colors.blue,
            Icons.construction,
          ),
          const SizedBox(height: 16),
          _buildDepartmentCard(
            context,
            'Sanitation',
            28,
            62,
            85,
            Colors.green,
            Icons.delete,
          ),
          const SizedBox(height: 16),
          _buildDepartmentCard(
            context,
            'Utilities',
            32,
            71,
            80,
            Colors.orange,
            Icons.bolt,
          ),
          const SizedBox(height: 16),
          _buildDepartmentCard(
            context,
            'Public Safety',
            18,
            45,
            90,
            Colors.red,
            Icons.security,
          ),
          const SizedBox(height: 16),
          _buildDepartmentCard(
            context,
            'Water Supply',
            25,
            58,
            82,
            Colors.cyan,
            Icons.water_drop,
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(
    BuildContext context,
    String name,
    int activeIssues,
    int resolvedThisMonth,
    int efficiency,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Active Issues: $activeIssues',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Resolved This Month: $resolvedThisMonth',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: efficiency / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$efficiency% Efficiency',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

