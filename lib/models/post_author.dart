class PostAuthor {
  int? id;
  String? name;
  String? username;
  String? email;
  Map<String, dynamic>? address;
  String? phone;
  String? website;
  Map<String, dynamic>? company;

  PostAuthor(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  factory PostAuthor.fromJson(json) {
    return PostAuthor(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      website: json['website'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address,
      'phone': phone,
      'website': website,
      'company': company,
    };
  }
}
