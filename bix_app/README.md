# Bix - تطبيق التواصل الاجتماعي

<div align="center">
  <h1>🎬 Bix</h1>
  <p><strong>تطبيق التواصل الاجتماعي مع الفيديوهات القصيرة والدردشة</strong></p>
  
  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
</div>

## 📱 نظرة عامة

Bix هو تطبيق تواصل اجتماعي حديث مصمم خصيصاً للمحتوى العربي، يجمع بين مشاركة الفيديوهات القصيرة والدردشة المباشرة في تجربة مستخدم سلسة وجذابة.

## ✨ الميزات الرئيسية

### 🏠 الصفحة الرئيسية
- عرض فيديوهات قصيرة (≤60 ثانية)
- تمرير عمودي بين المقاطع
- أزرار تفاعل: إعجاب ❤️، تعليق 💬، مشاركة 🔁
- تشغيل تلقائي مع إمكانية التحكم
- عرض عدد المشاهدات والإعجابات
- عرض وصف الفيديو واسم المستخدم

### 🔍 الاستكشاف
- البحث عن المستخدمين والفيديوهات والوسوم
- عرض المحتوى الرائج
- تصفح حسب الفئات والوسوم
- اكتشاف مستخدمين جدد

### 📹 رفع الفيديوهات
- تسجيل فيديو مباشر من الكاميرا
- اختيار فيديو من المعرض
- إضافة وصف ووسوم
- معاينة قبل النشر
- فلاتر وتأثيرات

### 💬 الدردشة
- رسائل مباشرة (شخص لشخص)
- دردشة جماعية
- دعم النصوص والصور والفيديوهات
- إشعارات الكتابة وقراءة الرسائل
- حالة الاتصال (متصل/غير متصل)

### 👤 الملف الشخصي
- صورة الغلاف والصورة الشخصية
- عرض عدد المتابعين والمتابَعين
- تعديل الملف الشخصي
- عرض جميع فيديوهات المستخدم
- إعدادات الخصوصية

## 🚀 التشغيل والتطوير

### متطلبات النظام
- Flutter SDK 3.16.9 أو أحدث
- Dart SDK 3.2.6 أو أحدث
- Android Studio أو VS Code
- Git

### خطوات التشغيل

1. **استنساخ المشروع**
```bash
git clone <repository-url>
cd bix_app
```

2. **تثبيت التبعيات**
```bash
flutter pub get
```

3. **تشغيل التطبيق**
```bash
# للويب
flutter run -d web-server --web-port=12000 --web-hostname=0.0.0.0

# للأندرويد
flutter run -d android

# لـ iOS
flutter run -d ios
```

## 🎨 التصميم والواجهة

### الألوان الرئيسية
- **الأساسي**: `#FF6B6B` (أحمر وردي)
- **الثانوي**: `#4ECDC4` (أزرق مخضر)
- **المميز**: `#45B7D1` (أزرق فاتح)
- **الخلفية**: `#000000` (أسود)
- **السطح**: `#1A1A1A` (رمادي داكن)

### الأيقونات المخصصة
- أيقونات مصممة خصيصاً لكل قسم
- تصميم متسق مع هوية التطبيق
- دعم الألوان المتغيرة حسب الحالة

## 🔐 المصادقة

### خيارات تسجيل الدخول
1. **دخول كضيف**: تجربة سريعة بدون تسجيل
2. **تسجيل الدخول بجوجل**: مصادقة آمنة عبر Google
3. **تسجيل الدخول بفيسبوك**: مصادقة عبر Facebook

## 📁 هيكل المشروع

```
lib/
├── constants/          # الثوابت والألوان
│   ├── app_colors.dart
│   └── app_strings.dart
├── models/            # نماذج البيانات
│   ├── user_model.dart
│   └── video_model.dart
├── providers/         # مزودي الحالة
│   └── auth_provider.dart
├── screens/           # شاشات التطبيق
│   ├── login_screen.dart
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── explore_screen.dart
│   ├── upload_screen.dart
│   ├── chat_screen.dart
│   └── profile_screen.dart
├── widgets/           # المكونات المشتركة
│   ├── custom_icons.dart
│   ├── bottom_navigation.dart
│   └── video_player_widget.dart
└── main.dart          # نقطة البداية
```

## 🛠️ التقنيات المستخدمة

### Frontend
- **Flutter**: إطار العمل الرئيسي
- **Dart**: لغة البرمجة
- **Provider**: إدارة الحالة
- **Go Router**: التنقل بين الصفحات

### UI/UX
- **Material Design**: تصميم متسق
- **Custom Icons**: أيقونات مخصصة
- **Animations**: تأثيرات حركية سلسة
- **Responsive Design**: تصميم متجاوب

### الوسائط
- **Video Player**: تشغيل الفيديوهات
- **Camera**: تسجيل الفيديوهات
- **Image Picker**: اختيار الصور والفيديوهات
- **Cached Network Image**: تحميل وتخزين الصور

---

<div align="center">
  <p>صُنع بـ ❤️ للمجتمع العربي</p>
  <p><strong>Bix - شارك لحظاتك</strong></p>
</div>
