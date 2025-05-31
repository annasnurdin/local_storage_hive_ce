import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ambil box atau databasenya
  final _database = Hive.box("box_database"); //sama dengan di main.dart

  //controller
  final _textController = TextEditingController();

  //list catatan
  List tabelCatatan = [];

  @override
  void initState() {
    //load tabel catatan
    tabelCatatan = _database.get("tabel_catatan") ??
        []; //kalau null, tampilkan array kosong
    super.initState();
  }

  //buka dialog baru untuk menambah catatan
  void bukaCatatan() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Catatan Baru"),
              content: TextField(
                controller: _textController,
              ),
              actions: [
                //save
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tambahCatatan();
                  },
                  child: const Text("Save"),
                ),
                //cancel
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _textController.clear();
                  },
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  //tambah catatan
  void tambahCatatan() {
    String isiCatatan = _textController.text;
    setState(() {
      tabelCatatan.add(isiCatatan);
      _textController.clear();
    });
    simpanData();
  }

  //hapus catatan
  void hapus(int index) {
    setState(() {
      tabelCatatan.removeAt(index);
    });
    simpanData();
  }

  //simpan ke box / database
  void simpanData() {
    _database.put("tabel_catatan",
        tabelCatatan); //tabel boxnya sebagai key, dan tabel isinya sebagai value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bukaCatatan,
        child: const Icon(Icons.add),
      ),

      //tampilkan catatan disini pakai Listview.builder
      body: ListView.builder(
          itemCount: tabelCatatan.length,
          itemBuilder: (context, index) {
            //ambil masing masing baris
            final catatan = tabelCatatan[index];
            return ListTile(
              title: Text(catatan),
              trailing: IconButton(
                  onPressed: () => hapus(index),
                  icon: const Icon(Icons.delete)),
            );
          }),
    );
  }
}
