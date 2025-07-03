import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.secondary,
              AppColors.accent,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Section
                      _buildLogo(),
                      const SizedBox(height: 60),
                      
                      // Login Options
                      _buildLoginOptions(context, authProvider),
                      const SizedBox(height: 40),
                      
                      // Features Section
                      _buildFeatures(),
                      
                      // Error Message
                      if (authProvider.error != null) ...[
                        const SizedBox(height: 20),
                        _buildErrorMessage(authProvider.error!),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              'Bix',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.appSubtitle,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.appDescription,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginOptions(BuildContext context, AuthProvider authProvider) {
    return Column(
      children: [
        // Guest Login
        _buildLoginButton(
          onPressed: authProvider.isLoading ? null : () => authProvider.loginAsGuest(),
          icon: Icons.person_outline,
          text: AppStrings.loginAsGuest,
          backgroundColor: Colors.white.withOpacity(0.2),
          textColor: Colors.white,
          isLoading: authProvider.isLoading,
        ),
        const SizedBox(height: 16),
        
        // Google Login
        _buildLoginButton(
          onPressed: authProvider.isLoading ? null : () => authProvider.loginWithGoogle(),
          icon: Icons.search,
          text: AppStrings.loginWithGoogle,
          backgroundColor: Colors.red.withOpacity(0.8),
          textColor: Colors.white,
          isLoading: authProvider.isLoading,
        ),
        const SizedBox(height: 16),
        
        // Facebook Login
        _buildLoginButton(
          onPressed: authProvider.isLoading ? null : () => authProvider.loginWithFacebook(),
          icon: Icons.facebook,
          text: AppStrings.loginWithFacebook,
          backgroundColor: Colors.blue.withOpacity(0.8),
          textColor: Colors.white,
          isLoading: authProvider.isLoading,
        ),
      ],
    );
  }

  Widget _buildLoginButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SpinKitThreeBounce(
                color: Colors.white,
                size: 20,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'ميزات التطبيق:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.video_library,
                  text: AppStrings.shortVideos,
                ),
              ),
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.chat,
                  text: AppStrings.liveChat,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.explore,
                  text: AppStrings.exploreContent,
                ),
              ),
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.people,
                  text: AppStrings.followFriends,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}