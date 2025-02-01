import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';
import 'package:ncdc_assignment/core/widgets/app_svg_icon.dart';
import 'package:ncdc_assignment/core/widgets/button/primary_icon_button.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:ncdc_assignment/features/content/widgets/content_delete_dialog.dart';

class ContentListTile extends HookConsumerWidget {
  const ContentListTile({
    super.key,
    required this.content,
    required this.onTap,
  });

  final Content content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = useState(false);
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isPressed.value ? ColorTheme.brand : ColorTheme.textRegular,
          fontWeight: isPressed.value ? FontWeight.bold : FontWeight.normal,
        );

    return InkWell(
      highlightColor: ColorTheme.backgroundLight,
      splashColor: ColorTheme.backgroundLight,
      onTap: () {
        isPressed.value = true;
        onTap();
      },
      onTapCancel: () {
        isPressed.value = false;
      },
      child: Consumer(builder: (context, ref, child) {
        final isEditing = ref.watch(isEditingContentListProvider);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          minVerticalPadding: 10,
          horizontalTitleGap: 0,
          title: Text(
            content.title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          trailing: isEditing
              ? PrimaryIconButton(
                  icon: SvgIcon.delete,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => ContentDeleteDialog(
                        content: content,
                        dialogContext: dialogContext,
                      ),
                    );
                  },
                )
              : null,
        );
      }),
    );
  }
}
