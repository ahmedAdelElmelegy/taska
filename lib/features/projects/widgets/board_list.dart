import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/projects/widgets/board_item.dart';

class BoardList extends StatefulWidget {
  final String projectId;
  final ProjectModel projectModel;
  const BoardList({
    super.key,
    required this.projectId,
    required this.projectModel,
  });

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<ProjectCubit>(context).getBoard(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      buildWhen: (previous, current) {
        return current is GetBoardLoading ||
            current is GetBoardSuccess ||
            current is GetBoardFailure;
      },
      builder: (context, state) {
        if (state is GetBoardFailure) {
          return Center(
            child: Text(
              'Failed to load boards: ${state.message}',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        } else if (state is GetBoardSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(state.board.length, (index) {
                return BoardItem(
                  boardModel: state.board[index],
                  projectModel: widget.projectModel,
                );
              }),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
