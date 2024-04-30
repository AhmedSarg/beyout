import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/usecase/share_post_usecase.dart';
import 'package:temp_house/presentation/base/base_states.dart';

import '../../base/base_cubit.dart';

class ShareViewModel extends BaseCubit
    implements SearchTenantViewModelInput, SearchTenantViewModelOutput {
  static ShareViewModel get(context) => BlocProvider.of(context);

  final SharePostUseCase _sharePostUseCase;

  ShareViewModel(this._sharePostUseCase);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _bedController = TextEditingController();
  final TextEditingController _wifiController = TextEditingController();
  final TextEditingController _bathroomController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final List<File> _images = [];
  late LatLng _coordinates;

  @override
  void start() {}

  @override
  TextEditingController get getCategoryController => _categoryController;

  @override
  TextEditingController get getConditionController => _conditionController;

  @override
  TextEditingController get getDescriptionController => _descriptionController;

  @override
  TextEditingController get getLocationController => _locationController;

  @override
  TextEditingController get getPriceController => _priceController;

  @override
  TextEditingController get getTitleController => _titleController;

  @override
  TextEditingController get getBedController => _bedController;

  @override
  TextEditingController get getWifiController => _wifiController;

  @override
  TextEditingController get getBathRoomController => _bathroomController;

  @override
  TextEditingController get getAreaController => _areaController;



  @override
  List<File> get getImages => _images;

  @override
  LatLng get getCoordinates => _coordinates;

  @override
  set setCoordinates(LatLng coordinates) {
    _coordinates = coordinates;
  }

  @override
  set addImage(File image) {
    if (_images.length <= 10) {
      _images.add(image);
    }
    emit(ContentState());
  }

  Future<void> sharePost() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _sharePostUseCase(
      SharePostUseCaseInput(
        title: _titleController.text.trim(),
        price: num.parse(_priceController.text.trim()),
        category: _categoryController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        numberOfBeds: int.parse(_bedController.text.trim()),
        numberOfBathrooms: int.parse(_bathroomController.text.trim()),
        wifi: _wifiController.text.trim() == 'Yes' ? true : false,
        condition: _conditionController.text.trim(),
        images: _images,
        coordinates: const LatLng(0, 0),
        area: num.parse(_areaController.text.trim()),
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            emit(SuccessState('Home Posted Successfully'));
          },
        );
      },
    );
  }
}

abstract class SearchTenantViewModelInput {
  set setCoordinates(LatLng coordinates);
  set addImage(File image);
}

abstract class SearchTenantViewModelOutput {
  TextEditingController get getTitleController;

  TextEditingController get getPriceController;

  TextEditingController get getCategoryController;

  TextEditingController get getConditionController;

  TextEditingController get getDescriptionController;

  TextEditingController get getLocationController;

  TextEditingController get getBedController;

  TextEditingController get getWifiController;

  TextEditingController get getBathRoomController;

  TextEditingController get getAreaController;


  List<File> get getImages;

  LatLng get getCoordinates;
}
