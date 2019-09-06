import 'package:pokedexgo/pokedex.dart';
import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Text(
                pokemon.name,
                style:
                TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text(
                "Types",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type
                    .map((t) => FilterChip(
                    backgroundColor: Colors.amber,
                    label: Text(t),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses
                    .map((t) => FilterChip(
                    backgroundColor: Colors.red,
                    label: Text(
                      t,
                      style: TextStyle(color: Colors.white),
                    ),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              rowWidget(pokemon.nextEvolution, Colors.orange),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
            )),
      )
    ],
  );

  Widget rowWidget(List<dynamic> method, Color color) {
    if (method != null) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: method
              .map((x) => FilterChip(
            backgroundColor: color,
            label: (method == pokemon.nextEvolution)
                ? Text(x.name)
                : Text(x),
            onSelected: (b) {},
          ))
              .toList());
    }
    return FilterChip(
      backgroundColor: Colors.orange,
      label: Text(
        'This is the most evolved form of this Pokemon',
        style: TextStyle(fontSize: 12.0, color: Colors.white),
      ),
      onSelected: (s) {},
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(pokemon.name, style: TextStyle(color: Colors.black),),
      ),
      body: bodyWidget(context),
    );
  }
}