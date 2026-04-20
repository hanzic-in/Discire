import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("What's Happening", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("See all", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        // Card
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                    child: Image.network('url_gambar_postingan'),
                  ),
                  Positioned(
                    top: 10, left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.7), borderRadius: BorderRadius.circular(10)),
                      child: Text("Design", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  )
                ],
              ),
              
              ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage('url_aria')),
                title: Text("Aria Chen"),
                subtitle: Text("2h ago"),
              ),
              
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("New Design System..."),
              )
            ],
          ),
        )
      ],
    );
  }
}
