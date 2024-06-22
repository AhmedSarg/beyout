import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/domain.dart';
import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  static UserRole? _userRole;

  static void setUserRole(UserRole role) => _userRole = role;

  static UserRole? getUserRole() {
    return _userRole;
  }

  static UserModel? _user;

  static void pushUser(UserModel user) {
    _user = user;
  }

  static UserModel getUser() {
    return _user!;
  }

  static LatLng? _initialLocation;

  static void pushInitialLocation(LatLng initialLocation) {
    _initialLocation = initialLocation;
  }

  static LatLng? popInitialLocation() {
    LatLng? v = _initialLocation;
    _initialLocation = null;
    return v;
  }

  static HomeModel? _homeModel;

  static void pushHome(HomeModel homeModel) {
    _homeModel = homeModel;
  }

  static HomeModel popHome() {
    HomeModel v = _homeModel!;
    _homeModel = null;
    return v;
  }

  static User? _fireAuthUser;

  static void pushFireAuthUser(User? fireAuthUser) {
    _fireAuthUser = fireAuthUser;
  }

  static User? getFireAuthUser() {
    return _fireAuthUser;
  }

  static void deleteFireAuthUser() {
    _fireAuthUser = null;
  }

//-----------------------------------
}
