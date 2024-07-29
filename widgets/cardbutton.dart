import 'package:flutter/material.dart';
import 'package:guidi/misc/theme.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    this.onTap,
    this.icon,
    this.subtitle,
    this.title,
    this.border = false,
    this.backgroundColor = Colors.white,
  });

  final void Function()? onTap;
  final Widget? icon;
  final Widget? title;
  final Widget? subtitle;
  final bool border;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
          side: border
              ? const BorderSide(color: GUIDiTheme.darkGrey, width: 2)
              : BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 180,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) icon!,
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: title,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: subtitle ?? const Text(""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
