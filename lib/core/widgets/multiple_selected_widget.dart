import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/user_model.dart';

class MultiSelectMembers extends StatefulWidget {
  final List<UserModel> users;
  final Function(List<UserModel>) onConfirm;

  const MultiSelectMembers({
    super.key,
    required this.users,
    required this.onConfirm,
  });

  @override
  _MultiSelectMembersState createState() => _MultiSelectMembersState();
}

class _MultiSelectMembersState extends State<MultiSelectMembers> {
  List<UserModel> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField<UserModel>(
      items:
          widget.users
              .map((user) => MultiSelectItem<UserModel>(user, user.fullName))
              .toList(),
      title: Text("Project Members", style: TextStyles.f16SemiBoldBlack),

      selectedColor: Colors.blue,
      buttonText: Text(
        _selectedUsers.isEmpty
            ? "Select Project Members"
            : "${_selectedUsers.length} Selected",
      ),

      searchable: true,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.primary, width: 1.w),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      listType: MultiSelectListType.CHIP,
      onConfirm: (List<UserModel> selected) {
        setState(() {
          _selectedUsers = selected;
        });
        widget.onConfirm(selected);
      },
      chipDisplay: MultiSelectChipDisplay(
        onTap: (user) {
          setState(() {
            _selectedUsers.remove(user);
          });
        },
      ),
    );
  }
}
