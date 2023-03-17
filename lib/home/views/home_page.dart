import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokex/app_routes.dart';
import 'package:pokex/home/cubit/home_cubit.dart';
import 'package:pokex/home/cubit/home_state.dart';
import 'package:pokex/widgets/menu_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> _favourites = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).getPokex();

    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.currentUser?.email ?? ""),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (menuItem) async {
              if (menuItem == 1) {
                Navigator.pushNamed(context, AppRoutes.favouritesPage);
              } else if (menuItem == 2) {
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginPage, (route) => false);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 1,
                child: MenuItemWidget(iconData: Icons.favorite, title: "Favourites"),
              ),
              PopupMenuItem(
                value: 2,
                // row has two child icon and text.
                child: MenuItemWidget(iconData: Icons.logout, title: "Logout"),
              ),
            ],
            offset: const Offset(0, 50),
          ),
        ],
      ),
      body: RefreshIndicator(onRefresh: () async {
        BlocProvider.of<HomeCubit>(context).getPokex();
      }, child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is LoadingHomeState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ResponseHomeState) {
          var items = state.pokemonModel.results;
          return ListView.builder(
            itemCount: items!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                print("Adding in SP");

                _favourites.add(items[index].name ?? "");

                await _saveFavorites(_favourites, items[index].name);
                print("Added");
              },
              child: ListTile(
                title: Text(items[index].name ?? ""),
                subtitle: Text(items[index].url ?? ""),
              ),
            ),
          );
        } else if (state is ErrorHomeState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      })),
    );
  }

  Future<void> _saveFavorites(List<String> favorites, String? name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
    Fluttertoast.showToast(msg: "${name ?? ""} added to favorites");
  }
}
