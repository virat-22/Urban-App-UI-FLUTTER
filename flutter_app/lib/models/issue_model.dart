class Issue {
  final String id;
  final String userId;
  final String? userName;
  final String? userEmail;
  final String issueType;
  final String description;
  final Location location;
  final List<String> photos;
  final String status;
  final String priority;
  final String? department;
  final String? assignedTo;
  final String? resolutionNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  Issue({
    required this.id,
    required this.userId,
    this.userName,
    this.userEmail,
    required this.issueType,
    required this.description,
    required this.location,
    required this.photos,
    required this.status,
    required this.priority,
    this.department,
    this.assignedTo,
    this.resolutionNotes,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] is String
          ? json['userId']
          : json['userId']?['_id'] ?? '',
      userName: json['userId'] is Map ? json['userId']['name'] : null,
      userEmail: json['userId'] is Map ? json['userId']['email'] : null,
      issueType: json['issueType'] ?? '',
      description: json['description'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      photos: List<String>.from(json['photos'] ?? []),
      status: json['status'] ?? 'pending',
      priority: json['priority'] ?? 'medium',
      department: json['department'],
      assignedTo: json['assignedTo'],
      resolutionNotes: json['resolutionNotes'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.parse(json['resolvedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issueType': issueType,
      'description': description,
      'location': location.toJson(),
      'photos': photos,
    };
  }

  String get typeLabel {
    const labels = {
      'sanitation': 'Sanitation',
      'roads': 'Roads & Infrastructure',
      'water': 'Water Supply',
      'safety': 'Public Safety',
      'other': 'Other',
    };
    return labels[issueType] ?? issueType;
  }

  String get priorityLabel {
    const labels = {
      'low': 'Low',
      'medium': 'Medium',
      'high': 'High',
      'urgent': 'Urgent',
    };
    return labels[priority] ?? priority;
  }

  String get statusLabel {
    const labels = {
      'pending': 'Pending',
      'in-progress': 'In Progress',
      'resolved': 'Resolved',
      'closed': 'Closed',
    };
    return labels[status] ?? status;
  }
}

class Location {
  final String address;
  final Coordinates coordinates;

  Location({
    required this.address,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'] ?? '',
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'coordinates': coordinates.toJson(),
    };
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class DashboardStats {
  final int totalIssues;
  final List<StatusCount> issuesByStatus;
  final List<TypeCount> issuesByType;
  final List<PriorityCount> issuesByPriority;
  final List<Issue> recentIssues;

  DashboardStats({
    required this.totalIssues,
    required this.issuesByStatus,
    required this.issuesByType,
    required this.issuesByPriority,
    required this.recentIssues,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalIssues: json['totalIssues'] ?? 0,
      issuesByStatus: (json['issuesByStatus'] as List?)
              ?.map((e) => StatusCount.fromJson(e))
              .toList() ??
          [],
      issuesByType: (json['issuesByType'] as List?)
              ?.map((e) => TypeCount.fromJson(e))
              .toList() ??
          [],
      issuesByPriority: (json['issuesByPriority'] as List?)
              ?.map((e) => PriorityCount.fromJson(e))
              .toList() ??
          [],
      recentIssues: (json['recentIssues'] as List?)
              ?.map((e) => Issue.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class StatusCount {
  final String status;
  final int count;

  StatusCount({required this.status, required this.count});

  factory StatusCount.fromJson(Map<String, dynamic> json) {
    return StatusCount(
      status: json['status'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class TypeCount {
  final String type;
  final int count;

  TypeCount({required this.type, required this.count});

  factory TypeCount.fromJson(Map<String, dynamic> json) {
    return TypeCount(
      type: json['_id'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class PriorityCount {
  final String priority;
  final int count;

  PriorityCount({required this.priority, required this.count});

  factory PriorityCount.fromJson(Map<String, dynamic> json) {
    return PriorityCount(
      priority: json['_id'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

