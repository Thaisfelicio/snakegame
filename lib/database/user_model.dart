import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson)));

class UserModel {
  int id;
  String email;
  String senha;
  String maiorPontuacao;

  UserModel({
    required this.id,
    required this.email,
    required this.senha,
    required this.maiorPontuacao,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        senha: json["senha"],
        maiorPontuacao: json["maiorPontuacao"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "senha": senha,
        "maiorPontuacao": maiorPontuacao,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        senha: json["senha"],
        maiorPontuacao: json["maiorPontuacao"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "senha": senha,
        "maiorPontuacao": maiorPontuacao,
      };
}
