part of '../custom_radio_grouped_button.dart';

class CustomListViewSpacing extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final Axis scrollDirection;
  final ScrollController? scrollController;
  CustomListViewSpacing(
      {required this.children,
      this.scrollController,
      this.spacing = 0.0,
      this.scrollDirection = Axis.vertical});

  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      controller: scrollController,
      children: children
          .map((c) => Container(
                padding: EdgeInsets.all(spacing),
                child: c,
              ))
          .toList(),
    );
  }
}
