// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shop_app/core/utils/app_colors.dart';

class Components {
  static Widget customTextField({
    required String hint,
    bool isPassword = false,
    bool isShow = false,
    VoidCallback? onPressed,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onSubmit,
    IconData? icon,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 335.w,
      height: 64.h,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            controller: controller,
            obscureText: isPassword ? !isShow : false,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Field can\'t be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(
                icon,
                size: 30.sp,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                        if (onPressed != null) onPressed();
                      },
                      icon: Icon(
                        isShow ? Icons.visibility : Icons.visibility_off,
                        size: 30.sp,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
  // static Widget openContainers({Widget? closedWidget, Widget? openedWidget}) {
  //   return OpenContainer(
  //     closedElevation: 0,
  //     openElevation: 0,
  //     transitionDuration: const Duration(milliseconds: 500),
  //     closedColor: Colors.transparent,
  //     openColor: Colors.transparent,
  //     closedBuilder: (BuildContext context, void Function() action) {
  //       return closedWidget!;
  //     },
  //     openBuilder:
  //         (BuildContext context, void Function({Object? returnValue}) action) {
  //       return openedWidget!;
  //     },
  //   );
  // }

  static Widget fillButton(context,
      {Color? color, String? text, VoidCallback? onPressed}) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(110.w, 48.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
      child: Center(
        child: Text(
          text ?? '',
          maxLines: 1,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: color == Theme.of(context).colorScheme.secondary
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              fontSize: 14.sp),
        ),
      ),
    );
  }
}
