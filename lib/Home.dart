import 'package:flutter/material.dart';
import 'API.dart';
import 'SearchField.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();

}

class HomeState extends State<Home> {

  final TextEditingController textFieldController = TextEditingController();
  List<String> urlList = [];
  List<bool> isPressedList = List.generate(20, (index) => false);

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Future<void> fetchUrls() async {
    String searchText = textFieldController.text;
    List<String> parsedUrls = await parseJsonUrl(searchText);
    setState(() {
      urlList = parsedUrls;
    });
  }
  @override
  void initState() {
    fetchUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget resultPage = urlList.isEmpty
        ? Expanded(child: Center(child: Text('Не знайдено жодної картинки')),)
        : Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: urlList.length,
                itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: GestureDetector(
                            onTap: () {
                              showFullScreenImage(context, urlList[index]);
                            },
                            child: PhotoView(
                              imageProvider: NetworkImage(urlList[index]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPressedList[index] =
                                    !isPressedList[index];
                                    /*if (isPressedList[index]) {
                                      urlFavList.add(urlList[index]);
                                    }
                                    else {
                                      urlFavList.remove(urlList[index]);
                                      }*/
                                    }
                                  );
                                },
                                icon: isPressedList[index]
                                    ? Icon(Icons.star)
                                    : Icon(Icons.star_border),
                                iconSize: 30.0,
                                color: Colors.orange,
                                splashRadius: 24.0,
                              ),
                              IconButton(
                                onPressed: () {
                                  Share.share(urlList[index]);
                                },
                                icon: Icon(Icons.share),
                                iconSize: 30.0,
                                color: Colors.green,
                                splashRadius: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchField(homeState: this, key: UniqueKey(),),
            resultPage,
          ],
        )
    );
  }
}

void showFullScreenImage(BuildContext context, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.black,
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}