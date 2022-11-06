class GetFavoritesModel {
  bool status;
  String message;
  Data data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int currentPage;
  List<DataObject> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  int nextPageUrl;
  String path;
  int perPage;
  int prevPageUrl;
  int to;
  int total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<DataObject>();
      json['data'].forEach((v) {
        data.add(new DataObject.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class DataObject {
  int id;
  Product product;


  DataObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

}

class Product {
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].toInt();
    oldPrice = json['old_price'].toInt();
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
