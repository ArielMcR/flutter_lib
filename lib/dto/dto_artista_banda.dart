import 'package:spin_flow/dto/dto.dart';

class DTOArtistaBanda implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String? descricao;
  final String? link;
  final String? foto;
  final bool ativo;

  DTOArtistaBanda({
    this.id,
    required this.nome,
    this.descricao,
    this.link,
    this.foto,
    this.ativo = true,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DTOArtistaBanda &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
