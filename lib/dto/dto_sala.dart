import 'package:spin_flow/dto/dto.dart';

class DTOSala implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final int numeroBikes;
  final int numeroFilas;
  final int limiteBikesPorFila;
  final List<List<bool>> gradeBikes;
  final bool ativa;

  DTOSala({
    this.id,
    required this.nome,
    required this.numeroBikes,
    required this.numeroFilas,
    required this.limiteBikesPorFila,
    required this.gradeBikes,
    this.ativa = true,
  });
  @override
  String toString() => nome;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DTOSala && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
