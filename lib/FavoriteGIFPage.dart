import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'Home.dart';

List<String> listGif = ['https://media.tenor.com/NQfq1liFH-8AAAAM/byuntear-sad.gif',
  'https://media.tenor.com/Ro5LGkOGGS0AAAAM/cat-catdriving.gif',
  'https://media.tenor.com/wL59aqQiwzAAAAAS/cat-kitty.gif'];

class FavoriteGIFPage extends StatefulWidget{

  @override
  _FavoriteGIFPageState createState() => _FavoriteGIFPageState();
}

class _FavoriteGIFPageState extends State<FavoriteGIFPage> {

  void deleteCard(int index) {
    setState(() {
      listGif.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: listGif.length,
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
                                showFullScreenImage(
                                    context, listGif[index]);
                                },
                              child: PhotoView(
                                imageProvider: NetworkImage(
                                    listGif[index]),
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
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                IconButton(onPressed: () async {
                                  deleteCard(index);
                                  },
                                    icon: Icon(Icons.delete,
                                        color: Colors.red)),
                                IconButton(
                                  onPressed: () {
                                    Share.share(
                                        listGif[index]);
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
                      ]
                  )
              );
            }
        )
    );
  }

}

class FavList {
  List<String> listGif;
  FavList({required this.listGif});
}


