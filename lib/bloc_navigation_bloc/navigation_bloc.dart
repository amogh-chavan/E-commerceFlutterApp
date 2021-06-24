import 'package:bloc/bloc.dart';
import 'package:zerowaste/views/Home.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/contact.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/myaccount.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/mycart.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/myorders.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/settings.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebarComponents/wishlist.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  MyCartClickedEvent,
  MyWishListClickedEvent,
  SettingsClickedEvent,
  ContactClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  //@override
  // NavigationStates get initialState => MyAccount();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Home();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccount();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrders();
        break;
      case NavigationEvents.MyCartClickedEvent:
        yield MyCart();
        break;
      case NavigationEvents.MyWishListClickedEvent:
        yield WishList();
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield Settings();
        break;
      case NavigationEvents.ContactClickedEvent:
        yield Contact();
        break;
    }
  }
}
