import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tafsir_library/src/tafsir.dart';

class TafsirLibrary {
  /// تهيئة المكتبة (التخزين + التفسير)
  /// Initialize the library (storage + tafsir)
  static Future<void> initialize() async {
    await GetStorage.init();
    await _initTafsir();
  }

  static Future<void> _initTafsir() async {
    return TafsirCtrl.instance.onInit();
  }

  /// التحكم الرئيسي ببيانات التفسير
  /// Main controller for tafsir data
  static TafsirCtrl get tafsirCtrl => TafsirCtrl.instance;

  /// التحكم ببيانات أحكام التجويد
  /// Controller for tajweed data
  static TajweedAyaCtrl get tajweedCtrl => TajweedAyaCtrl.instance;

  /// قائمة بيانات التفسير الحالية (Reactive)
  /// Current tafsir list (Reactive)
  static RxList<TafsirTableData> get tafseerList => tafsirCtrl.tafseerList;

  /// اسم قاعدة البيانات المختارة
  /// Selected database name
  static String? get selectedDBName => tafsirCtrl.selectedDBName;
  static set selectedDBName(String? value) => tafsirCtrl.selectedDBName = value;

  /// كود لغة الترجمة الحالية
  /// Current translation language code
  static String get translationLangCode => tafsirCtrl.translationLangCode;
  static set translationLangCode(String value) =>
      tafsirCtrl.translationLangCode = value;

  /// بداية فهرس الترجمات في قائمة المصادر
  /// Start index of translations in sources list
  static int get translationsStartIndex => tafsirCtrl.translationsStartIndex;

  /// قيمة الاختيار الحالية للتفسير/الترجمة (Reactive)
  /// Current selected index for tafsir/translation (Reactive)
  static RxInt get radioValue => tafsirCtrl.radioValue;

  /// قيمة الاختيار الحالية للتفسير/الترجمة (Reactive)
  /// Current selected index for tafsir/translation (Reactive)
  static bool get isTafsir => tafsirCtrl.selectedTafsir.isTafsir;

  /// حالة التحميل (Reactive)
  /// Downloading flag (Reactive)
  static RxBool get isDownloading => tafsirCtrl.isDownloading;

  /// حالة تنزيل جارٍ بالفعل (Reactive)
  /// Download in progress flag (Reactive)
  static RxBool get onDownloading => tafsirCtrl.onDownloading;

  /// مرحلة التهيئة قبل التحميل (Reactive)
  /// Preparing download flag (Reactive)
  static RxBool get isPreparingDownload => tafsirCtrl.isPreparingDownload;

  /// النص النصي لشريط التقدم (Reactive)
  /// Progress text (Reactive)
  static RxString get progressString => tafsirCtrl.progressString;

  /// قيمة شريط التقدم (Reactive)
  /// Progress value (Reactive)
  static RxDouble get progress => tafsirCtrl.progress;

  /// حجم خط العربية (Reactive)
  /// Arabic font size (Reactive)
  static RxDouble get fontSizeArabic => tafsirCtrl.fontSizeArabic;

  /// حالة توفر/تحميل التفاسير (Reactive)
  /// Tafsir download status (Reactive)
  static Rx<Map<int, bool>> get tafsirDownloadStatus =>
      tafsirCtrl.tafsirDownloadStatus;

  /// قائمة مؤشرات التفاسير المحمّلة (Reactive)
  /// Downloaded tafsir indices list (Reactive)
  static RxList<int> get tafsirDownloadIndexList =>
      tafsirCtrl.tafsirDownloadIndexList;

  /// قائمة الترجمات الحالية (Reactive)
  /// Current translations list (Reactive)
  static RxList<TranslationModel> get translationList =>
      tafsirCtrl.translationList;

  /// جميع مصادر التفسير والترجمة
  /// All tafsir/translation sources
  static List<TafsirNameModel> get tafsirAndTranslationsItems =>
      tafsirCtrl.tafsirAndTranslationsItems;

  /// حالة تحميل البيانات (Reactive)
  /// Data loading flag (Reactive)
  static RxBool get isLoading => tafsirCtrl.isLoading;

  /// التفسير الحالي المختار
  /// Currently selected tafsir
  static TafsirNameModel get selectedTafsir => tafsirCtrl.selectedTafsir;

