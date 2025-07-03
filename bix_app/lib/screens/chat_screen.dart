import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<ChatModel> _chats = [];
  List<UserModel> _onlineUsers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadChats();
    _loadOnlineUsers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadChats() {
    setState(() {
      _chats = ChatModel.getSampleChats();
    });
  }

  void _loadOnlineUsers() {
    setState(() {
      _onlineUsers = _getSampleUsers();
    });
  }

  List<UserModel> _getSampleUsers() {
    return [
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
        isVerified: true,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Search Bar
            _buildSearchBar(),
            
            // Tab Bar
            _buildTabBar(),
            
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildChatsTab(),
                  _buildOnlineTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Start new chat
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            AppStrings.chat,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Show chat settings
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'البحث في المحادثات...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        onChanged: (value) {
          // TODO: Implement search
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'المحادثات'),
          Tab(text: 'متصل الآن'),
        ],
      ),
    );
  }

  Widget _buildChatsTab() {
    if (_chats.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.grey,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد محادثات',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ابدأ محادثة جديدة',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        return _buildChatItem(_chats[index]);
      },
    );
  }

  Widget _buildChatItem(ChatModel chat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(chat: chat),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(
                    chat.user.avatar,
                  ),
                ),
                if (chat.user.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        chat.user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (chat.user.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: AppColors.accent,
                          size: 16,
                        ),
                      ],
                      const Spacer(),
                      Text(
                        chat.formattedTime,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (chat.lastMessage.isFromMe)
                        Icon(
                          chat.lastMessage.isRead ? Icons.done_all : Icons.done,
                          color: chat.lastMessage.isRead 
                              ? AppColors.accent 
                              : Colors.grey[400],
                          size: 16,
                        ),
                      if (chat.lastMessage.isFromMe) const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          chat.lastMessage.content,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineTab() {
    if (_onlineUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              color: Colors.grey,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'لا يوجد أحد متصل',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _onlineUsers.length,
      itemBuilder: (context, index) {
        return _buildOnlineUserItem(_onlineUsers[index]);
      },
    );
  }

  Widget _buildOnlineUserItem(UserModel user) {
    return GestureDetector(
      onTap: () {
        // TODO: Start chat with user
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(
                    user.avatar,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surface,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (user.isVerified) ...[
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
                    user.username,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Message button
            IconButton(
              onPressed: () {
                // TODO: Start chat
              },
              icon: const Icon(
                Icons.message,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Chat Models
class ChatModel {
  final String id;
  final UserModel user;
  final MessageModel lastMessage;
  final int unreadCount;
  final DateTime lastActivity;

  ChatModel({
    required this.id,
    required this.user,
    required this.lastMessage,
    this.unreadCount = 0,
    required this.lastActivity,
  });

  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);
    
    if (difference.inMinutes < 1) return 'الآن';
    if (difference.inHours < 1) return '${difference.inMinutes}د';
    if (difference.inDays < 1) return '${difference.inHours}س';
    if (difference.inDays < 7) return '${difference.inDays}ي';
    return '${(difference.inDays / 7).floor()}أ';
  }

  static List<ChatModel> getSampleChats() {
    final users = _getSampleUsersStatic();
    return [
      ChatModel(
        id: '1',
        user: users[0],
        lastMessage: MessageModel(
          id: '1',
          content: 'مرحباً! كيف حالك؟',
          isFromMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
        unreadCount: 2,
        lastActivity: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatModel(
        id: '2',
        user: users[1],
        lastMessage: MessageModel(
          id: '2',
          content: 'شكراً لك على الفيديو الرائع',
          isFromMe: true,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isRead: true,
        ),
        unreadCount: 0,
        lastActivity: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ChatModel(
        id: '3',
        user: users[2],
        lastMessage: MessageModel(
          id: '3',
          content: 'هل يمكننا التعاون في مشروع؟',
          isFromMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          isRead: true,
        ),
        unreadCount: 1,
        lastActivity: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }
}

class MessageModel {
  final String id;
  final String content;
  final bool isFromMe;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.content,
    required this.isFromMe,
    required this.timestamp,
    this.isRead = false,
  });
}

// Chat Detail Screen
class ChatDetailScreen extends StatefulWidget {
  final ChatModel chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    setState(() {
      _messages.addAll([
        MessageModel(
          id: '1',
          content: 'مرحباً! كيف حالك؟',
          isFromMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          isRead: true,
        ),
        MessageModel(
          id: '2',
          content: 'أهلاً! بخير والحمد لله',
          isFromMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
          isRead: true,
        ),
        MessageModel(
          id: '3',
          content: 'أعجبني فيديوك الأخير كثيراً',
          isFromMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: true,
        ),
      ]);
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _messageController.text.trim(),
      isFromMe: true,
      timestamp: DateTime.now(),
      isRead: false,
    );

    setState(() {
      _messages.add(message);
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                widget.chat.user.avatar,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.chat.user.isOnline ? AppStrings.online : AppStrings.offline,
                    style: TextStyle(
                      color: widget.chat.user.isOnline 
                          ? AppColors.success 
                          : Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Video call
            },
            icon: const Icon(Icons.videocam, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              // TODO: Voice call
            },
            icon: const Icon(Icons.call, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              // TODO: More options
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Attach file
                  },
                  icon: const Icon(
                    Icons.attach_file,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: AppStrings.typeMessage,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    return Align(
      alignment: message.isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: message.isFromMe ? AppColors.primary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18).copyWith(
            bottomRight: message.isFromMe ? const Radius.circular(4) : null,
            bottomLeft: !message.isFromMe ? const Radius.circular(4) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 10,
                  ),
                ),
                if (message.isFromMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    color: message.isRead 
                        ? AppColors.accent 
                        : Colors.white.withOpacity(0.7),
                    size: 12,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

// Static helper function
List<UserModel> _getSampleUsersStatic() {
    return [
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
        isVerified: true,
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
}