import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import '../util/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('eventsdb');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("EVENTOS") == null) {
      db.createInitialData();
      vaciarEventos();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _Fechacontroller = TextEditingController();
  final _Titulocontroller = TextEditingController();
  final _Descripcioncontroller = TextEditingController();
  String imagen = '';
  String _audio = '';

  void deleteEvento(int index) {
    setState(() {
      db.sampleEvento.removeAt(index);
    });
    db.updateDataBase();
  }

  void vaciarEventos() {
    setState(() {
      db.sampleEvento.clear();
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.sampleEvento.add([
        _Fechacontroller.text,
        _Titulocontroller.text,
        _Descripcioncontroller.text,
        imagen,
        _audio
      ]);
      print(imagen);
      _Fechacontroller.clear();
      _Titulocontroller.clear();
      _Descripcioncontroller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              Fechacontroller: _Fechacontroller,
              controller: _Titulocontroller,
              Descripcioncontroller: _Descripcioncontroller,
              onSave: saveNewTask,
              onArchivoImagen: selectImagen,
              onArchivoAudio: selectAudio,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void selectImagen() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'tif',
        'webp',
        'svg',
      ],
    );
    if (result == null) return;
    final file = result.files.first;
    final newFile = await guardarArchivo(file);
    imagen = newFile.path;
    print(imagen);
  }

  void selectAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'mp3',
        'ogg',
        'wav',
      ],
    );
    if (result == null) return;
    final file = result.files.first;
    final newFile = await guardarArchivo(file);
    _audio = newFile.path;
    print(_audio);
  }

  Future<File> guardarArchivo(PlatformFile file) async {
    print(file.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('Velo ahi: ${newFile.path}');

    return File(file.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Color(int.parse('#f4ecdc'.substring(1, 7), radix: 16) + 0xFF000000),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Registro de Eventos Liga Kanto'),
        ),
        drawer: DrawerDelegado(
          onVaciar: vaciarEventos,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: Icon(Icons.add)),
        body: ListView.builder(
          itemCount: db.sampleEvento.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              fecha: db.sampleEvento[index][0],
              titulo: db.sampleEvento[index][1],
              descripcion: db.sampleEvento[index][2],
              imagen: db.sampleEvento[index][3],
              audio: db.sampleEvento[index][4],
              onPressed: () => deleteEvento(index),
            );
          },
        ));
  }
}