  /// التفاسير فقط بدون ترجمات
  /// Tafsir sources without translations
  static List<TafsirNameModel> get tafsirWithoutTranslationItems =>
      tafsirCtrl.tafsirWithoutTranslationItems;

  /// الترجمات فقط بدون تفاسير
  /// Translation sources without tafsir
  static List<TafsirNameModel> get translationsWithoutTafsirItems =>
      tafsirCtrl.translationsWithoutTafsirItems;

  /// التفاسير والترجمات المخصصة
  /// Custom tafsir/translation sources
  static List<TafsirNameModel> get customTafsirAndTranslationsItems =>
      tafsirCtrl.customTafsirAndTranslationsItems;

  /// التفاسير المخصصة فقط
  /// Custom tafsir sources only
  static List<TafsirNameModel> get customTafsirWithoutTranslationsItems =>
      tafsirCtrl.customTafsirWithoutTranslationsItems;

  /// الترجمات المخصصة فقط
  /// Custom translation sources only
  static List<TafsirNameModel> get customTranslationsItems =>
      tafsirCtrl.customTranslationsItems;

  /// قائمة الإدخالات المخصصة (مع البيانات)
  /// Custom entries list (with data)
  static List<CustomTafsirEntry> get customTafsirEntries =>
      tafsirCtrl.customTafsirEntries;

  /// فحص إمكانية حذف عنصر
  /// Check if item is removable
  static bool getIsRemovableItem(int index) =>
      tafsirCtrl.getIsRemovableItem(index);

  /// جلب بيانات التفسير (تحميل كل البيانات)
  /// Fetch tafsir data (load all)
  static Future<void> fetchData() => tafsirCtrl.fetchData();

  /// جلب تفسير صفحة محددة
  /// Fetch tafsir for a specific page
  static Future<List<TafsirTableData>> fetchTafsirPage(int pageNum,
          {String? databaseName}) =>
      tafsirCtrl.fetchTafsirPage(pageNum, databaseName: databaseName);

  /// جلب تفسير آية محددة
  /// Fetch tafsir for a specific ayah
  static Future<List<TafsirTableData>> fetchTafsirAyah(int ayahUQNumber,
          {String? databaseName}) =>
      tafsirCtrl.fetchTafsirAyah(ayahUQNumber, databaseName: databaseName);

  /// الحصول على نص التفسير مباشرة من التفسير الحالي
  /// Get tafsir entry directly from the current Tafsir
  static TafsirTableData getTafsirFromCurrentTafsir(int ayahUQNumber) =>
      tafsirCtrl.tafseerList.firstWhere(
        (element) => element.id == ayahUQNumber,
        orElse: () => const TafsirTableData(
          id: 0,
          tafsirText: '',
          ayahNum: 0,
          pageNum: 0,
          surahNum: 0,
        ),
      );

  /// جلب الترجمة الحالية
  /// Fetch current translation
  static Future<void> fetchTranslate() => tafsirCtrl.fetchTranslate();

  /// الحصول على ترجمة آية محددة
  /// Get translation for a specific ayah
  static TranslationModel? getTranslationForAyah(int surah, int ayah) =>
      tafsirCtrl.getTranslationForAyah(surah, ayah);

  /// الحصول على ترجمة آية بناءً على نموذج الآية
  /// Get translation based on AyahModel indices
  static TranslationModel? getTranslationForAyahModel(
          int surahNumber, int ayahNumber, int ayahIndex) =>
      tafsirCtrl.getTranslationForAyahModel(surahNumber, ayahNumber, ayahIndex);

  /// الحصول على نص الترجمة
  /// Get translated text
  static String getTranslationText(int surah, int ayah) =>
      tafsirCtrl.getTranslationText(surah, ayah);

  /// الحصول على الحواشي الخاصة بآية
  /// Get footnotes for a specific ayah
  static Map<String, String> getFootnotesForAyah(int surah, int ayah) =>
      tafsirCtrl.getFootnotesForAyah(surah, ayah);

  /// الحصول على ترجمات صفحة كاملة
  /// Get translations for a full page
  static List<TranslationModel> getTranslationsForPage(int pageNumber) =>
      tafsirCtrl.getTranslationsForPage(pageNumber);

