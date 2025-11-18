import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/issue_provider.dart';
import '../../models/issue_model.dart';
import 'issue_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _filterStatus;
  String? _filterType;
  String? _filterPriority;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<IssueProvider>(context, listen: false).loadDashboardStats();
    });
  }

  void _applyFilters() {
    Provider.of<IssueProvider>(context, listen: false).loadIssues(
      status: _filterStatus,
      issueType: _filterType,
      priority: _filterPriority,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssueProvider>(
      builder: (context, issueProvider, _) {
        if (issueProvider.isLoading && issueProvider.stats == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = issueProvider.stats;

        return RefreshIndicator(
          onRefresh: () async {
            await issueProvider.loadDashboardStats();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Pending',
                        stats?.issuesByStatus
                                .firstWhere(
                                  (s) => s.status == 'pending',
                                  orElse: () => StatusCount(status: 'pending', count: 0),
                                )
                                .count ??
                            0,
                        Colors.orange,
                        Icons.pending,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'In Progress',
                        stats?.issuesByStatus
                                .firstWhere(
                                  (s) => s.status == 'in-progress',
                                  orElse: () => StatusCount(status: 'in-progress', count: 0),
                                )
                                .count ??
                            0,
                        Colors.blue,
                        Icons.sync,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Resolved',
                        stats?.issuesByStatus
                                .firstWhere(
                                  (s) => s.status == 'resolved',
                                  orElse: () => StatusCount(status: 'resolved', count: 0),
                                )
                                .count ??
                            0,
                        Colors.green,
                        Icons.check_circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Total',
                        stats?.totalIssues ?? 0,
                        Colors.grey,
                        Icons.list,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Charts
                Row(
                  children: [
                    Expanded(
                      child: _buildTypeChart(stats),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildPriorityChart(stats),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Filters
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _filterStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(),
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('All'),
                                  ),
                                  ...['pending', 'in-progress', 'resolved', 'closed']
                                      .map((status) => DropdownMenuItem(
                                            value: status,
                                            child: Text(status),
                                          )),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _filterStatus = value;
                                  });
                                  _applyFilters();
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _filterType,
                                decoration: const InputDecoration(
                                  labelText: 'Type',
                                  border: OutlineInputBorder(),
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('All'),
                                  ),
                                  ...['sanitation', 'roads', 'water', 'safety', 'other']
                                      .map((type) => DropdownMenuItem(
                                            value: type,
                                            child: Text(type),
                                          )),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _filterType = value;
                                  });
                                  _applyFilters();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Issues List
                const Text(
                  'Recent Issues',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                issueProvider.issues.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text('No issues found'),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: issueProvider.issues.length,
                        itemBuilder: (context, index) {
                          final issue = issueProvider.issues[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _getStatusColor(issue.status),
                                child: Icon(
                                  _getStatusIcon(issue.status),
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(issue.typeLabel),
                              subtitle: Text(
                                issue.description.length > 50
                                    ? '${issue.description.substring(0, 50)}...'
                                    : issue.description,
                              ),
                              trailing: Chip(
                                label: Text(issue.statusLabel),
                                backgroundColor: _getStatusColor(issue.status),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        IssueDetailScreen(issueId: issue.id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    int count,
    Color color,
    IconData icon,
  ) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Icon(icon, color: color),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChart(DashboardStats? stats) {
    if (stats == null || stats.issuesByType.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: Text('No data')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Issues by Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: stats.issuesByType.asMap().entries.map((entry) {
                    final colors = [
                      Colors.red,
                      Colors.blue,
                      Colors.orange,
                      Colors.green,
                      Colors.purple,
                    ];
                    return PieChartSectionData(
                      value: entry.value.count.toDouble(),
                      title: entry.value.type,
                      color: colors[entry.key % colors.length],
                      radius: 80,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityChart(DashboardStats? stats) {
    if (stats == null || stats.issuesByPriority.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: Text('No data')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Issues by Priority',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: stats.issuesByPriority
                          .map((e) => e.count)
                          .reduce((a, b) => a > b ? a : b)
                      .toDouble() +
                      5,
                  barGroups: stats.issuesByPriority.asMap().entries.map((entry) {
                    final colors = {
                      'low': Colors.green,
                      'medium': Colors.orange,
                      'high': Colors.red,
                      'urgent': Colors.purple,
                    };
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.count.toDouble(),
                          color: colors[entry.value.priority] ?? Colors.grey,
                          width: 20,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() <
                              stats.issuesByPriority.length) {
                            return Text(
                              stats.issuesByPriority[value.toInt()].priority,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in-progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'in-progress':
        return Icons.sync;
      case 'resolved':
        return Icons.check_circle;
      case 'closed':
        return Icons.close;
      default:
        return Icons.help;
    }
  }
}

