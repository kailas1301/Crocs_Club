import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial()) {
    on<HomePressed>((event, emit) => emit(HomeSelected()));
    on<ProductPressed>((event, emit) => emit(ProductScreenSelected()));
    on<CartPressed>((event, emit) => emit(CartScreenSelected()));
    on<ProfilePressed>((event, emit) => emit(ProfileScreenSelected()));
  }
}
