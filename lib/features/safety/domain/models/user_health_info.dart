class UserHealthInfo {
  List<String>? illnesses;
  List<String>? medicines;

  UserHealthInfo({this.illnesses, this.medicines});

  UserHealthInfo.fromJson(Map<String, dynamic> json) {
    illnesses = json['illnesses'].cast<String>();
    medicines = json['medicines'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['illnesses'] = this.illnesses;
    data['medicines'] = this.medicines;
    return data;
  }
}
