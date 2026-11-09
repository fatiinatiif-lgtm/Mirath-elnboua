import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() => runApp(const MirathApp());

const burgundy = Color(0xFF681B32);
const gold = Color(0xFFE4B83F);

class Book {
  final String title;
  final String asset;
  const Book(this.title, this.asset);
}

const creedBooks = <Book>[
  Book('منظومة عقيدة العوام للشيخ أحمد المرزوقي المكي', 'assets/books/منظومة_عقيدة_العوام_للشيخ_أحمد_المرزوقي_المكي_.pdf'),
  Book('متن الخريدة البهية', 'assets/books/متن الخريدة البهية.pdf'),
  Book('منظومة جوهرة التوحيد للإمام برهان الدين إبراهيم اللقاني', 'assets/books/منظومة_جوهرة_التوحيد_للإمام_برهان_الدين_إبراهيم_اللقاني_.pdf'),
  Book('قصيدة بدء الأمالي للشيخ علي بن عثمان الأوشي', 'assets/books/قصيدة_بدء_الأمالي_للشيخ_علي_بن_عثمان_الأوشي.pdf'),
  Book('منظومة إضاءة الدجنة في اعتقاد أهل السنة للعلامة أحمد المقري المغربي', 'assets/books/منظومة_إضاءة_الدجنة_في_اعتقاد_أهل_السنة_للعلامة_أحمد_المقري_المغربي.pdf'),
  Book('متن قواعد العقائد للإمام أبي حامد الغزالي', 'assets/books/متن_قواعد_العقائد_للإمام_أبي_حامد_الغزالي_.pdf'),
  Book('متن صغرى الصغرى للإمام أبي عبد الله محمد بن يوسف السنوسي', 'assets/books/متن_صغرى_الصغرى_للإمام_أبي_عبدالله_محمد_بن_يوسف_السنوسي_.pdf'),
  Book('العقيدة الصغرى أم البراهين للإمام أبي عبد الله محمد بن يوسف السنوسي', 'assets/books/العقيدة_الصغرى_أم_البراهين_للإمام_أبي_عبدالله_محمد_بن_يوسف_السنوسي.pdf'),
  Book('العقيدة_الطحاوية_للإمام_أحمد_بن_محمد_الطحاوي_', 'assets/books/العقيدة_الطحاوية_للإمام_أحمد_بن_محمد_الطحاوي_.pdf'),
  Book('العقيدة_الكبرى_للإمام_أبي_عبدالله_محمد_بن_يوسف_السنوسي', 'assets/books/العقيدة_الكبرى_للإمام_أبي_عبدالله_محمد_بن_يوسف_السنوسي.pdf'),
  Book('دروس_التوحيد_للعلامة_محمد_بن_أحمد_الشاطري_', 'assets/books/دروس_التوحيد_للعلامة_محمد_بن_أحمد_الشاطري_.pdf'),
  Book('رسالة_في_علم_التوحيد_للعلامة_إبراهيم_بن_محمد_الباجوري', 'assets/books/رسالة_في_علم_التوحيد_للعلامة_إبراهيم_بن_محمد_الباجوري.pdf'),
  Book('عقيدة_السلطان_محمد_الفاتح_جواهر_العقائد_للعلامة_المولى_خضر_بك_بن', 'assets/books/عقيدة_السلطان_محمد_الفاتح_جواهر_العقائد_للعلامة_المولى_خضر_بك_بن.pdf'),
];

class MirathApp extends StatefulWidget {
  const MirathApp({super.key});
  @override
  State<MirathApp> createState() => _MirathAppState();
}

class _MirathAppState extends State<MirathApp> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: burgundy,
      brightness: dark ? Brightness.dark : Brightness.light,
      primary: burgundy,
      secondary: gold,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ميراث النبوة',
      theme: ThemeData(colorScheme: scheme, useMaterial3: true, scaffoldBackgroundColor: dark ? const Color(0xFF171417) : const Color(0xFFFFFCF3), appBarTheme: const AppBarTheme(centerTitle: true)),
      home: SplashScreen(onDone: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainShell(dark: dark, onThemeChanged: (v) => setState(() => dark = v))))),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SplashScreen({super.key, required this.onDone});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () { if (mounted) widget.onDone(); });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: burgundy,
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.auto_stories_rounded, color: gold, size: 66),
      const SizedBox(height: 20),
      const Text('ميراث', style: TextStyle(color: gold, fontSize: 42, fontWeight: FontWeight.bold)),
      const Text('النبوة', style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w600)),
      const SizedBox(height: 28),
      Container(width: 90, height: 2, color: gold),
    ])),
  );
}

