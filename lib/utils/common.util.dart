// ANCHOR Opacity To Alpha Util
int opacityToAlphaUtil(
  double opacity,
) {
  assert(
    opacity >= 0 && opacity <= 1,
  );

  double value = opacity * 255;
  int alpha = value.round();

  return alpha;
}
