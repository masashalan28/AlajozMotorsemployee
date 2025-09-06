import 'package:dio/dio.dart';
import '../utils/api_service.dart';
import '../../features/auth/data/repos/user_repo.dart';
import '../../features/auth/data/repos/user_repo_impl.dart';

class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  late final Dio _dio;
  late final ApiService _apiService;
  late final UserRepo _userRepo;

  void init() {
    _dio = Dio();
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (obj) => print(obj),
    ));
    _apiService = ApiService(_dio);
    _userRepo = UserRepoImpl(_apiService, _dio);
  }

  Dio get dio => _dio;
  ApiService get apiService => _apiService;
  UserRepo get userRepo => _userRepo;
}

final di = DependencyInjection();
