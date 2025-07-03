class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String avatar;
  final String? bio;
  final bool isGuest;
  final int followers;
  final int following;
  final int videosCount;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastSeen;
  final bool isOnline;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatar,
    this.bio,
    this.isGuest = false,
    this.followers = 0,
    this.following = 0,
    this.videosCount = 0,
    this.isVerified = false,
    required this.createdAt,
    this.lastSeen,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'],
      isGuest: json['isGuest'] ?? false,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      videosCount: json['videosCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastSeen: json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'isGuest': isGuest,
      'followers': followers,
      'following': following,
      'videosCount': videosCount,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastSeen': lastSeen?.toIso8601String(),
      'isOnline': isOnline,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? avatar,
    String? bio,
    bool? isGuest,
    int? followers,
    int? following,
    int? videosCount,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastSeen,
    bool? isOnline,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      isGuest: isGuest ?? this.isGuest,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      videosCount: videosCount ?? this.videosCount,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  static UserModel createGuest() {
    return UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      name: 'ضيف',
      username: '@guest',
      email: 'guest@bix.com',
      avatar: 'https://via.placeholder.com/100/FF6B6B/FFFFFF?text=ضيف',
      isGuest: true,
      createdAt: DateTime.now(),
      isOnline: true,
    );
  }

  static UserModel createGoogleUser(String name, String email) {
    return UserModel(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      username: '@${name.toLowerCase().replaceAll(' ', '_')}',
      email: email,
      avatar: 'https://via.placeholder.com/100/4ECDC4/FFFFFF?text=G',
      followers: (100 + (DateTime.now().millisecondsSinceEpoch % 900)),
      following: (50 + (DateTime.now().millisecondsSinceEpoch % 450)),
      videosCount: (DateTime.now().millisecondsSinceEpoch % 50),
      createdAt: DateTime.now(),
      isOnline: true,
    );
  }

  static UserModel createFacebookUser(String name, String email) {
    return UserModel(
      id: 'facebook_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      username: '@${name.toLowerCase().replaceAll(' ', '_')}',
      email: email,
      avatar: 'https://via.placeholder.com/100/45B7D1/FFFFFF?text=F',
      followers: (100 + (DateTime.now().millisecondsSinceEpoch % 900)),
      following: (50 + (DateTime.now().millisecondsSinceEpoch % 450)),
      videosCount: (DateTime.now().millisecondsSinceEpoch % 50),
      createdAt: DateTime.now(),
      isOnline: true,
    );
  }
}