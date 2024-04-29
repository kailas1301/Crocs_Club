import 'package:crocs_club/application/business_logic/wallet/bloc/wallet_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletBloc>(context).add(FetchWallet());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTextWidget(title: 'My Wallet'),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WalletLoaded) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SubHeadingTextWidget(
                                title: 'Current Balance',
                                textColor: kDarkGreyColour,
                                textsize: 18,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '₹${state.walletAmount.floor()}', // Dynamic wallet amount
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: kGreenColour,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
              } else {
                return const Center(
                  child: SubHeadingTextWidget(
                    title: "Wallet is empty",
                    textColor: kDarkGreyColour,
                    textsize: 17,
                  ),
                );
              }
            },
          ),
        )));
  }
}