  /// تحميل تفسير/ترجمة من المصدر
  /// Download tafsir/translation source
  static Future<void> tafsirAndTranslationDownload(int index) =>
      tafsirCtrl.tafsirAndTranslationDownload(index);

  /// حذف تفسير/ترجمة محمّل
  /// Delete a downloaded tafsir/translation
  static Future<bool> deleteTafsirOrTranslation({required int itemIndex}) =>
      tafsirCtrl.deleteTafsirOrTranslation(itemIndex: itemIndex);

  /// إضافة تفاسير/ترجمات مخصصة
  /// Add custom tafsir/translation entries
  static Future<bool> addCustomTafsirEntries(List<CustomTafsirEntry> entries) =>
      tafsirCtrl.addCustomTafsirEntries(entries);

  /// حذف تفسير مخصص
  /// Remove custom tafsir
  static Future<void> removeCustomTafsir(TafsirNameModel model) =>
      tafsirCtrl.removeCustomTafsir(model);

  /// تغيير التفسير/الترجمة المختارة
  /// Change selected tafsir/translation
  static Future<void> handleRadioValueChanged(int val) =>
      tafsirCtrl.handleRadioValueChanged(val);

  /// حالة توفر بيانات التجويد (من المخزن المحلي)
  /// Whether tajweed data is available locally
  static bool get isTajweedAvailable => tajweedCtrl.isAvailable;

  /// مؤشر تهيئة تنزيل التجويد (Reactive)
  /// Tajweed preparing download flag (Reactive)
  static RxBool get tajweedIsPreparingDownload =>
      tajweedCtrl.isPreparingDownload;

  /// مؤشر تنزيل التجويد (Reactive)
  /// Tajweed downloading flag (Reactive)
  static RxBool get tajweedIsDownloading => tajweedCtrl.isDownloading;

  /// تقدم تنزيل التجويد (Reactive)
  /// Tajweed download progress (Reactive)
  static RxDouble get tajweedDownloadProgress => tajweedCtrl.downloadProgress;

  /// تنزيل بيانات التجويد
  /// Download tajweed data
  static Future<void> downloadTajweed() => tajweedCtrl.download();

  /// جلب معلومات التجويد لآية
  /// Get tajweed info for an ayah
  static Future<TajweedAyahInfo?> getTajweedAyahInfo({
    required int surahNumber,
    required int ayahNumber,
  }) =>
      tajweedCtrl.getAyahInfo(surahNumber: surahNumber, ayahNumber: ayahNumber);

  /// تهيئة بيانات التجويد لسورة كاملة
  /// Prewarm tajweed data for a full surah
  static Future<void> prewarmTajweedSurah(int surahNumber) =>
      tajweedCtrl.prewarmSurah(surahNumber);

  /// ويدجت تغيير التفسير (حوار الاختيار)
  /// Change tafsir dialog widget
  static Widget changeTafsirDialog({
    required TafsirStyle tafsirStyle,
    required bool isDark,
    required int pageNumber,
  }) =>
      ChangeTafsirDialog(
        tafsirStyle: tafsirStyle,
        isDark: isDark,
        pageNumber: pageNumber,
      );

  /// ويدجت تغيير حجم الخط
  /// Font size dropdown widget
  static Widget fontSizeDropdown({
    double? height,
    Color? color,
    bool isDark = false,
    TafsirStyle? tafsirStyle,
  }) =>
      const SizedBox().fontSizeDropDown(
        height: height,
        color: color,
        isDark: isDark,
        tafsirStyle: tafsirStyle,
      );

  /// ويدجت عرض التفسير (يفضل داخل Scaffold)
  /// Tafsir display widget (should be inside a Scaffold)
  static Widget showTafsir({
    Key? key,
    required int ayahUQNumber,
    required int ayahNumber,
    required int pageIndex,
    required BuildContext context,
    required bool isDark,
    required int surahNumber,
    TafsirStyle? tafsirStyle,
  }) =>
      ShowTafsir(
        key: key,
        ayahUQNumber: ayahUQNumber,
        ayahNumber: ayahNumber,
        pageIndex: pageIndex,
        context: context,
        isDark: isDark,
        tafsirStyle: tafsirStyle,
        surahNumber: surahNumber,
      );
}
