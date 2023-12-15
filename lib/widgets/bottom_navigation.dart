import 'package:flutter/material.dart';
import 'package:wisata_app/widgets/style.dart';

const Color PRIMARY_COLOR = Color(0xFF777777);
const Color BACKGROUND_COLOR = Colors.white;

class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color itemColor;
  final List<CustomBottomNavigationItem> children;
  final Function(int)? onChange;
  final int? currentIndex;

  CustomBottomNavigationBar(
      {this.backgroundColor = BACKGROUND_COLOR,
      this.itemColor = PRIMARY_COLOR,
      this.currentIndex = 0,
      required this.children,
      this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            offset: Offset(-5, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.children.map(
          (item) {
            var icon = item.icon;
            var iconactive = item.iconactive;
            var label = item.label;
            int index = widget.children.indexOf(item);
            return GestureDetector(
              onTap: () {
                _changeIndex(index);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                // width: widget.currentIndex == index
                //     ? MediaQuery.of(context).size.width / widget.children.length +
                //         20
                //     : 50,
                // padding: EdgeInsets.only(
                //     left: index == 2 ? 40 : 5, right: index == 1 ? 40 : 5),
                padding: EdgeInsets.only(
                    left: index == 2 ? 10 : 5, right: index == 1 ? 10 : 5),
                margin: EdgeInsets.only(top: 5, bottom: 5),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.currentIndex == index
                        ? Image.asset(iconactive!, width: 25, height: 25)
                        : Image.asset(icon, width: 25, height: 25),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontSize: 10,
                          fontWeight: widget.currentIndex == index
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: widget.currentIndex == index
                              ? Style.text2Color
                              : Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final String? iconactive;
  final String icon;
  final String label;
  final Color? color;

  CustomBottomNavigationItem(
      {required this.icon, this.iconactive, required this.label, this.color});
}
