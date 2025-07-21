import 'package:flutter/material.dart';
import 'package:taska/features/sub_task/widgets/comment_item.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => CommentItem(),
    );
  }
}
