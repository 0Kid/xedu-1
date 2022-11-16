import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final List<BannerData> banner;

  Banner({required this.banner});

  @override
  List<Object?> get props => banner;
  
}

class BannerData extends Equatable{
  final int id;
  final String image;

  BannerData({required this.id, required this.image});

  @override
  List<Object?> get props => [id, image];

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image
  };
  
}