// lib/banco/sqlite/dao/dao_bike.dart
import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/dto_bike.dart';
import 'package:spin_flow/dto/dto_fabricante.dart';
import 'package:spin_flow/banco/sqlite/dao/dao_fabricante.dart';

class DAOBike {
  static const String _tabela = 'bike';

  // Salvar (inserir ou atualizar)
  Future<int> salvar(DTOBike bike) async {
    final db = await ConexaoSQLite.database;
    final dados = {
      'nome': bike.nome,
      'numero_serie': bike.numeroSerie,
      'fabricante_id': bike.fabricante.id,
      'data_cadastro': bike.dataCadastro.toIso8601String(),
      'ativa': bike.ativa ? 1 : 0,
    };

    if (bike.id != null) {
      return await db.update(
        _tabela,
        dados,
        where: 'id = ?',
        whereArgs: [bike.id],
      );
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  // Buscar todos
  Future<List<DTOBike>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final List<Map<String, dynamic>> maps = await db.query(_tabela);

    final daoFabricante = DAOFabricante();

    return Future.wait(maps.map((map) async {
      final fabricante = await daoFabricante.buscarPorId(map['fabricante_id']);
      if (fabricante == null) {
        throw Exception(
            'Fabricante com ID ${map['fabricante_id']} não encontrado.');
      }

      return DTOBike(
        id: map['id'],
        nome: map['nome'],
        numeroSerie: map['numero_serie'],
        fabricante: fabricante,
        dataCadastro: DateTime.parse(map['data_cadastro']),
        ativa: map['ativa'] == 1,
      );
    }).toList());
  }

  // Buscar por ID
  Future<DTOBike?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    final map = maps.first;
    final daoFabricante = DAOFabricante();
    final fabricante = await daoFabricante.buscarPorId(map['fabricante_id']);

    if (fabricante == null) {
      throw Exception(
          'Fabricante com ID ${map['fabricante_id']} não encontrado.');
    }

    return DTOBike(
      id: map['id'],
      nome: map['nome'],
      numeroSerie: map['numero_serie'],
      fabricante: fabricante,
      dataCadastro: map['data_cadastro'],
      ativa: map['ativa'] == 1,
    );
  }

  // Excluir
  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
