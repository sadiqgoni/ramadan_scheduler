class MosqueModel {
  final String id;
  final String name;
  final String address;
  final String? phoneNumber;
  final List<String> adminIds;
  final GeoPoint location;
  final String? imageUrl;

  MosqueModel({
    required this.id,
    required this.name,
    required this.address,
    this.phoneNumber,
    required this.adminIds,
    required this.location,
    this.imageUrl,
  });

  factory MosqueModel.fromJson(Map<String, dynamic> json) {
    return MosqueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      adminIds: List<String>.from(json['adminIds']),
      location: GeoPoint(
        json['location']['latitude'] as double,
        json['location']['longitude'] as double,
      ),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'adminIds': adminIds,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'imageUrl': imageUrl,
    };
  }
}

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);
}
