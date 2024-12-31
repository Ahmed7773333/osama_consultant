class QuoteModelResponse {
  bool? success;
  List<QuoteModel>? quotes;
  String? message;

  QuoteModelResponse({this.success, this.quotes, this.message});

  QuoteModelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      quotes = <QuoteModel>[];
      json['data'].forEach((v) {
        quotes!.add(new QuoteModel.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class QuoteModel {
  int? id;
  String? quote;
  String? image;
  String? createdAt;
  String? updatedAt;

  QuoteModel({this.id, this.quote, this.createdAt, this.image, this.updatedAt});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
