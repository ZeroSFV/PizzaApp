import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DeliveryInfoState extends Equatable {}

class LoadingInfoState extends DeliveryInfoState {
  LoadingInfoState();

  @override
  List<Object?> get props => [];
}

class EmptyInfoState extends DeliveryInfoState {
  EmptyInfoState();

  @override
  List<Object?> get props => [];
}

class FilledAllState extends DeliveryInfoState {
  String? address;
  String? flat;
  String? entrance;
  String? floor;
  String? phone;
  String? comment;
  FilledAllState(this.address, this.flat, this.entrance, this.floor, this.phone,
      this.comment);

  @override
  List<Object?> get props => [address, flat, entrance, floor, phone, comment];
}

class FilledInfoState extends DeliveryInfoState {
  String? address;
  String? flat;
  String? entrance;
  String? floor;
  String? phone;
  String? comment;
  FilledInfoState(this.address, this.flat, this.entrance, this.floor,
      this.phone, this.comment);

  @override
  List<Object?> get props => [address, flat, entrance, floor, phone, comment];
}
