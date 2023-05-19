class Models {
  String? object;
  List<Data>? data;
  Error? error;

  Models({this.object, this.data,this.error});

  Models.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }
}

class Data {
  String? id;

  Data({this.id});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Error {
  String? message;
  String? type;

  Error({this.message, this.type});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    return data;
  }
}
