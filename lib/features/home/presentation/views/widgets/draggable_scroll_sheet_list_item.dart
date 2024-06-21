import 'package:flutter/material.dart';

class DraggableScrollSheetListItem extends StatelessWidget {
  const DraggableScrollSheetListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        /*backgroundImage: AssetImage(''),*/
      ),
      title: Text("Bishoy"),
      subtitle: Text("Developer"),
    );
  }
}
