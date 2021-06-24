import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/endOfOrder.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key key}) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  User user = FirebaseAuth.instance.currentUser;

  final auth = FirebaseAuth.instance;
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSideBarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.green[400],
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                          title: Text(
                            user.displayName,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        Divider(
                          height: 40,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 16,
                          endIndent: 16,
                        ),
                        MenuItem(
                          icon: Icons.home_rounded,
                          title: "Home",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.account_circle,
                          title: "Account",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyAccountClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.shopping_basket_outlined,
                          title: "My Orders",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyOrdersClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.shopping_cart_outlined,
                          title: "My Cart",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyCartClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.favorite,
                          title: "Wishlist",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyWishListClickedEvent);
                          },
                        ),
                        Divider(
                          height: 40,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 16,
                          endIndent: 16,
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          title: "Settings",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.SettingsClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.call_end_outlined,
                          title: "Contact GreenTeam",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.ContactClickedEvent);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            auth.signOut();
                            Navigator.of(context)
                                .pushReplacementNamed('/Welcome');
                          },
                          child: MenuItem(
                            icon: Icons.logout,
                            title: "Logout",
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "version 1.0",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.94),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMeanuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.green[400],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMeanuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    //throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
