class Buku {
  int? id;
  String? judul;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  int? volume;
  String? penulis;
  String? penerbit;

  Buku({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });

  factory Buku.fromJson(Map<String, dynamic> obj) {
    return Buku(
      id: int.parse(obj['id']),
      judul: obj['judul'],
      harga: int.parse(obj['harga']),
      jumlah: int.parse(obj['jumlah']),
      tanggalMasuk: obj['tanggal_masuk'],
      volume: int.parse(obj['volume']),
      penulis: obj['penulis'],
      penerbit: obj['penerbit'],
    );
  }
}