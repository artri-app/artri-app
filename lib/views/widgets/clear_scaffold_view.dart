import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClearScaffoldView extends StatelessWidget {
  final Widget? child;
  final Widget? appBarTitle;
  final Widget? bottomSheet;

  const ClearScaffoldView({
    super.key,
    this.child,
    this.appBarTitle,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: appBarTitle,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () => context.canPop() ? context.pop() : context.go(''),
            style: ButtonStyle(
              side: WidgetStatePropertyAll(
                const BorderSide(color: AppColors.darkGreen, width: 2),
              ),
            ),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.darkGreen,
              size: 24,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child ?? Placeholder(),
        ),
      ),
      bottomSheet: bottomSheet,
    );
  }
}
