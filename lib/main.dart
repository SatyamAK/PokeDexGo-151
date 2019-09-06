import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedexgo/pokedex.dart';
import 'package:pokedexgo/PokeDetail.dart';

void main() => runApp(MaterialApp(
  title:"PokeDexGo",
  home: MainPage()
));

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var url= "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeDex pkdex;
  @override
  void initState(){
    super.initState();
    fecthdata();
  }
  fecthdata() async{
    var request = await http.get(url);
    var decode = jsonDecode(request.body);
    pkdex= PokeDex.fromJson(decode);
    print(pkdex.toJson());
    setState(() {});
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("PokeDex GO"),
        backgroundColor: Colors.red,
      ),
      body:pkdex == null?Center(child: Text("Loading")):GridView.count(
        crossAxisCount: 2,
        children: pkdex.pokemon.map((poke)=>Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PokeDetail(
                        pokemon: poke,
                      )));
            },
            child:Hero(
              tag: poke.img,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width:  100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(poke.img))),
                    ),
                    Text(
                      poke.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ],
                )
              )
            )
          )
        )).toList()
      )
    );
  }
}