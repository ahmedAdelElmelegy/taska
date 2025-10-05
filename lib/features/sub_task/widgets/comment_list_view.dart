import 'package:flutter/material.dart';

import 'package:taska/data/model/comment_model.dart';
import 'package:taska/features/sub_task/widgets/comment_item.dart';

class CommentListView extends StatelessWidget {
  final List<CommentModel>? commentList;

  const CommentListView({super.key, this.commentList});

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: commentList!.length,
      itemBuilder:
          (context, index) => CommentItem(commentModel: commentList![index]),
    );
  }
}
