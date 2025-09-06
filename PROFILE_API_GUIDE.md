# دليل استخدام API البروفايل

## نظرة عامة
تم ربط واجهة البروفايل الموجودة في التطبيق مع API للبروفايل لاسترجاع بيانات المستخدم الحقيقية.

## الملفات المحدثة

### 1. API Layer
- `lib/constants.dart` - إضافة endpoint للبروفايل
- `lib/features/auth/data/repos/user_repo.dart` - إضافة دالة getProfile
- `lib/features/auth/data/repos/user_repo_impl.dart` - تنفيذ دالة getProfile
- `lib/features/auth/presentation/manager/user_cubit.dart` - إضافة دالة getProfile
- `lib/features/auth/presentation/manager/user_state.dart` - إضافة ProfileLoaded state

### 2. UI Layer
- `lib/features/home/presentation/views/profile.dart` - ربط الواجهة مع API
- `lib/features/home/presentation/views/widgets/body_Profile.dart` - عرض البيانات من API
- `lib/features/home/presentation/views/widgets/appBar_Profile.dart` - إضافة زر تحديث

### 3. Test Screen
- `lib/features/auth/presentation/views/profile_test_screen.dart` - صفحة اختبار API

## API Endpoint
```
GET /v1/user/profile
Headers: 
  Authorization: Bearer {token}
  Accept: application/json
```

## الاستجابة المتوقعة
```json
{
  "message": "ok",
  "data": {
    "id": 1,
    "first_name": "John",
    "last_name": "Doe", 
    "phone": "+1234567890",
    "email": "john.doe@example.com",
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  }
}
```

## الميزات المضافة

### 1. تحميل تلقائي للبروفايل
- يتم تحميل بيانات البروفايل تلقائياً عند فتح الصفحة
- استخدام token المحفوظ في StorageService

### 2. مؤشر التحميل
- عرض CircularProgressIndicator أثناء تحميل البيانات
- إخفاء المؤشر عند وجود بيانات محفوظة

### 3. تحديث البروفايل
- زر تحديث في AppBar
- إمكانية السحب للتحديث (Pull to Refresh)

### 4. معالجة الأخطاء
- عرض رسائل خطأ عند فشل تحميل البيانات
- استخدام SnackBar لعرض الرسائل

### 5. عرض البيانات
- الاسم الكامل
- معرف الموظف (ID)
- رقم الهاتف
- البريد الإلكتروني
- تاريخ الانضمام
- تاريخ آخر تحديث

## كيفية الاستخدام

### 1. اختبار API
1. افتح التطبيق
2. اضغط على زر "اختبار API البروفايل" في الصفحة الرئيسية
3. تأكد من وجود token محفوظ
4. اضغط على "اختبار API البروفايل"

### 2. عرض البروفايل
1. انتقل إلى صفحة البروفايل
2. ستظهر البيانات المحملة من API
3. يمكنك تحديث البيانات بالضغط على زر التحديث

## ملاحظات مهمة

1. **Token مطلوب**: يجب أن يكون المستخدم مسجل دخول للحصول على البيانات
2. **معالجة الأخطاء**: يتم عرض رسائل خطأ واضحة عند فشل الطلبات
3. **تحسين الأداء**: يتم تحميل البيانات مرة واحدة فقط عند فتح الصفحة
4. **التحديث**: يمكن تحديث البيانات يدوياً أو بالسحب

## استكشاف الأخطاء

### مشكلة: لا تظهر البيانات
- تأكد من وجود token صالح
- تحقق من اتصال الإنترنت
- راجع رسائل الخطأ في SnackBar

### مشكلة: خطأ في API
- تحقق من صحة endpoint
- تأكد من صحة headers
- راجع استجابة API في Postman

## التطوير المستقبلي

1. **تحديث البروفايل**: إضافة إمكانية تحديث بيانات البروفايل
2. **رفع الصورة**: إضافة إمكانية رفع صورة البروفايل
3. **التحقق من الصحة**: إضافة validation للبيانات
4. **التخزين المؤقت**: إضافة cache للبيانات
