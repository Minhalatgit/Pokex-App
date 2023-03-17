import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    _getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: _getFavourites(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.requireData.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    await _removeFavorite(snapshot.requireData[index]);
                    setState(() {});
                  },
                  child: ListTile(
                    title: Text(snapshot.requireData[index]),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<List<String>> _getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  Future<void> _removeFavorite(String item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(item);

    Fluttertoast.showToast(msg: "$item removed from favorites");

    await prefs.setStringList('favorites', favorites);
  }
}
