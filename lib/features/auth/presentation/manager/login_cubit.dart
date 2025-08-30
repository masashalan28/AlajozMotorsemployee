import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';



class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthInitial());

 Future <void> login(String phone, String password) async {
    emit(AuthLoading());
try{

  await Future.delayed(const Duration(seconds: 2));
  
    if (phone == '123456789' && password == '123456') {
      emit(AuthSucess());
    } else {
      emit(AuthFailure(message: 'رقم الهاتف أو كلمة المرور غير صحيحة'));
    }
  }
  catch(e){
    emit(AuthFailure(message: 'error'));
  }
}   
}
