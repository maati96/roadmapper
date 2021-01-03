import 'package:flutter/material.dart';
import 'package:roadmap/screens/roadmap/roadmap_detail.dart';

class CategoryDetailList extends StatefulWidget {
  @override
  _CategoryDetailListState createState() => _CategoryDetailListState();
}

class _CategoryDetailListState extends State<CategoryDetailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          "Python Roadmap",
          
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _navbarCard(context),
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Text(
              "Data scientist is one of the best suited professions to thrive this century. It is digital, programming-oriented, and analytical. Therefore, it comes as no surprise that the demand for data scientists has been surging in the job marketplace. However, supply has been very limited. It is difficult to acquire the skills necessary to be hired as a data scientist.  Universities have been slow at creating specialized data science programs. (not to mention that the ones that exist are very expensive and time consuming)  ",
              textAlign: TextAlign.center,
            ),
          ),
          _categoryDetailList(),
        ],
      ),
    );
  }

  Widget _navbarCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/illustrations/illustration-02.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Python RoadMap",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.code, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Learn every thing About python from scratch",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryDetailList() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
           MaterialPageRoute(builder: (context) => RoadmapDetail()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: new EdgeInsets.all(2.0),
        child: Column(
          children: [
            Card(
              color:  Color(0xFF77A5F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(Icons.computer_outlined, size: 30),
                    title: Text('Python Track', style: TextStyle(fontSize: 30.0, color: Colors.white)),
                    subtitle: Text('Best of your carrer.',
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                ],
              ),
            ),
            Card(
              color:  Color(0xFF77A5F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(Icons.code_outlined, size: 30),
                    title: Text('Django Track', style: TextStyle(fontSize: 30.0, color: Colors.white)),
                    subtitle: Text('Best of courses.',
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
