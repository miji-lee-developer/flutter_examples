/*
* JSON Decoding Model
*/

class ImageModel {
  int id;
  String url;
  String title;

  ImageModel(this.id, this.url, this.title);

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }

  // It is an other way to parse Json
  // ImageModel.fromJson(Map<String, dynamic> parsedJson)
  // : id = parsedJson['id'],
  //   url = parsedJson['url'],
  //   title = parsedJson['title'];

  @override
  String toString() {
    return '$id, $url, $title';
  }
}