import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "phoneColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";


class ContactHelper{ //usando o padrão de projeto singleton para evitar que o objeto seja instanciado mais de uma vez
  static final ContactHelper  _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db; //Apenas a classe contact helper vai poder mexer na classe

  Future<Database>get db async{
    if (_db != null){
      return _db;

    }else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{//será realizado apenas na primeira vez para iniciar o banco
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)"
      );

    });
  }

}

class Contact {

  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap (Map map){//armazena os contatos no formato de mapa
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

//transforma o contato em mapa

Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if (id != null){ // o id é adicionado pelo banco de dados
      map[idColumn] = id;
    }
    return map;
 }

  @override //para dar print no contato
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}