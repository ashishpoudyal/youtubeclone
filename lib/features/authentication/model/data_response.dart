class DataResponse {
  bool status;
  String message;
  dynamic data;
  DataResponse({
    required this.status,
    required this.message,
    this.data,
  });
  factory DataResponse.sucess({
    required dynamic data,
  }) {
    return DataResponse(
      status: true,
      message: "",
      data: data,
    );
  }
  factory DataResponse.error({
    required String message,
  }) {
    return DataResponse(
      status: true,
      message: message,
    );
  }
}
