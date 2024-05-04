import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/application/presentation/user_home_screen/widgets/carousel.dart';
import 'package:crocs_club/application/presentation/user_home_screen/widgets/drawer_screen.dart';
import 'package:crocs_club/application/presentation/user_home_screen/widgets/home_app_bar.dart';
import 'package:crocs_club/application/presentation/user_home_screen/widgets/productList.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetched());
    context.read<WishlistBloc>().add(FetchWishlistEvent());
    final currentTime = DateTime.now();
    String greeting = getGreeting(currentTime.hour);

    return Scaffold(
      backgroundColor: kwhiteColour,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HomeScreenAppBar(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Greeting text with username
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return SubHeadingTextWidget(
                        textColor: kblackColour,
                        title: '$greeting ${state.profileData['name']}');
                  } else {
                    return SubHeadingTextWidget(
                      title: greeting,
                    );
                  }
                },
              ),
            ),
            kSizedBoxH30,
            // widget for carousel slider
            buildCarouselSlider(),
            kSizedBoxH20,
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: SubHeadingTextWidget(
                title: 'Latest Products',
                textsize: 17,
                textColor: kblackColour,
              ),
            ),
            // horizontal listview of latest products
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return buildProductList(state.products);
                  } else if (state is ProductError) {
                    return const Center(child: Text('Failed to load products'));
                  } else {
                    return const LoadingAnimationStaggeredDotsWave();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // drawer
      drawer: const DrawerScreen(),
    );
  }
}
