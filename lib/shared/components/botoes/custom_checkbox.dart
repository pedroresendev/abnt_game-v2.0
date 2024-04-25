import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool? isChecked;
  final double? size;
  final double? iconSize;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Color? borderColor;
  final IconData checkIcon;

  CustomCheckbox(
      {this.isChecked,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor,
      this.borderColor,
      required this.checkIcon});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        margin: EdgeInsets.all(4),
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: _isSelected
                ? widget.selectedColor ?? Colors.blue
                : lilas.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(
              color: widget.borderColor ?? Colors.black,
              width: 1.5,
            )),
        width: widget.size ?? 25,
        height: widget.size ?? 25,
        child: _isSelected
            ? Icon(
                widget.checkIcon,
                color: widget.selectedIconColor ?? Colors.white,
                size: widget.iconSize ?? 15,
              )
            : null,
      ),
    );
  }
}