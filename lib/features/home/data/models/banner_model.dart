import 'package:xedu/features/home/domain/entity/banner.dart';

class BannerModel extends Banner {
  BannerModel({required super.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
      banner: List<BannerDataModel>.from(json["data"].map((x)=>BannerDataModel.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(banner.map((e) => e.toJson()))
  };
}

class BannerDataModel extends BannerData {
  BannerDataModel({required super.id, required super.image});

  factory BannerDataModel.fromJson(Map<String, dynamic> json){
    return BannerDataModel(
      id: json['id'],
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image
  };
}