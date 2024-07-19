import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

final TextEditingController _controller = TextEditingController();

class _ToDoListState extends State<ToDoList> {
  List dane = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 44, 69),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.white12,
        elevation: 8.0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 10, 21, 51),
        title: const Text(
          'ToDoList',
          style: TextStyle(
            color: Color.fromARGB(255, 4, 0, 255),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dane.length,
        itemBuilder: (context, index) {
          final item = dane[index][0];
          final checked = dane[index][1];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  setState(() {
                    dane.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$item dismissed')),
                  );
                },
                child: Checend(
                  text: item,
                  checend: checked,
                  onChanged: (value) {
                    setState(() {
                      dane[index][1] = value!;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 4, 0, 255),
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color.fromARGB(255, 10, 21, 51),
              title: Text(
                'Add Item',
                style: TextStyle(color: Colors.white),
              ),
              content: Container(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      maxLength: 20,
                      controller: _controller,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter item',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white10,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 4, 0, 255),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        String newItem = _controller.text.trim();
                        if (newItem.isNotEmpty) {
                          setState(() {
                            dane.add([newItem, false]);
                            _controller.clear();
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Checend extends StatelessWidget {
  final String text;
  final bool checend;
  final ValueChanged<bool?> onChanged;

  const Checend({
    required this.text,
    required this.checend,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        tileColor: Color.fromARGB(255, 10, 21, 51),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text[0].toUpperCase() + text.substring(1),
              style: TextStyle(
                color: checend ? Colors.blue : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                decoration: checend ? TextDecoration.lineThrough : null,
                decorationColor:
                    checend ? Color.fromARGB(255, 7, 3, 255) : null,
                decorationThickness: checend ? 3.0 : null,
              ),
            ),
          ],
        ),
        leading: Checkbox(
          activeColor: Color.fromARGB(255, 4, 0, 255),
          checkColor: Color.fromARGB(255, 25, 44, 69),
          value: checend,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
