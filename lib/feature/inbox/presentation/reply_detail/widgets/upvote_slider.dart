import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/reply_detail/widgets/upvote_percentage_buttons.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class UpvoteSlider extends StatefulWidget {
  const UpvoteSlider(
      {super.key, required this.onChanged, required this.initialWeight});

  final Function(double) onChanged;
  final double initialWeight;

  @override
  State<UpvoteSlider> createState() => _UpvoteSliderState();
}

class _UpvoteSliderState extends State<UpvoteSlider> {
  late double sliderValue;

  @override
  void initState() {
    sliderValue = widget.initialWeight;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UpvoteSlider oldWidget) {
    sliderValue = widget.initialWeight;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your vote: ${displayWeight()}"),
        SfSliderTheme(
          data: SfSliderThemeData(
              activeLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              inactiveLabelStyle: theme.textTheme.labelMedium!
                  .copyWith(color: theme.primaryColorDark.withOpacity(0.8)),
              tooltipTextStyle: TextStyle(
                  color: theme.primaryColorLight, fontWeight: FontWeight.bold)),
          child: SfSlider(
            shouldAlwaysShowTooltip: false,
            min: 0,
            max: 100.0,
            activeColor: Colors.blue,
            inactiveColor: theme.primaryColorDark,
            value: sliderValue,
            labelFormatterCallback: (actualValue, formattedText) =>
                displayWeight(value: actualValue.toInt()),
            interval: 10,
            showTicks: false,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            showDividers: true,
            dividerShape: _DividerShape(),
            onChanged: (dynamic value) {
              widget.onChanged(value);
              setState(
                () {
                  sliderValue = value;
                },
              );
            },
          ),
        ),
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            percentageButtons(10),
            const Gap(15),
            percentageButtons(25),
            const Gap(15),
            percentageButtons(50),
            const Gap(15),
            percentageButtons(75),
            const Gap(15),
            percentageButtons(100),
          ],
        ),
      ],
    );
  }

  String displayWeight({int? value}) {
    var voteValue = (value ?? sliderValue);
    var intVoteValue = voteValue.round();
    return context.isMobileSize ? intVoteValue.toString() : "$intVoteValue %";
  }

  Widget percentageButtons(double value) {
    return UpVotePercentageButtons(
        onTap: (weight) {
          if (mounted) {
            widget.onChanged(weight);
            setState(
              () {
                sliderValue = weight;
              },
            );
          }
        },
        percentageValue: value);
  }
}

class _DividerShape extends SfDividerShape {
  @override
  void paint(PaintingContext context, Offset center, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection}) {
    bool isActive;

    switch (textDirection) {
      case TextDirection.ltr:
        isActive = center.dx <= thumbCenter!.dx;
        break;
      case TextDirection.rtl:
        isActive = center.dx >= thumbCenter!.dx;
        break;
    }

    context.canvas.drawRect(
        Rect.fromCenter(center: center, width: 5.0, height: 10.0),
        Paint()
          ..isAntiAlias = true
          ..style = PaintingStyle.fill
          ..color = isActive ? themeData.activeTrackColor! : Colors.white);
  }
}
