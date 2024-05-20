import '../../../domain/models/domain.dart';
import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  static UserRole? _userRole;

  static void setUserRole(UserRole role) => _userRole = role;

  static UserRole? getUserRole() {
    return _userRole;
  }

  static late UserModel _user;

  static void pushUser(UserModel user) {
    _user = user;
  }

  static UserModel getUser() {
    return _user;
  }

//-----------------------------------
}
