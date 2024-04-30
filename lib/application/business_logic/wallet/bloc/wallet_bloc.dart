import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/wallet/wallet_services.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<FetchWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        final walletAmount = await WalletServices.getWallet();
        print("wallet amoungt from get wallet is $walletAmount");
        emit(WalletLoaded(walletAmount: walletAmount));
        print("wallet amount in wallet loaded is $walletAmount");
      } catch (e) {
        print("wallet amount in wallet error is $e");
        emit(WalletError(error: "Wallet is empty please try again"));
      }
    });
  }
}
