class Videos {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Videos({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      id: json['id'],
      iso6391: json['iso_639_1'],
      iso31661: json['iso_3166_1'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
    );
  }
}
