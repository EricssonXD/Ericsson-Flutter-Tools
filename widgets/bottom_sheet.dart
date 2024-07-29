// ignore_for_file: unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guidi/languages/require_localization.dart';
import 'package:guidi/util/options/options.dart';

Future<dynamic> myBottomSheetSettings({
  required BuildContext context,
  Key? key,
  String? title,
  String? description,
  dynamic settingState,
  double? sliderMax,
  double? sliderMin,
  int? sliderDivision,
  Color? barrierColor = Colors.transparent,
  String Function(double numberState)? sliderLabel,
  required void Function(dynamic result) onSave,
}) {
  return showModalBottomSheet<dynamic>(
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      useRootNavigator: true,
      context: context,
      builder: (builder) {
        return _CustomBottomSheet(
          key: key,
          description: description,
          title: title,
          settingState: settingState,
          sliderMax: sliderMax,
          sliderMin: sliderMin,
          sliderDivision: sliderDivision,
          sliderLabel: sliderLabel,
          onSave: onSave,
        );
      });
}

class _CustomBottomSheet extends StatefulWidget {
  const _CustomBottomSheet({
    this.title = "",
    this.description = "",
    this.settingState,
    this.sliderMax = 100,
    this.sliderMin = 0,
    this.sliderDivision,
    this.sliderLabel,
    required this.onSave,
    super.key,
  });
  final String? title;
  final String? description;
  final dynamic settingState;
  final double? sliderMax;
  final double? sliderMin;
  final int? sliderDivision;
  final void Function(dynamic) onSave;
  final String Function(double intState)? sliderLabel;
  @override
  State<_CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  late dynamic settingState;
  bool boolState = false;
  double numberState = 0;
  BeltMode beltModeState = BeltMode.educationMode;

  @override
  void initState() {
    super.initState();
    settingState = widget.settingState;

    switch (settingState.runtimeType) {
      case const (bool):
        boolState = settingState;
        break;
      case const (double):
        numberState = settingState;
        break;
      case const (int):
        numberState = (settingState as int).toDouble();
        break;
      case const (BeltMode):
        beltModeState = settingState;
        break;
      default:
        throw (Exception(
            "SettingState of Type ${settingState.runtimeType} is not supported"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget yesNoRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => setState(() => boolState = true),
          child: Text(
            'ON',
            style: TextStyle(
              color: boolState ? Colors.black : const Color(0xFF465370),
              decoration: boolState ? TextDecoration.underline : null,
              fontWeight: boolState ? FontWeight.bold : null,
            ),
          ),
        ),
        Text("|", style: TextStyle(fontSize: 20.spMax)),
        TextButton(
          onPressed: () => setState(() => boolState = false),
          child: Text(
            'OFF',
            style: TextStyle(
              color: !boolState ? Colors.black : const Color(0xFF465370),
              decoration: !boolState ? TextDecoration.underline : null,
              fontWeight: !boolState ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );

    Widget slider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.spMin, vertical: 8),
      child: Theme(
        data: Theme.of(context).copyWith(),
        child: SliderTheme(
          data: SliderThemeData(
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            // valueIndicatorShape: SliderComponentShape.noThumb,
          ),
          child: Slider(
            activeColor: Colors.black,
            secondaryActiveColor: Colors.white,
            inactiveColor: const Color.fromRGBO(220, 220, 220, 1),
            value: numberState,
            max: widget.sliderMax ?? 100,
            min: widget.sliderMin ?? 0,
            divisions: widget.sliderDivision,
            label: widget.sliderLabel == null
                ? null
                : widget.sliderLabel!(numberState),
            onChanged: (double value) {
              setState(() {
                numberState = value;
              });
            },
          ),
        ),
      ),
    );

    Widget beltModeWidget = _BeltModeWidget(
      beltMode: beltModeState,
      callback: (beltmode) => beltModeState = beltmode,
    );

    return MyBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.title ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.description ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ),

          if (settingState.runtimeType == bool) yesNoRow,
          if (settingState.runtimeType == int) slider,
          if (settingState.runtimeType == BeltMode) beltModeWidget,

          const SizedBox(height: 10),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Color(0xFF465370)),
                    // minimumSize: const Size.fromWidth(100),
                    fixedSize: Size(200.spMin, 70.spMin),
                    padding: const EdgeInsets.all(12),
                    foregroundColor: const Color(0xFF465370),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(MyTexts.cancel),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // minimumSize: const Size.fromWidth(100),
                      fixedSize: Size(200.spMin, 70.spMin),
                      padding: const EdgeInsets.all(12),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      backgroundColor: const Color(0xFF465370)),
                  onPressed: () {
                    switch (settingState.runtimeType) {
                      case const (bool):
                        settingState = boolState;
                      case const (double):
                        settingState = numberState;
                      case const (int):
                        settingState = numberState.toInt();
                      case const (BeltMode):
                        settingState = beltModeState;
                      default:
                        break;
                    }
                    widget.onSave(settingState);
                    Navigator.of(context).pop();
                  },
                  child: Text(MyTexts.save),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key, required this.child});

  final Widget child;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => build(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      // height: 250,

      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      color: Colors.white,
      child: SafeArea(
        child: child,
      ),
    );
  }
}

class _BeltModeWidget extends StatefulWidget {
  const _BeltModeWidget({
    super.key,
    required this.beltMode,
    required this.callback,
  });

  final void Function(BeltMode beltmode) callback;
  final BeltMode beltMode;

  @override
  State<_BeltModeWidget> createState() => __BeltModeWidgetState();
}

class __BeltModeWidgetState extends State<_BeltModeWidget> {
  @override
  Widget build(BuildContext context) {
    // return const Column(
    //   mainAxisSize: MainAxisSize.min,
    // );

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DefaultTabController(
        initialIndex: min(widget.beltMode.index, 1),
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.0.sp),
              child: SizedBox(
                height: 35,
                child: Material(
                  color: const Color.fromRGBO(229, 229, 229, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: TabBar(
                    splashBorderRadius:
                        const BorderRadius.all(Radius.circular(50)),
                    indicator: const BoxDecoration(
                      color: Color.fromRGBO(70, 83, 112, 1),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    indicatorColor: Colors.white,
                    unselectedLabelColor: const Color.fromRGBO(52, 52, 52, 1),
                    labelColor: Colors.white,
                    onTap: (tabNumber) =>
                        widget.callback(BeltMode.values[tabNumber]),
                    tabs: const [
                      Tab(
                        text: "Exploring",
                      ),
                      Tab(
                        text: "Navigating",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(const Size.fromHeight(50)),
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ///Exploring mode description
                    Text(
                        "This mode helps you to detect different obstacle and lets you explore freely"),

                    ///Navigating mode description
                    Text(
                        "This mode help to automatically load the guiding path and lead you to the correct direction (e.g. Tactile guide path)"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
