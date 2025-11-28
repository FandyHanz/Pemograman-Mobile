class Jurnal {
  final DateTime _waktuPembuatan;
  String kelas;
  String mapel;
  int jamKe;
  String tujuanPembelajaran;
  String kegiatanPembelajaran;
  String dimensiProfilPelajarPancasila;
  String topik;
  String? fotoKegiatanPath;
  String? videoKegiatanPath;

  Jurnal(
      {this.kelas = '',
      this.mapel = '',
      this.jamKe = 0,
      this.tujuanPembelajaran = '',
      this.kegiatanPembelajaran = '',
      this.dimensiProfilPelajarPancasila = '',
      this.topik = '',
      this.fotoKegiatanPath,
      this.videoKegiatanPath})
      : _waktuPembuatan = DateTime.now();

  DateTime get waktuPembuatan => _waktuPembuatan;
}
