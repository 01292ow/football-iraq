import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/video_model.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoModel video;
  final bool isActive;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onFollow;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.isActive,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onFollow,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  bool _isMuted = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    
    if (_isPlaying) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Background
        _buildVideoBackground(),
        
        // Video Overlay
        _buildVideoOverlay(),
        
        // Video Actions
        _buildVideoActions(),
        
        // Play/Pause Overlay
        if (!_isPlaying) _buildPlayOverlay(),
      ],
    );
  }

  Widget _buildVideoBackground() {
    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: widget.video.thumbnailUrl != null
            ? CachedNetworkImage(
                imageUrl: widget.video.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surface,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => _buildVideoPlaceholder(),
              )
            : _buildVideoPlaceholder(),
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.3),
            AppColors.secondary.withOpacity(0.3),
            AppColors.accent.withOpacity(0.3),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 80,
              color: Colors.white.withOpacity(0.8),
            ),
            const SizedBox(height: 16),
            Text(
              widget.video.user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.video.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 80,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                    widget.video.user.avatar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.video.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (widget.video.user.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: AppColors.accent,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        widget.video.user.username,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!widget.video.isFollowing)
                  GestureDetector(
                    onTap: widget.onFollow,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        AppStrings.follow,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              widget.video.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            
            // Hashtags
            if (widget.video.hashtags.isNotEmpty)
              Wrap(
                spacing: 8,
                children: widget.video.hashtags.map((hashtag) {
                  return Text(
                    hashtag,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 8),
            
            // Music Info
            if (widget.video.musicTitle != null)
              Row(
                children: [
                  const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${widget.video.musicTitle} - ${widget.video.musicArtist}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            
            // Views
            Text(
              '${widget.video.formattedViews} ${AppStrings.views}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoActions() {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Column(
        children: [
          // Like
          _buildActionButton(
            icon: widget.video.isLiked ? Icons.favorite : Icons.favorite_border,
            count: widget.video.formattedLikes,
            onTap: widget.onLike,
            color: widget.video.isLiked ? AppColors.like : Colors.white,
          ),
          const SizedBox(height: 20),
          
          // Comment
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            count: widget.video.formattedComments,
            onTap: widget.onComment,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          
          // Share
          _buildActionButton(
            icon: Icons.share,
            count: widget.video.formattedShares,
            onTap: widget.onShare,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          
          // Mute/Unmute
          _buildActionButton(
            icon: _isMuted ? Icons.volume_off : Icons.volume_up,
            onTap: _toggleMute,
            color: Colors.white,
            showCount: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? count,
    required VoidCallback onTap,
    required Color color,
    bool showCount = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          if (showCount && count != null) ...[
            const SizedBox(height: 4),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: const Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
    );
  }
}