import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/utils/common.util.dart';
import 'package:unfocuser/unfocuser.dart';

// ANCHOR Root
class Root extends StatefulWidget {
  final Widget? child;

  // ANCHOR Constructor
  const Root({
    super.key,
    required this.child,
  });

  // ANCHOR Create State
  @override
  State<Root> createState() {
    return _RootState();
  }
}

// ANCHOR Root State
class _RootState extends State<Root> {
  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Unfocuser(
      child: Stack(
        children: [
          widget.child ?? Container(),
          BlocBuilder<DoingCubit, bool>(
            builder: (
              BuildContext context,
              bool isLoading,
            ) {
              if (isLoading) {
                return Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withAlpha(
                        opacityToAlphaUtil(
                          0.4,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
