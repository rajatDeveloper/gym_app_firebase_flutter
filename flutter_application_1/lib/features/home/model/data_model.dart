import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {
  final String uuid;
  final String title;
  final double distance;
  final String address;
  final String image;
  final String category;
  final int rate;
  DataModel({
    required this.uuid,
    required this.title,
    required this.distance,
    required this.address,
    required this.image,
    required this.category,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'distance': distance,
      'address': address,
      'image': image,
      'category': category,
      'rate': rate,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      uuid: map['uuid'] as String,
      title: map['title'] as String,
      distance: map['distance'] as double,
      address: map['address'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      rate: map['rate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
