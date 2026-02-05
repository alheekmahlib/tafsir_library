part of '../tafsir.dart';
// ملاحظة هامة: يجب تضمين هذا الودجت ضمن Scaffold عند الاستدعاء حتى لا تظهر مشكلة "No Scaffold widget found"
// Important: This widget must be shown inside a Scaffold to avoid "No Scaffold widget found" error.

// مثال للاستخدام الصحيح:
// Example for correct usage:
// showModalBottomSheet(
//   context: context,
//   builder: (_) => Scaffold(body: ShowTafseer(...)),
// );

class ShowTafsir extends StatelessWidget {
  late final int ayahUQNumber;
  final int pageIndex;
  final BuildContext context;
  final int ayahNumber;
  final int surahNumber;
  final bool isDark;
  final TafsirStyle? tafsirStyle;

  ShowTafsir({
    super.key,
    required this.ayahUQNumber,
    required this.ayahNumber,
    required this.pageIndex,
    required this.context,
    required this.isDark,
    this.tafsirStyle,
    required this.surahNumber,
  });

  final tafsirCtrl = TafsirCtrl.instance;
  final tajweedCtrl = TajweedAyaCtrl.instance;

  @override
  Widget build(BuildContext context) {
    // حلّ النمط: استخدام الممرّر ثم Theme ثم الافتراضي
    final TafsirStyle s =
        tafsirStyle ?? (TafsirStyle.defaults(isDark: isDark, context: context));
    // شرح: نتأكد أن عناصر tafsirStyle غير فارغة لتجنب الخطأ
    // Explanation: Ensure tafsirStyle widgets are not null to avoid null check errors
    final double deviceHeight = MediaQuery.maybeOf(context)?.size.height ?? 600;
    final double deviceWidth = MediaQuery.maybeOf(context)?.size.width ?? 400;
    final double sheetHeight = s.heightOfBottomSheet ?? (deviceHeight * 0.9);
    final double sheetWidth = s.widthOfBottomSheet ?? deviceWidth;
    final Color surfaceColor = s.backgroundColor ??
        (isDark ? const Color(0xff1E1E1E) : const Color(0xffFAF6F0));
    final Color cardColor = s.controlsBackgroundColor ??
        (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFFFFFFF));
    final Color accentColor = s.accentColor ??
        (isDark ? const Color(0xFFD6B46A) : const Color(0xFFC8A24A));
    final Color borderSoft = s.controlsBorderColor ??
        (isDark ? Colors.white12 : const Color(0xFFEDE4D6));
    // تحسين الشكل: إضافة شريط علوي أنيق مع زر إغلاق واسم التفسير
    // UI Enhancement: Add a modern top bar with close button and tafsir name
    // final stored = GetStorage()
    //         .read<List<dynamic>>(quran._StorageConstants().loadedFontPages)
    //         ?.cast<int>() ??
    //     const <int>[];
    return GetBuilder<TafsirCtrl>(
      id: 'actualTafsirContent',
      builder: (tafsirCtrl) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: Container(
              height: sheetHeight,
              width: sheetWidth,
              padding: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: surfaceColor,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  _TopWidget(
                    s: s,
                    accentColor: accentColor,
                    surahNumber: surahNumber,
                    ayahNumber: ayahNumber,
                  ),
                  const SizedBox(height: 10),
                  _TapBarWidget(s: s, accentColor: accentColor, isDark: isDark),
                  const SizedBox(height: 8),
                  _TabBarViewWidget(
                    cardColor: cardColor,
                    borderSoft: borderSoft,
                    s: s,
                    isDark: isDark,
                    pageIndex: pageIndex,
                    accentColor: accentColor,
                    ayahUQNumber: ayahUQNumber,
                    ayahNumber: ayahNumber,
                    surahNumber: surahNumber,
                    tajweedCtrl: tajweedCtrl,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TabBarViewWidget extends StatelessWidget {
  const _TabBarViewWidget({
    required this.cardColor,
    required this.borderSoft,
    required this.s,
    required this.isDark,
    required this.pageIndex,
    required this.accentColor,
    required this.ayahUQNumber,
    required this.ayahNumber,
    required this.surahNumber,
    required this.tajweedCtrl,
  });

  final Color cardColor;
  final Color borderSoft;
  final TafsirStyle s;
  final bool isDark;
  final int pageIndex;
  final Color accentColor;
  final int ayahUQNumber;
  final int ayahNumber;
  final int surahNumber;
  final TajweedAyaCtrl tajweedCtrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderSoft),
                      ),
                      child: ChangeTafsirDialog(
                        tafsirStyle: s,
                        isDark: isDark,
                        pageNumber: pageIndex + 1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        s.fontSizeWidget ??
                            fontSizeDropDown(
                              height: 30.0,
                              tafsirStyle: s,
                              isDark: isDark,
                            ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TafsirPagesBuild(
                  pageIndex: pageIndex,
                  ayahUQNumber: ayahUQNumber,
                  tafsirStyle: s,
                  isDark: isDark,
                  ayahNumber: ayahNumber,
                  surahNumber: surahNumber,
                ),
              ),
            ],
          ),
          _TajweedAyaTab(
            ayahUQNumber: ayahUQNumber,
            ayahNumber: ayahNumber,
            tajweedCtrl: tajweedCtrl,
            isDark: isDark,
            tafsirStyle: s,
            surahNumber: surahNumber,
          ),
        ],
      ),
    );
  }
}

class _TapBarWidget extends StatelessWidget {
  const _TapBarWidget({
    required this.s,
    required this.accentColor,
    required this.isDark,
  });

  final TafsirStyle s;
  final Color accentColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: s.tabBarBackgroundColor ?? accentColor.withValues(alpha: 0.1),
      child: TabBar(
        labelStyle: s.tabBarLabelStyle ??
            TextStyle(
              fontFamily: 'cairo',
              package: 'tafsir_library',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
        indicator: BoxDecoration(
          color: s.tabBarIndicatorColor ?? accentColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: s.tabBarLabelColor ?? Colors.white,
        unselectedLabelColor: s.tabBarUnselectedLabelColor ??
            (isDark ? Colors.white70 : Colors.black54),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        tabs: [
          Tab(text: s.tafsirName ?? 'التفسير'),
          Tab(text: s.tajweedName ?? 'أحكام التجويد'),
        ],
      ),
    );
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget({
    required this.s,
    required this.accentColor,
    required this.surahNumber,
    required this.ayahNumber,
  });

  final TafsirStyle s;
  final Color accentColor;
  final int surahNumber;
  final int ayahNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          if ((s.withBackButton ?? true) && s.backButtonWidget != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: s.backButtonWidget!,
            ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 5,
                  height: 90,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      Text(
                        '$surahNumber',
                        style: TextStyle(
                          color: accentColor,
                          fontFamily: 'surahName',
                          package: 'tafsir_library',
                          fontSize: 46,
                        ),
                      ),
                      Text(
                        '${s.ayahNameText} $ayahNumber',
                        style: TextStyle(
                          color: accentColor,
                          fontFamily: 'cairo',
                          package: 'tafsir_library',
                          fontSize: 18,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 5,
                  height: 90,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
