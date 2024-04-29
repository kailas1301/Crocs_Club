part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

final class FetchWallet extends WalletEvent {}
