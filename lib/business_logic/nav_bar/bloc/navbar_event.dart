part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class HomePressed extends NavbarEvent {}

class ProductPressed extends NavbarEvent {}

class CartPressed extends NavbarEvent {}

class ProfilePressed extends NavbarEvent {}
