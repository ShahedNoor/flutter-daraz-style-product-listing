import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../gen/assets.gen.dart';

Widget loadingIndicatorCircle({
  required BuildContext context,
  Color? color,
  double? size,
}) {
  return const CustomLoader();
}

Widget shimmer({
  String? name,
  required BuildContext context,
  Color? color,
  double? size,
}) {
  return Center(
    child: Container(
      child: Lottie.asset(name ?? Assets.lottie.imageShimmer,
          width: size, height: size),
    ),
  );
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: DotLottieLoader.fromAsset(
          Assets.lottie.loader,
          frameBuilder: (context, dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
