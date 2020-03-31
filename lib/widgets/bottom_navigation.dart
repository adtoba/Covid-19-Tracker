import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: width,
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/menu.png'),
                    color: Colors.grey,
                  ),
                  onPressed: () => print('0 pressed'),
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/box.png'),
                    color: Colors.blue,
                  ),
                  onPressed: () => print('0 pressed'),
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/chat.png'),
                    color: Colors.grey,
                  ),
                  onPressed: () => print('0 pressed'),
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/marker.png'),
                    color: Colors.grey,
                  ),
                  onPressed: () => print('0 pressed'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
