import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_base_flutter/ui/dimens.dart';

class TestBaseIcons {
  static get practice => SvgPicture.asset(
        'assets/icons/practice.svg',
        width: Dimens.lg,
        height: Dimens.lg,
      );

  static get dictionary => SvgPicture.asset(
        'assets/icons/dictionary.svg',
        width: Dimens.lg,
        height: Dimens.lg,
      );

  static get arrowBack => SvgPicture.asset(
        'assets/icons/arrow_back.svg',
      );

  static get arrowListChoose => SvgPicture.asset(
        'assets/icons/arrow_list_choose.svg',
      );

  static get clear => SvgPicture.asset(
    'assets/icons/clear.svg',
    width: Dimens.lg,
    height: Dimens.lg,
  );

  static get search => SvgPicture.asset(
    'assets/icons/search.svg',
    width: Dimens.lg,
    height: Dimens.lg,
  );
}
