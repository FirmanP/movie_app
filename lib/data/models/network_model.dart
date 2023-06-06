import 'package:ditonton/domain/entities/network.dart';
import 'package:equatable/equatable.dart';

class NetworkModel extends Equatable {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  NetworkModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };

  Network toEntity() {
    return Network(
        id: this.id,
        logoPath: this.logoPath,
        name: this.name,
        originCountry: this.originCountry);
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
