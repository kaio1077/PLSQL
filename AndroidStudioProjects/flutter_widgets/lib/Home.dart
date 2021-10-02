import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _lista = ["Jamilton", "Maria", "João", "Carla"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widgets"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (context, index){
                final item = _lista[index];
                return Dismissible(
                  key: Key(item),
                  child: ListTile(
                    title: Text(item),
                  ),
                  // direction: DismissDirection.horizontal,
                  onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                      print ("direcao: endToStart");
                    }
                    else if (direction == DismissDirection.startToEnd){
                      print ("direcao: startToEnd");
                    }

                    setState(() {
                      _lista.removeAt(index);
                    });

                  },
                  background: Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                );
                }
            ),
          )
        ],
      ),
    );
  }
}
