import 'user_model.dart';

class VideoModel {
  final String id;
  final String url;
  final String? thumbnailUrl;
  final UserModel user;
  final String description;
  final List<String> hashtags;
  final int likes;
  final int comments;
  final int shares;
  final int views;
  final bool isLiked;
  final bool isFollowing;
  final DateTime createdAt;
  final Duration duration;
  final String? musicTitle;
  final String? musicArtist;

  VideoModel({
    required this.id,
    required this.url,
    this.thumbnailUrl,
    required this.user,
    required this.description,
    this.hashtags = const [],
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.views = 0,
    this.isLiked = false,
    this.isFollowing = false,
    required this.createdAt,
    this.duration = const Duration(seconds: 30),
    this.musicTitle,
    this.musicArtist,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      user: UserModel.fromJson(json['user'] ?? {}),
      description: json['description'] ?? '',
      hashtags: List<String>.from(json['hashtags'] ?? []),
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      views: json['views'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      duration: Duration(seconds: json['duration'] ?? 30),
      musicTitle: json['musicTitle'],
      musicArtist: json['musicArtist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'user': user.toJson(),
      'description': description,
      'hashtags': hashtags,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'views': views,
      'isLiked': isLiked,
      'isFollowing': isFollowing,
      'createdAt': createdAt.toIso8601String(),
      'duration': duration.inSeconds,
      'musicTitle': musicTitle,
      'musicArtist': musicArtist,
    };
  }

  VideoModel copyWith({
    String? id,
    String? url,
    String? thumbnailUrl,
    UserModel? user,
    String? description,
    List<String>? hashtags,
    int? likes,
    int? comments,
    int? shares,
    int? views,
    bool? isLiked,
    bool? isFollowing,
    DateTime? createdAt,
    Duration? duration,
    String? musicTitle,
    String? musicArtist,
  }) {
    return VideoModel(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      user: user ?? this.user,
      description: description ?? this.description,
      hashtags: hashtags ?? this.hashtags,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      views: views ?? this.views,
      isLiked: isLiked ?? this.isLiked,
      isFollowing: isFollowing ?? this.isFollowing,
      createdAt: createdAt ?? this.createdAt,
      duration: duration ?? this.duration,
      musicTitle: musicTitle ?? this.musicTitle,
      musicArtist: musicArtist ?? this.musicArtist,
    );
  }

  String get formattedViews {
    if (views < 1000) return views.toString();
    if (views < 1000000) return '${(views / 1000).toStringAsFixed(1)}K';
    return '${(views / 1000000).toStringAsFixed(1)}M';
  }

  String get formattedLikes {
    if (likes < 1000) return likes.toString();
    if (likes < 1000000) return '${(likes / 1000).toStringAsFixed(1)}K';
    return '${(likes / 1000000).toStringAsFixed(1)}M';
  }

  String get formattedComments {
    if (comments < 1000) return comments.toString();
    if (comments < 1000000) return '${(comments / 1000).toStringAsFixed(1)}K';
    return '${(comments / 1000000).toStringAsFixed(1)}M';
  }

  String get formattedShares {
    if (shares < 1000) return shares.toString();
    if (shares < 1000000) return '${(shares / 1000).toStringAsFixed(1)}K';
    return '${(shares / 1000000).toStringAsFixed(1)}M';
  }

  static List<VideoModel> getSampleVideos() {
    final sampleUsers = [
      UserModel(
        id: '1',
        name: 'أحمد محمد',
        username: '@ahmed_m',
        email: 'ahmed@example.com',
        avatar: 'https://via.placeholder.com/50/4ECDC4/FFFFFF?text=أ',
        followers: 1250,
        following: 890,
        videosCount: 45,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        isOnline: true,
      ),
      UserModel(
        id: '2',
        name: 'فاطمة علي',
        username: '@fatima_a',
        email: 'fatima@example.com',
        avatar: 'https://via.placeholder.com/50/FF6B6B/FFFFFF?text=ف',
        followers: 890,
        following: 456,
        videosCount: 32,
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        isOnline: false,
      ),
      UserModel(
        id: '3',
        name: 'محمد سالم',
        username: '@mohammed_s',
        email: 'mohammed@example.com',
        avatar: 'https://via.placeholder.com/50/F39C12/FFFFFF?text=م',
        followers: 2100,
        following: 234,
        videosCount: 67,
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        isOnline: true,
      ),
    ];

    return [
      VideoModel(
        id: '1',
        url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
        thumbnailUrl: 'https://via.placeholder.com/400x600/FF6B6B/FFFFFF?text=فيديو+1',
        user: sampleUsers[0],
        description: 'فيديو رائع من الطبيعة الخلابة 🌿',
        hashtags: ['#طبيعة', '#جمال', '#سفر'],
        likes: 1250,
        comments: 89,
        shares: 45,
        views: 15600,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        duration: const Duration(seconds: 45),
        musicTitle: 'موسيقى هادئة',
        musicArtist: 'فنان مجهول',
      ),
      VideoModel(
        id: '2',
        url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
        thumbnailUrl: 'https://via.placeholder.com/400x600/45B7D1/FFFFFF?text=فيديو+2',
        user: sampleUsers[1],
        description: 'طبخة لذيذة من المطبخ العربي 🍽️',
        hashtags: ['#طبخ', '#وصفات', '#عربي'],
        likes: 890,
        comments: 156,
        shares: 78,
        views: 12300,
        isLiked: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        duration: const Duration(seconds: 60),
        musicTitle: 'أغنية شعبية',
        musicArtist: 'مطرب تراثي',
      ),
      VideoModel(
        id: '3',
        url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
        thumbnailUrl: 'https://via.placeholder.com/400x600/2C3E50/FFFFFF?text=فيديو+3',
        user: sampleUsers[2],
        description: 'تمارين رياضية في المنزل 💪',
        hashtags: ['#رياضة', '#صحة', '#تمارين'],
        likes: 2100,
        comments: 234,
        shares: 120,
        views: 28900,
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        duration: const Duration(seconds: 55),
        musicTitle: 'موسيقى تحفيزية',
        musicArtist: 'DJ Fitness',
      ),
    ];
  }
}