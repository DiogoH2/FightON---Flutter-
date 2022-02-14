class Usuario {
  int id;
  String nome;
  String senha;
  String email;
  String cidade;
  String estado;
  String celular;
  String data;
  String image;


  Usuario(
      {this.id,
      this.nome,
      this.senha,
      this.email,
      this.cidade,
      this.estado,
      this.celular,
      this.data,
      this.image,
});

  Usuario.fromMap(Map<String, dynamic> mapCliente) {
    id = mapCliente['id'];
    nome = mapCliente['nome'];
    senha = mapCliente['senha'];
    email = mapCliente['email'];
    cidade = mapCliente['cidade'];
    estado = mapCliente['estado'];
    celular = mapCliente['celular'];
    data = mapCliente['data'];
    image = mapCliente['image'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'email': this.email,
      'senha': this.senha,
      'cidade': this.cidade,
      'estado': this.estado,
      'celular': this.celular,
      'data': this.data,
      'image': this.image

    };
  }
}

