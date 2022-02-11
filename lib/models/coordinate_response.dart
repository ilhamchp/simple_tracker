class CoordinateResponse {
  bool success;
  String message;

  CoordinateResponse({this.success, this.message});

  CoordinateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}