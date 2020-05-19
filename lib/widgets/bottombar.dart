import 'package:flutter/material.dart';

class MkBottomBar extends StatefulWidget {
  const MkBottomBar({
    @required this.titles,
    @required this.icons,
    @required this.onTabSelected,
    @required this.index,
    Key key,
  }) : super(key: key);

  final List<String> titles;
  final List<IconData> icons;
  final ValueChanged<int> onTabSelected;
  final int index;

  @override
  _MkBottomBarState createState() => _MkBottomBarState();
}

class _MkBottomBarState extends State<MkBottomBar> {
  // selected index
  int selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomBarItem> items =
        List<BottomBarItem>.generate(widget.titles.length, (int index) {
      return BottomBarItem(
        title: widget.titles[index],
        icon: widget.icons[index],
        index: widget.index,
        selectedIndex: selectedIndex,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 10.0,
      child: Container(
        height: 60.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: items),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
    @required this.index,
    @required this.selectedIndex
  }) : super(key: key);

  final String title;
  final IconData icon;
  final ValueChanged<int> onPressed;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    Color color = selectedIndex == index ? Colors.red : Colors.grey;
    return InkWell(
      onTap: () => onPressed(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }
}
