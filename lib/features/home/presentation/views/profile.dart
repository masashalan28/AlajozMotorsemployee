import 'package:AlajozMotorsemployee/features/home/presentation/views/widgets/appBar_Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/manager/user_cubit.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../../core/services/storage_service.dart';
import 'widgets/body_Profile.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  bool isEditable = false;
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final token = await StorageService.getToken();
    if (token != null) {
      context.read<UserCubit>().getProfile(token: token);
    }
  }

  Future<void> _refreshProfile() async {
    await _loadUserProfile();
  }

  void toggleEdit() {
    if (isEditable) {
     
      _saveChanges();
    } else {
      
      setState(() {
        isEditable = true;
      });
    }
  }

  void _saveChanges() {
 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ التعديلات بنجاح!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    setState(() {
      isEditable = false;
    });
  }

  void _cancelEdit() {
    setState(() {
      isEditable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppbarProfile(onRefresh: _refreshProfile),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        color: const Color(0xFFFFC107),
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              setState(() {
                userData = state.user;
              });
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('خطأ في تحميل البروفايل: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading && userData == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFFFC107)),
                  ),
                );
              }

              return EmployeeProfileBody(
                isEditable: isEditable,
                toggleEdit: toggleEdit,
                cancelEdit: _cancelEdit,
                userData: userData,
              );
            },
          ),
        ),
      ),
    );
  }
}
