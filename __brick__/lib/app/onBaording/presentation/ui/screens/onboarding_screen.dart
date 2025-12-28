import "../../../../../common/imports/imports.dart";
import "../../state/page_index_provider.dart";
import "../widgets/indicator.dart";
import "../widgets/next_button.dart";
import "../widgets/onboarding_bg.dart";
import "../widgets/page_content.dart";
import "../widgets/skip_button.dart";

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final pageController = PageController();

  List<OnBoardingPageData> pages = [
    OnBoardingPageData(
      title: '',
      description1: '',
      description2: '',
      pic: '',
    ),
    OnBoardingPageData(
      title: '',
      description1: '',
      description2: '',
      pic: '',
    ),
    OnBoardingPageData(
      title: '',
      description1: '',
      description2: '',
      pic: '',
    ),
  ];

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    pageController.addListener(() {
      Provider.of<PageIndexProvider>(context, listen: false)
          .updatePageIndex((pageController.page ?? 0).toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        exit(0);
      },
      child: Scaffold(
        body: Stack(
          children: [
            const OnBoardingBackground(),
            Padding(
              padding: REdgeInsets.all(24),
              child: Column(
                children: [
                  const SkipButton(),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, i) {
                        return PageContent(
                          colorController: false,
                          page: pages[i],
                          pageIndex: i,
                        );
                      },
                      itemCount: pages.length,
                    ),
                  ),
                  Consumer<PageIndexProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OnBoardingIndicator(
                            pageIndex: value.pageIndex,
                          ),
                          NextButton(
                            onTap: () async {
                              if (value.pageIndex != 2) {
                                pageController.animateToPage(
                                  value.pageIndex + 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                await getIt<SharedPreferences>()
                                    .setBool(KOnboardingCompleted, true);
                                context.go(RoutesNames.login);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
