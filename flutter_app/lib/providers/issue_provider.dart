import 'package:flutter/foundation.dart';
import '../models/issue_model.dart';
import '../services/api_service.dart';

class IssueProvider with ChangeNotifier {
  List<Issue> _issues = [];
  DashboardStats? _stats;
  bool _isLoading = false;
  String? _error;

  List<Issue> get issues => _issues;
  DashboardStats? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadIssues({
    String? status,
    String? issueType,
    String? priority,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _issues = await ApiService.getIssues(
        status: status,
        issueType: issueType,
        priority: priority,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDashboardStats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stats = await ApiService.getDashboardStats();
      if (_stats != null) {
        _issues = _stats!.recentIssues;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createIssue({
    required String issueType,
    required String description,
    required Location location,
    required List<String> photoPaths,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.createIssue(
        issueType: issueType,
        description: description,
        location: location,
        photoPaths: photoPaths,
      );

      if (result['success']) {
        _issues.insert(0, result['data'] as Issue);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateIssue({
    required String id,
    String? status,
    String? priority,
    String? resolutionNotes,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.updateIssue(
        id: id,
        status: status,
        priority: priority,
        resolutionNotes: resolutionNotes,
      );

      if (result['success']) {
        final index = _issues.indexWhere((issue) => issue.id == id);
        if (index != -1) {
          _issues[index] = result['data'] as Issue;
        }
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<Issue?> getIssue(String id) async {
    try {
      return await ApiService.getIssue(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

