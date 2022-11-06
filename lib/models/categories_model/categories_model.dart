class CategoriesModel{
  bool status;
  String message;
  CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=CategoriesDataModel.fromJson(json['data']);
  }
}


class CategoriesDataModel{
  int currentPage;
  List<DataObjectC> data=[];
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element)
    {
      data.add(DataObjectC.fromJson(element));
    });
    firstPageUrl=json['first_page_url'];
    from=json['from'];
    lastPage=json['last_page'];
    lastPageUrl=json['last_page_url'];
    nextPageUrl=json['next_page_url'];
    path=json['path'];
    perPage=json['per_page'];
    prevPageUrl=json['prev_page_url'];
    to=json['to'];
    total=json['total'];
  }
}


class DataObjectC
{
  int id;
  String name;
  String image;
  DataObjectC.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}