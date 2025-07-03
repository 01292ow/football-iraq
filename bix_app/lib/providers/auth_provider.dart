import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isGuest => _user?.isGuest ?? false;

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('bix_user');
      if (userJson != null) {
        final userData = json.decode(userJson);
        _user = UserModel.fromJson(userData);
      }
    } catch (e) {
      _setError('خطأ في تحميل بيانات المستخدم');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _saveUserToStorage(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString('bix_user', userJson);
    } catch (e) {
      _setError('خطأ في حفظ بيانات المستخدم');
    }
  }

  Future<void> loginAsGuest() async {
    _setLoading(true);
    _clearError();
    
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
      final guestUser = UserModel.createGuest();
      _user = guestUser;
      await _saveUserToStorage(guestUser);
      
      notifyListeners();
    } catch (e) {
      _setError('فشل في تسجيل الدخول كضيف');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loginWithGoogle() async {
    _setLoading(true);
    _clearError();
    
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      // Simulate Google authentication
      final googleUser = UserModel.createGoogleUser(
        'مستخدم جوجل',
        'user@gmail.com',
      );
      
      _user = googleUser;
      await _saveUserToStorage(googleUser);
      
      notifyListeners();
    } catch (e) {
      _setError('فشل في تسجيل الدخول بجوجل');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loginWithFacebook() async {
    _setLoading(true);
    _clearError();
    
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      // Simulate Facebook authentication
      final facebookUser = UserModel.createFacebookUser(
        'مستخدم فيسبوك',
        'user@facebook.com',
      );
      
      _user = facebookUser;
      await _saveUserToStorage(facebookUser);
      
      notifyListeners();
    } catch (e) {
      _setError('فشل في تسجيل الدخول بفيسبوك');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    _clearError();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('bix_user');
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('فشل في تسجيل الخروج');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      _user = updatedUser;
      await _saveUserToStorage(updatedUser);
      notifyListeners();
    } catch (e) {
      _setError('فشل في تحديث بيانات المستخدم');
    }
  }

  Future<void> updateProfile({
    String? name,
    String? bio,
    String? avatar,
  }) async {
    if (_user == null) return;
    
    _setLoading(true);
    _clearError();
    
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
      final updatedUser = _user!.copyWith(
        name: name ?? _user!.name,
        bio: bio ?? _user!.bio,
        avatar: avatar ?? _user!.avatar,
      );
      
      await updateUser(updatedUser);
    } catch (e) {
      _setError('فشل في تحديث الملف الشخصي');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> followUser(String userId) async {
    if (_user == null) return;
    
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      final updatedUser = _user!.copyWith(
        following: _user!.following + 1,
      );
      
      await updateUser(updatedUser);
    } catch (e) {
      _setError('فشل في متابعة المستخدم');
    }
  }

  Future<void> unfollowUser(String userId) async {
    if (_user == null) return;
    
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      final updatedUser = _user!.copyWith(
        following: _user!.following > 0 ? _user!.following - 1 : 0,
      );
      
      await updateUser(updatedUser);
    } catch (e) {
      _setError('فشل في إلغاء متابعة المستخدم');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }
}