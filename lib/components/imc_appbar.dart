import 'package:flutter/material.dart';

import 'imc_title.dart';

class IMCAppBar extends AppBar {
  IMCAppBar({
    super.key,
    required String title,
    super.leading,
    super.automaticallyImplyLeading,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.scrolledUnderElevation,
    super.notificationPredicate,
    super.shadowColor,
    super.surfaceTintColor,
    super.shape,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary,
    super.centerTitle,
    super.excludeHeaderSemantics,
    super.titleSpacing,
    super.toolbarOpacity,
    super.bottomOpacity,
    super.toolbarHeight = 100.0,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency = true,
    super.clipBehavior,
  }) : super(title: IMCTitle(text: title));
}