class MainShell extends StatefulWidget {
  final bool dark;
  final ValueChanged<bool> onThemeChanged;
  const MainShell({super.key, required this.dark, required this.onThemeChanged});
  @override
  State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int tab = 0;
  final search = TextEditingController();
  final quotes = const [
    'من سلك طريقًا يلتمس فيه علمًا سهّل الله له به طريقًا إلى الجنة.',
    'العلم ميراث الأنبياء، فطوبى لمن أخذ منه بسهم.',
    'اطلب العلم من المهد إلى اللحد.',
  ];
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onOpenLibrary: () => setState(() => tab = 1), onSearch: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())), quotes: quotes),
      const LibraryPage(),
      MorePage(dark: widget.dark, onThemeChanged: widget.onThemeChanged),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ميراث النبوة'), backgroundColor: Theme.of(context).colorScheme.surface),
        body: IndexedStack(index: tab, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'ميراث النبوة'),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onOpenLibrary;
  final VoidCallback onSearch;
  final List<String> quotes;
  const HomePage({super.key, required this.onOpenLibrary, required this.onSearch, required this.quotes});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    TextField(
      readOnly: true,
      onTap: onSearch,
      decoration: InputDecoration(hintText: 'ابحث عن كتاب أو قسم...', prefixIcon: const Icon(Icons.search), filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
    ),
    const SizedBox(height: 22),
    Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [burgundy, Color(0xFF8B344B)]), borderRadius: BorderRadius.circular(20)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.lightbulb_outline, color: gold, size: 32),
        SizedBox(height: 12),
        Text('رحلتك في طلب العلم', style: TextStyle(color: gold, fontSize: 21, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('اقرأ، وتعلّم، واجعل العلم نورًا يهدي خطاك.', style: TextStyle(color: Colors.white, fontSize: 16)),
      ]),
    ),
    const SizedBox(height: 20),
    const Text('من عبارات أهل العلم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    ...quotes.map((q) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(q, style: const TextStyle(height: 1.6))))),
    const SizedBox(height: 12),
    FilledButton.icon(onPressed: onOpenLibrary, icon: const Icon(Icons.library_books), label: const Text('تصفح المكتبة')),
  ]);
}


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final results = creedBooks.where((b) => b.title.contains(query.trim())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('البحث في المكتبة')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            autofocus: true,
            onChanged: (v) => setState(() => query = v),
            decoration: InputDecoration(
              hintText: 'اكتب اسم الكتاب...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty ? null : IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => query = '')),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        Expanded(child: results.isEmpty
          ? const Center(child: Text('لا توجد نتائج مطابقة.'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.menu_book, color: burgundy),
                title: Text(results[i].title),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PdfReaderPage(book: results[i]))),
              ),
            )),
      ]),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  static const categories = <String, List<String>>{
    'العقيدة': ['المتون', 'الشروح'],
    'الفقه الشافعي': ['المتون', 'الشروح'],
    'أصول الفقه': ['المتون', 'الشروح'],
    'المنطق': ['المتون', 'الشروح'],
    'اللغة العربية': ['النحو', 'العروض', 'البلاغة', 'الأدب'],
    'علوم القرآن': [],
  };
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Padding(padding: EdgeInsets.all(8), child: Text('أقسام المكتبة', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
      ...categories.entries.map((entry) => Card(
        child: ExpansionTile(
          leading: const Icon(Icons.folder_open, color: burgundy),
          title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
          children: entry.value.map((sub) => ListTile(
            title: Text(sub),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {
              if (entry.key == 'العقيدة' && sub == 'المتون') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BookListPage()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => EmptyCategoryPage(title: '${entry.key} - $sub')));
              }
            },
          )).toList(),
          onExpansionChanged: (_) {},
        ),
      )),
    ],
  );
}

class EmptyCategoryPage extends StatelessWidget {
  final String title;
  const EmptyCategoryPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: const Center(child: Text('سيُضاف المحتوى إلى هذا القسم لاحقًا.')));
}

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('العقيدة - المتون')),
    body: ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: creedBooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const CircleAvatar(backgroundColor: Color(0xFFFFF0C2), child: Icon(Icons.menu_book, color: burgundy)),
          title: Text(creedBooks[i].title, style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: const Icon(Icons.chevron_left),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PdfReaderPage(book: creedBooks[i]))),
        ),
      ),
    ),
  );
}

class PdfReaderPage extends StatefulWidget {
  final Book book;
  const PdfReaderPage({super.key, required this.book});
  @override
  State<PdfReaderPage> createState() => _PdfReaderPageState();
}
class _PdfReaderPageState extends State<PdfReaderPage> {
  late final PdfController controller;
  int page = 1;
  int total = 0;
  @override
  void initState() {
    super.initState();
    // يفتح المستند من الأصول المحلية دون اتصال، ويحمّل الصفحات عند الحاجة.
    controller = PdfController(document: PdfDocument.openAsset(widget.book.asset), initialPage: 1);
  }
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.book.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
    body: Column(children: [
      Expanded(child: PdfView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        onDocumentLoaded: (doc) => setState(() => total = doc.pagesCount),
        onPageChanged: (p) => setState(() => page = p),
        builders: PdfViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
          pageErrorBuilder: (_, error) => Center(child: Text('تعذر عرض الصفحة: $error')),
        ),
      )),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        color: Theme.of(context).colorScheme.surface,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(onPressed: page > 1 ? () => controller.previousPage(duration: const Duration(milliseconds: 180), curve: Curves.easeOut) : null, icon: const Icon(Icons.arrow_forward_ios)),
          Text(total == 0 ? '...' : '$page / $total', style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(onPressed: total > 0 && page < total ? () => controller.nextPage(duration: const Duration(milliseconds: 180), curve: Curves.easeOut) : null, icon: const Icon(Icons.arrow_back_ios)),
        ]),
      ),
    ]),
  );
}

class MorePage extends StatelessWidget {
  final bool dark;
  final ValueChanged<bool> onThemeChanged;
  const MorePage({super.key, required this.dark, required this.onThemeChanged});
  @override
  Widget build(BuildContext context) => ListView(children: [
    SwitchListTile(
      secondary: const Icon(Icons.dark_mode_outlined),
      title: const Text('الوضع الداكن'),
      value: dark,
      onChanged: onThemeChanged,
    ),
    const ListTile(leading: Icon(Icons.info_outline), title: Text('عن التطبيق'), subtitle: Text('ميراث النبوة — مكتبة علمية للقراءة دون اتصال بالإنترنت.')),
    const ListTile(leading: Icon(Icons.library_books_outlined), title: Text('إصدار التطبيق'), subtitle: Text('1.0.0')),
  ]);
}
