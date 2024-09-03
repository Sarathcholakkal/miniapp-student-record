class StudentModel {
  int? id;
  final String name;
  final String email;
  final String domain;
  final String number;
  final String image;

  StudentModel({
    this.id,
    required this.name,
    required this.email,
    required this.domain,
    required this.number,
    required this.image,
  });

  static StudentModel formMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final email = map['email'] as String;
    final domain = map['domain'] as String;
    final phone = map['phone'] as String;
    final image = map['image'] as String;
    return StudentModel(
        name: name,
        email: email,
        domain: domain,
        number: phone,
        image: image,
        id: id);
  }
}
