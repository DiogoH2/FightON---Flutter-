const DATABASE_NAME = 'fight_mobile.db';
const CREATE_TABLE_CLIENTE =
    "CREATE TABLE usuario(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nome TEXT, senha TEXT, email TEXT, cidade TEXT, estado TEXT, celular TEXT, data TEXT, image TEXT)";
const CREATE_TABLE_TESTE =
    "CREATE TABLE conversa(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nome TEXT)";
const CREATE_TABLE_MATCHRECUSADO =
    "CREATE TABLE match_recusado(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nome TEXT, senha TEXT, email TEXT, cidade TEXT, estado TEXT, celular TEXT, data TEXT)";

