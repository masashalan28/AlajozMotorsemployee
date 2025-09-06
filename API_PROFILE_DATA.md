# بيانات API البروفايل

## البيانات التي يرجعها API

### Endpoint
```
GET /v1/user/profile
```

### Headers المطلوبة
```
Authorization: Bearer {token}
Accept: application/json
```

### استجابة API المتوقعة
```json
{
  "message": "ok",
  "data": {
    "id": 1,
    "first_name": "أحمد",
    "last_name": "محمد",
    "phone": "+963987654321",
    "email": "ahmed.mohammed@example.com",
    "created_at": "2023-01-15T08:30:00Z",
    "updated_at": "2024-01-15T10:45:00Z"
  }
}
```

### شرح الحقول

| الحقل | النوع | الوصف | مثال |
|-------|------|--------|------|
| `id` | عدد | معرف المستخدم الفريد | `1` |
| `first_name` | نص | الاسم الأول | `"أحمد"` |
| `last_name` | نص | اسم العائلة | `"محمد"` |
| `phone` | نص | رقم الهاتف | `"+963987654321"` |
| `email` | نص | البريد الإلكتروني | `"ahmed@example.com"` |
| `created_at` | نص | تاريخ إنشاء الحساب | `"2023-01-15T08:30:00Z"` |
| `updated_at` | نص | تاريخ آخر تحديث | `"2024-01-15T10:45:00Z"` |

## كيفية عرض البيانات في التطبيق

### 1. الاسم الكامل
```dart
name: '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}'
```

### 2. معرف الموظف
```dart
id: userData['id'] ?? 0
```

### 3. رقم الهاتف
```dart
phone: userData['phone'] ?? ''
```

### 4. البريد الإلكتروني
```dart
email: userData['email'] ?? ''
```

### 5. تاريخ الانضمام
```dart
createdAt: userData['created_at'] != null
  ? DateTime.parse(userData['created_at'])
  : null
```

### 6. تاريخ آخر تحديث
```dart
updatedAt: userData['updated_at'] != null
  ? DateTime.parse(userData['updated_at'])
  : null
```

## حالات الخطأ المحتملة

### 1. عدم وجود token
```json
{
  "message": "Unauthorized",
  "error": "Token not provided"
}
```

### 2. token غير صالح
```json
{
  "message": "Unauthorized", 
  "error": "Invalid token"
}
```

### 3. المستخدم غير موجود
```json
{
  "message": "User not found",
  "error": "User does not exist"
}
```

## لماذا زر الاختبار مفيد؟

### 1. اختبار API
- التأكد من عمل API بشكل صحيح
- فحص البيانات المرجعة
- اختبار مختلف الحالات

### 2. تطوير وتصحيح الأخطاء
- عرض البيانات الخام
- تشخيص مشاكل الاتصال
- اختبار مختلف tokens

### 3. عرض معلومات API
- URL المستخدم
- Headers المطلوبة
- طريقة الاستخدام

## الميزات الجديدة في واجهة البروفايل

### 1. أيقونة التعديل المحسنة
- **أزرق**: وضع العرض العادي
- **أخضر**: وضع التعديل
- **أحمر**: زر الإلغاء

### 2. تأثيرات بصرية
- انتقالات سلسة (300ms)
- ظلال ملونة
- تأثيرات اللمس

### 3. رسائل تأكيد
- رسالة نجاح عند الحفظ
- رسائل خطأ واضحة
- تلميحات للأزرار

### 4. تحسينات UX
- أزرار منفصلة للحفظ والإلغاء
- ألوان مميزة لكل حالة
- تلميحات توضيحية
