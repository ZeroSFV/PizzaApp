import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizzer_mobile/models/user_info_model.dart';

@immutable
abstract class ProfileInfoEvent extends Equatable {
  const ProfileInfoEvent();
}

class LoadProfileInfoEvent extends ProfileInfoEvent {
  final String? token;

  LoadProfileInfoEvent(this.token);
  @override
  List get props => [token];
}

class ProfileNameChangedEvent extends ProfileInfoEvent {
  final String? token;
  final String? newName;
  final String? previousName;
  final String? previousPhone;
  final UserInfoModel user;

  ProfileNameChangedEvent(this.token, this.newName, this.previousName,
      this.previousPhone, this.user);
  @override
  List get props => [token, previousName, previousPhone, user];
}

class ProfileInfoChangedEvent extends ProfileInfoEvent {
  final String? token;

  ProfileInfoChangedEvent(this.token);
  @override
  List get props => [token];
}

class ProfilePhoneChangedEvent extends ProfileInfoEvent {
  final String? token;
  final String? newPhone;
  final String? previousName;
  final String? previousPhone;
  final UserInfoModel user;

  ProfilePhoneChangedEvent(this.token, this.newPhone, this.previousName,
      this.previousPhone, this.user);
  @override
  List get props => [token, previousName, previousPhone, user];
}
