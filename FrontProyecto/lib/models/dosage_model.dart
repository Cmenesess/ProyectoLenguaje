class MedioContacto {
  final String medio;
  final String valor;

  const MedioContacto({
    required this.medio,
    required this.valor,
  });

  MedioContacto copy({
    String? medio,
    String? valor,
  }) =>
      MedioContacto(
        medio: medio ?? this.medio,
        valor: valor ?? this.valor,
      );
}
