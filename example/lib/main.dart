import 'package:flutter/material.dart';
import 'package:tafsir_library/tafsir_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TafsirLibrary.initialize();
  runApp(const TafsirExampleApp());
}

class TafsirExampleApp extends StatelessWidget {
  const TafsirExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFD6B46A),
        ),
        primaryColor: const Color(0xFFD6B46A),
        useMaterial3: false,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFD6B46A).withValues(alpha: 0.7),
          title: const Text('Tafsir Library Example'),
        ),
        body: const TafsirDirectExample(
          ayahUQNumber: 2,
          ayahNumber: 2,
          surahNumber: 1,
          pageIndex: 1,
        ),
        // body: const TafsirNotDirectExample(
        //   ayahUQNumber: 2,
        //   ayahNumber: 2,
        //   surahNumber: 1,
        // ),
      ),
    );
  }
}

class TafsirDirectExample extends StatelessWidget {
  final int ayahUQNumber;
  final int ayahNumber;
  final int surahNumber;
  final int pageIndex;
  const TafsirDirectExample(
      {super.key,
      required this.ayahUQNumber,
      required this.ayahNumber,
      required this.surahNumber,
      required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return ShowTafsir(
      context: context,
      ayahUQNumber: ayahUQNumber,
      ayahNumber: ayahNumber,
      pageIndex: pageIndex,
      isDark: false,
      surahNumber: surahNumber,
    );
  }
}

class TafsirNotDirectExample extends StatefulWidget {
  const TafsirNotDirectExample({
    super.key,
    required this.ayahUQNumber,
    required this.ayahNumber,
    required this.surahNumber,
  });

  final int ayahUQNumber;
  final int ayahNumber;
  final int surahNumber;

  @override
  State<TafsirNotDirectExample> createState() => _TafsirNotDirectExampleState();
}

class _TafsirNotDirectExampleState extends State<TafsirNotDirectExample> {
  late Future<List<TafsirTableData>> _tafsirFuture;

  @override
  void initState() {
    super.initState();
    _tafsirFuture = _loadTafsir();
  }

  Future<List<TafsirTableData>> _loadTafsir() async {
    await TafsirLibrary.initialize();
    if (TafsirLibrary.isTafsir) {
      await TafsirLibrary.fetchData();
    } else {
      await TafsirLibrary.fetchTranslate();
    }
    return TafsirLibrary.fetchTafsirAyah(widget.ayahUQNumber);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TafsirTableData>>(
      future: _tafsirFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final tafsirItems = snapshot.data ?? const <TafsirTableData>[];
        final s = TafsirStyle.defaults(isDark: false, context: context);
        final pageNumber =
            tafsirItems.isNotEmpty ? tafsirItems.first.pageNum : 1;
        final tafsirText = tafsirItems.isNotEmpty
            ? tafsirItems.first.tafsirText
            : 'تم اختيار الترجمة لهذا التفسير لا يظهر.';
        final translationText = TafsirLibrary.getTranslationText(
            widget.surahNumber, widget.ayahNumber);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEDE4D6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChangeTafsirDialog(
                    tafsirStyle: s,
                    isDark: false,
                    pageNumber: pageNumber,
                  ),
                  TafsirLibrary.fontSizeDropdown(
                    height: 30,
                    isDark: false,
                    tafsirStyle: s,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'التفسير',
              body: tafsirText,
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'الترجمة',
              body: translationText.isEmpty
                  ? 'تم اختيار التفسير لهذا الترجمة لا يظهر.'
                  : translationText,
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'حالة التحميل',
              body: 'Loading: ${TafsirLibrary.isLoading.value}',
            ),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE4D6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: body.toFlutterText(false),
              style: TextStyle(
                  fontSize: TafsirLibrary.fontSizeArabic.value,
                  height: 1.6,
                  color: Colors.black),
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
