import 'package:sqflite/sqflite.dart';

final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "phoneColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";


class ContactHelper{

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

}