part of '../../tafsir.dart';

extension FontSizeExtension on Widget {
  Widget fontSizeDropDown({
    double? height,
    Color? color,
    bool isDark = false,
    TafsirStyle? tafsirStyle,
  }) {
    final box = GetStorage();
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      icon: tafsirStyle?.fontSizeIconWidget ??
          Semantics(
            button: true,
            enabled: true,
            label: tafsirStyle?.fontSizeSemanticsLabel ?? 'Change Font Size',
            child: Icon(
              Icons.text_format_outlined,
              size: 34,
              color: tafsirStyle?.fontSizeIconColor ?? Color(0xFFC8A24A),
            ),
          ),
      color: tafsirStyle?.fontSizeBackgroundColor,
      iconSize: tafsirStyle?.fontSizeIconSize,
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 30,
          child: Obx(
            () => SizedBox(
              height: 30,
              width: MediaQuery.sizeOf(context).width,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: tafsirStyle?.fontSizeThumbColor,
                  activeTrackColor: tafsirStyle?.fontSizeActiveTrackColor,
                  inactiveTrackColor: tafsirStyle?.fontSizeInactiveTrackColor,
                  overlayColor: Colors.white.withValues(alpha: 0.2),
                  valueIndicatorColor: Colors.white,
                  inactiveTickMarkColor: Colors.transparent,
                  activeTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                  value: TafsirCtrl.instance.fontSizeArabic.value,
                  max: 50,
                  min: 20,
                  onChanged: (value) {
                    TafsirCtrl.instance.fontSizeArabic.value = value;

                    box.write(_StorageConstants().fontSize, value);
                    TafsirCtrl.instance.update(['change_font_size']);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
