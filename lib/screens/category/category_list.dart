import 'package:flutter/material.dart';
import 'package:roadmap/screens/category/category_detail_list.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool _isLike = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programming Category",),
 
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryDetailList()),
              );
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/illustrations/illustration-05.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New RoadMaps",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer, color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Your Career",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      _isLike ? Icons.favorite : Icons.favorite_border,
                      color: Color(0xFFFD7E77),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (!_isLike) {
                          setState(() {
                            _isLike = true;
                          });
                        } else {
                          setState(() {
                            _isLike = false;
                          });
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
