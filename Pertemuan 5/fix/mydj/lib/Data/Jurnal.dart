class Jurnal {
  final DateTime _waktuPembuatan;
  String kelas;
  String mapel;
  int jamKe;
  String tujuanPembelajaran;
  String kegiatanPembelajaran;
  String dimensiProfilPelajarPancasila;
  String topik;

  Jurnal({
    this.kelas = '',
    this.mapel = '',
    this.jamKe = 0,
    this.tujuanPembelajaran = '',
    this.kegiatanPembelajaran = '',
    this.dimensiProfilPelajarPancasila = '',
    this.topik = '',
  }) : _waktuPembuatan = DateTime.now();

  DateTime get waktuPembuatan => _waktuPembuatan;
}
