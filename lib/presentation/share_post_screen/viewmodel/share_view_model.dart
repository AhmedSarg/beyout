import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_cubit.dart';

class ShareViewModel extends BaseCubit
    implements SearchTenantViewModelInput, SearchTenantViewModelOutput {

  static ShareViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _martialStatusController =
  TextEditingController();

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
  TextEditingController get getPriceController =>  _priceController;

  @override
  TextEditingController get getTitleController =>  _titleController;


}

abstract class SearchTenantViewModelInput {}

abstract class  SearchTenantViewModelOutput {
  TextEditingController get getTitleController;

  TextEditingController get getPriceController;

  TextEditingController get getCategoryController;

  TextEditingController get getConditionController;

  TextEditingController get getDescriptionController;

  TextEditingController get getLocationController;


}
