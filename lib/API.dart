import 'dart:convert';
import 'package:http/http.dart' as http;

class GIF {
  GIF({
    required this.results,
    //required this.next,
  });
  late final List<Results> results;
  late final String next;

  GIF.fromJson(Map<String, dynamic> json){
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.map((e)=>e.toJson()).toList();
    _data['next'] = next;
    return _data;
  }
}

class Results {
  Results({
    required this.id,
    required this.title,
    required this.mediaFormats,
    required this.created,
    required this.contentDescription,
    required this.itemurl,
    required this.url,
    required this.tags,
    required this.flags,
    required this.hasaudio,
  });
  late final String id;
  late final String title;
  late final MediaFormats mediaFormats;
  late final double created;
  late final String contentDescription;
  late final String itemurl;
  late final String url;
  late final List<String> tags;
  late final List<dynamic> flags;
  late final bool hasaudio;

  Results.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    mediaFormats = MediaFormats.fromJson(json['media_formats']);
    created = json['created'];
    contentDescription = json['content_description'];
    itemurl = json['itemurl'];
    url = json['url'];
    tags = List.castFrom<dynamic, String>(json['tags']);
    flags = List.castFrom<dynamic, dynamic>(json['flags']);
    hasaudio = json['hasaudio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['media_formats'] = mediaFormats.toJson();
    _data['created'] = created;
    _data['content_description'] = contentDescription;
    _data['itemurl'] = itemurl;
    _data['url'] = url;
    _data['tags'] = tags;
    _data['flags'] = flags;
    _data['hasaudio'] = hasaudio;
    return _data;
  }
}

class MediaFormats {
  MediaFormats({
    required this.tinygif,
  });
  late final Tinygif tinygif;

  MediaFormats.fromJson(Map<String, dynamic> json){
    tinygif = Tinygif.fromJson(json['tinygif']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tinygif'] = tinygif.toJson();
    return _data;
  }
}

class Tinygif {
  Tinygif({
    required this.url,
    required this.duration,
    required this.preview,
    required this.dims,
    required this.size,
  });
  late final String url;
  late final int? duration;
  late final String preview;
  late final List<int> dims;
  late final int size;

  Tinygif.fromJson(Map<String, dynamic> json){
    url = json['url'];
    duration = json['duration'];
    preview = json['preview'];
    dims = List.castFrom<dynamic, int>(json['dims']);
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['duration'] = duration;
    _data['preview'] = preview;
    _data['dims'] = dims;
    _data['size'] = size;
    return _data;
  }
  String getUrl() {
    return url;
  }
}

/*List<String> parseJsonUrl(String jsonString) {
  List<String> urlRezults = [];
  var jsonData = json.decode(jsonString);
  var gifData = GIF.fromJson(jsonData);

  for (var result in gifData.results) {
    var tinyGif = result.mediaFormats.tinygif;
    var url = tinyGif.getUrl();
    urlRezults.add(url);
    //print('URL: $url');
  }
  return urlRezults;
}*/

Future<List<String>> parseJsonUrl(String query) async {
  List<String> urlRezults = [];
  var apiKey = 'AIzaSyCcKkgfBmNOutFP6RH6R-YCfn1I4MKiEZY';
  var url = Uri.parse('https://tenor.googleapis.com/v2/search?q=$query&key=$apiKey&limit=20');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = response.body;
    var jsonData = json.decode(data);
    var gifData = GIF.fromJson(jsonData);
    for (var result in gifData.results) {
      var tinyGif = result.mediaFormats.tinygif;
      var url = tinyGif.getUrl();
      urlRezults.add(url);
      //print('URL: $url');
    }
    //parseJsonUrl(data);
    return urlRezults;
  }
  /*else {
  return ('Помилка ${response.statusCode}: ${response.reasonPhrase}');
  }*/
  return [];
}





