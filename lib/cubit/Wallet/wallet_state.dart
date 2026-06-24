part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletLoading extends WalletState {}
final class WalletSucsess extends WalletState {
  final String balance;
  WalletSucsess(this.balance);
}
final class WalletFailure extends WalletState {}
