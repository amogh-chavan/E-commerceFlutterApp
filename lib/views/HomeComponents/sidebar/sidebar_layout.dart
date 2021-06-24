import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zerowaste/views/Home.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar.dart';

import 'package:zerowaste/bloc_navigation_bloc/navigation_bloc.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({this.onSignedOut});

  final VoidCallback onSignedOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(Home()),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
