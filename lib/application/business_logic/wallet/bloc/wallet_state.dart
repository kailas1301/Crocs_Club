part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletLoaded extends WalletState {
  final int walletAmount;
  WalletLoaded({required this.walletAmount});
}

final class WalletError extends WalletState {
  final String error;
  WalletError({required this.error});
}
