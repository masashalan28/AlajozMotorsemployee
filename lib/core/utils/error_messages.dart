class ErrorMessages {
  static String getUserFriendly(String errorMessage) {
    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return 'رقم الهاتف غير مسجل في النظام';
    } else if (errorMessage.contains('500') || errorMessage.contains('Server Error')) {
      return 'خطأ في الخادم، حاول مرة أخرى';
    } else if (errorMessage.contains('timeout') || errorMessage.contains('Timeout')) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت';
    } else if (errorMessage.contains('SocketException') || errorMessage.contains('Network')) {
      return 'لا يوجد اتصال بالإنترنت';
    } else {
      return 'حدث خطأ، حاول مرة أخرى';
    }
  }


 static String getUserFriendlyErrorMessage(String errorMessage) {
    if (errorMessage.contains('401') || errorMessage.contains('Unauthorized')) {
      return 'رمز التحقق غير صحيح';
    } else if (errorMessage.contains('404') ||
        errorMessage.contains('Not Found')) {
      return 'الرمز منتهي الصلاحية، اطلب رمز جديد';
    } else if (errorMessage.contains('500') ||
        errorMessage.contains('Server Error')) {
      return 'خطأ في الخادم، حاول مرة أخرى';
    } else if (errorMessage.contains('timeout') ||
        errorMessage.contains('Timeout')) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت';
    } else if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Network')) {
      return 'لا يوجد اتصال بالإنترنت';
    } else if (errorMessage.contains('Invalid OTP') ||
        errorMessage.contains('Wrong OTP')) {
      return 'رمز التحقق غير صحيح';
    } else {
      return 'حدث خطأ، حاول مرة أخرى';
    }
  }
}
 