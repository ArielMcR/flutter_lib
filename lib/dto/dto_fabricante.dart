import 'package:spin_flow/dto/dto.dart';

class DTOFabricante implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String? descricao;
  final String? nomeContatoPrincipal;
  final String? emailContato;
  final String? telefoneContato;
  final bool ativo;

  DTOFabricante({
    this.id,
    required this.nome,
    this.descricao,
    this.nomeContatoPrincipal,
    this.emailContato,
    this.telefoneContato,
    this.ativo = true,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DTOFabricante &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
