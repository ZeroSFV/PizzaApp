import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ApproveUserEvent extends Equatable {
  const ApproveUserEvent();
}

class LoadApproveUserEvent extends ApproveUserEvent {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;
  LoadApproveUserEvent(this.token, this.approvalCode, this.checkApprovalCode);
  @override
  List get props => [token, approvalCode, checkApprovalCode];
}

class CheckApprovalCodeChangedEvent extends ApproveUserEvent {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;
  CheckApprovalCodeChangedEvent(
      this.token, this.approvalCode, this.checkApprovalCode);
  @override
  List get props => [token, approvalCode, checkApprovalCode];
}

class ApproveUserSubmittedEvent extends ApproveUserEvent {
  final String? token;
  final String? approvalCode;
  final String? checkApprovalCode;
  ApproveUserSubmittedEvent(
      this.token, this.approvalCode, this.checkApprovalCode);
  @override
  List get props => [token, approvalCode, checkApprovalCode];
}
