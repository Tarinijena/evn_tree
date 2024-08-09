class GetLocationModel {
  List<Data>? data;
  bool? status;

  GetLocationModel({this.data, this.status});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? cityName;
  String? cityCode;
  String? cityId;

  Data({this.cityName, this.cityCode, this.cityId});

  Data.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    cityCode = json['cityCode'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['cityCode'] = this.cityCode;
    data['cityId'] = this.cityId;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Data otherData = other as Data;
    return cityName == otherData.cityName && cityCode == otherData.cityCode && cityId == otherData.cityId;
  }

  @override
  int get hashCode => cityName.hashCode ^ cityCode.hashCode ^ cityId.hashCode;
}
