import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_states.dart';
import 'package:pizzer_mobile/models/order_model.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ProfileInfoState extends Equatable {}

class LoadedNoAllowedChangeProfileInfoState extends ProfileInfoState {
  final UserInfoModel userInfoModel;
  final String? token;
  final String? previousName;
  final String? previousPhone;
  LoadedNoAllowedChangeProfileInfoState(
      this.userInfoModel, this.token, this.previousName, this.previousPhone);

  @override
  List<Object?> get props => [token, previousName, previousPhone];
}

class LoadedAllowedChangeProfileInfoState extends ProfileInfoState {
  final UserInfoModel userInfoModel;
  final String? token;
  final String? previousName;
  final String? previousPhone;
  LoadedAllowedChangeProfileInfoState(
      this.userInfoModel, this.token, this.previousName, this.previousPhone);

  @override
  List<Object?> get props => [token, previousName, previousPhone];
}

class ProfileInfoLoadingState extends ProfileInfoState {
  ProfileInfoLoadingState();
  @override
  List<Object?> get props => [];
}

class ProfileInfoErrorState extends ProfileInfoState {
  final String? error;
  ProfileInfoErrorState(this.error);
  @override
  List<Object?> get props => [];
}
