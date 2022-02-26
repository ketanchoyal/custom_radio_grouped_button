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
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      scrollController: scrollController,
      itemCount: children.length
      builder : (context, index) {
        return Container(
                padding: EdgeInsets.all(spacing),
                child: children[index],
              );
      }
      // children: children
      //     .map((c) => )
      //     .toList(),
    );
  }
}
