class Staff {
  final int id;
  final String name;
  final String address;
  final String designation;

  Staff({
    required this.id,
    required this.name,
    required this.address,
    required this.designation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'designation': designation,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      designation: map['designation'],
    );
  }
}

