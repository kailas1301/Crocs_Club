part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {}

final class NavbarInitial extends NavbarState {}

final class HomeSelected extends NavbarState {}

final class ProductScreenSelected extends NavbarState {}

final class CartScreenSelected extends NavbarState {}

final class ProfileScreenSelected extends NavbarState {}
