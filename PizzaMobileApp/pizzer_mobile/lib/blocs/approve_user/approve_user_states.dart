import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ApproveUserState extends Equatable {}

class LoadedNoAllowedApproveUserState extends ApproveUserState {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;

  LoadedNoAllowedApproveUserState(
      this.token, this.approvalCode, this.checkApprovalCode);

  @override
  List<Object?> get props => [token, approvalCode, checkApprovalCode];
}

class LoadedAllowedApproveUserState extends ApproveUserState {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;
  LoadedAllowedApproveUserState(
      this.token, this.approvalCode, this.checkApprovalCode);

  @override
  List<Object?> get props => [token, approvalCode, checkApprovalCode];
}

class IncorrectApprovalCodeState extends ApproveUserState {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;
  IncorrectApprovalCodeState(
      this.token, this.approvalCode, this.checkApprovalCode);

  @override
  List<Object?> get props => [token, approvalCode, checkApprovalCode];
}

class ApprovalUserSuccessState extends ApproveUserState {
  final String? token;
  ApprovalUserSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class LoadingApprovalUserState extends ApproveUserState {
  LoadingApprovalUserState();

  @override
  List<Object?> get props => [];
}

class ApprovalUserErrorState extends ApproveUserState {
  final String? error;
  ApprovalUserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
