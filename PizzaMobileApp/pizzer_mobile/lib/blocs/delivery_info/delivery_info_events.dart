import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DeliveryInfoEvent extends Equatable {
  const DeliveryInfoEvent();
}

class EmptyInfoEvent extends DeliveryInfoEvent {
  EmptyInfoEvent();
  @override
  List get props => [];
}

class AddressChangedEvent extends DeliveryInfoEvent {
  final String? addressValue;

  AddressChangedEvent(this.addressValue);
  @override
  List get props => [addressValue];
}

class FlatChangedEvent extends DeliveryInfoEvent {
  final String? flatValue;

  FlatChangedEvent(this.flatValue);
  @override
  List get props => [flatValue];
}

class EntranceChangedEvent extends DeliveryInfoEvent {
  final String? entranceValue;

  EntranceChangedEvent(this.entranceValue);
  @override
  List get props => [entranceValue];
}

class FloorChangedEvent extends DeliveryInfoEvent {
  final String? floorValue;

  FloorChangedEvent(this.floorValue);
  @override
  List get props => [floorValue];
}

class PhoneChangedEvent extends DeliveryInfoEvent {
  final String? phoneValue;

  PhoneChangedEvent(this.phoneValue);
  @override
  List get props => [phoneValue];
}

class CommentChangedEvent extends DeliveryInfoEvent {
  final String? commentValue;

  CommentChangedEvent(this.commentValue);
  @override
  List get props => [commentValue];
}
