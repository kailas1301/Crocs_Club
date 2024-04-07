import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/presentation/adress_screen/widgets.dart/add_adress.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import your address model

class AdressScreen extends StatelessWidget {
  const AdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdressblocBloc>(context).add(GetAddressEvent());
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTextWidget(title: 'Addresses'),
      ),
      body: BlocConsumer<AdressblocBloc, AdressblocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdressblocLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => kSizedBoxH10,
              itemCount: state.addressModel.length,
              itemBuilder: (context, index) {
                final address = state.addressModel[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kwhiteColour,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 76, 75, 75)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingTextWidget(
                              title: 'Name: ${address.name.toUpperCase()}'),
                          SubHeadingTextWidget(
                              title: 'House Name: ${address.houseName}'),
                          SubHeadingTextWidget(title: 'City: ${address.city}'),
                          SubHeadingTextWidget(
                              title: 'Street: ${address.street}'),
                          SubHeadingTextWidget(
                              title: 'State: ${address.state}'),
                          SubHeadingTextWidget(
                              title: 'Pin-code: ${address.pin}'),
                          SubHeadingTextWidget(
                              title: 'Phone-No: ${address.phone}')
                        ],
                      ),
                    ),

                    // You can display other address details here
                  ),
                );
              },
            );
          } else if (state is AdressblocError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddAddressScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
