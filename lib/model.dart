class Blog {
  final String arti;
  // final String name_translations;
  final String asma;
  final String audio;
  final int ayat;
  final String keterangan;
  final String nama;
  // final int nomor;
  // final int ruku;
  final String type;
  // final int urut;

  const Blog({
    // required this.name_translations,
    required this.arti,
    required this.asma,
    required this.audio,
    required this.ayat,
    required this.keterangan,
    required this.nama,
    // required this.nomor,

    // required this.ruku,

    required this.type,
    // required this.urut
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      // name_translations: json['name_translations'],
      arti: json['arti'],
      asma: json['asma'],
      audio: json['audio'],
      ayat: json['ayat'],
      keterangan: json['keterangan'],
      nama: json['nama'],
      // nomor: json['nomor'],
      // ruku: json['ruku'],
      type: json['type'],
      // urut: json['urut'],
    );
  }
}
