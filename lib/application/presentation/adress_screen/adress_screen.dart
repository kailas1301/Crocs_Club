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
        title: const SubHeadingTextWidget(
          textColor: kDarkGreyColour,
          textsize: 18,
          title: 'Addresses',
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AdressblocBloc, AdressblocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdressblocLoaded) {
            return ListView.builder(
              itemCount: state.addressModel.length,
              itemBuilder: (context, index) {
                final address = state.addressModel[index];
                return Card(
                  color: kwhiteColour,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: kPrimaryDarkColor,
                        radius: 30,
                        child: Icon(
                          Icons.location_on,
                          size: 25,
                          color: kwhiteColour,
                        ),
                      ),
                      title: SubHeadingTextWidget(
                          textsize: 16,
                          textColor: kblackColour,
                          title: 'Address ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingTextWidget(
                              textsize: 14,
                              textColor: kDarkGreyColour,
                              title: 'Name: ${address.name}'),
                          SubHeadingTextWidget(
                              textsize: 14,
                              textColor: kDarkGreyColour,
                              title:
                                  '${address.houseName} House, ${address.street}'),
                          SubHeadingTextWidget(
                              textsize: 14,
                              textColor: kDarkGreyColour,
                              title:
                                  '${address.city}, ${address.state} - ${address.pin}'),
                          SubHeadingTextWidget(
                              textsize: 14,
                              textColor: kDarkGreyColour,
                              title: 'Phone: ${address.phone}'),
                        ],
                      ),
                    ),
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
            builder: (context) => const AddAddressScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
