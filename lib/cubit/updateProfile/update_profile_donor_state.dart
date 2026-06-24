

import 'package:flutter/foundation.dart';

@immutable
sealed class UpdateProfileDonorState {}

final class UpdateProfileDonorLoading extends UpdateProfileDonorState {}
final class UpdateProfileDonorSuccess extends UpdateProfileDonorState {}
final class UpdateProfileDonorFail extends UpdateProfileDonorState {}