import 'package:finance_manager/features/state/MyAppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget{
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Center(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Favourites:", style: style,),
          ),
          for(var fav in appState.favorites)
            Card(
                child: ListTile(
                  title: Text(
                      fav.asPascalCase
                  ),
                  onTap: (){
                    appState.deleteFavourite(fav);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                )
            ),
        ],
      ),
    );
  }
}