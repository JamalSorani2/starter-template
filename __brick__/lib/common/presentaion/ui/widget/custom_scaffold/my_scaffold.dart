import '../../../../imports/imports.dart';

class MyScaffold<B extends BlocBase<S>, S, M> extends StatefulWidget {
  const MyScaffold({
    super.key,
    required this.title,
    required this.resultParam,
    this.footerWidget,
    this.enableScroll = true,
  });

  final String title;
  final ResultParam<B, S, M> resultParam;
  final Widget? footerWidget;
  final bool enableScroll;

  @override
  State<MyScaffold<B, S, M>> createState() => _MyScaffoldState<B, S, M>();
}

class _MyScaffoldState<B extends BlocBase<S>, S, M>
    extends State<MyScaffold<B, S, M>> {
  @override
  void initState() {
    super.initState();

    /// Trigger initial load after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.resultParam.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(title: widget.title),
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.resultParam.onRefresh,
              child: SingleChildScrollView(
                physics: widget.enableScroll
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: BlocProvider<B>.value(
                  value: widget.resultParam.bloc,
                  child: BlocBuilder<B, S>(
                    builder: (context, state) {
                      return ResultBuilder<M>(
                        result: widget.resultParam.result(state),
                        onError: widget.resultParam.onRefresh,
                        success: widget.resultParam.bodyBuilder,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          widget.footerWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}


//! Example
/*
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final _bloc = getIt<CopyTradeBloc>();
  final _scrollProvider = getIt<InfinityScrollProvider>();
  Future<void> _refresh() async {
    _bloc.add(
      GetLeaderboardCopyTradeEvent(
        getLeaderboardCopyTradeParam: GetLeaderboardCopyTradeParam(
          pageNumber: 0,
          isAsc: false,
          sortProperty: LeaderboardSortProperty.feePlanFee,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold<CopyTradeBloc, CopyTradeState, LeaderBoardModel>(
      title: AppString.leaderboard,
      resultParam: ResultParam(
        onRefresh: _refresh,
        bloc: _bloc,
        result: (state) => state.getLeaderboardCopyTradeState,
        bodyBuilder: (data) {
          return InfinityScrollWidget(
            refresh: _refresh,
            totalItemsCount: data.totalDataCount,
            items: data.leaders,
            cardBuilder: (item, isLastItem) {
              return LeaderboardAccountCard(
                model: item,
                onTap: () {},
                onFollow: () {},
              );
            },
            scrollProvider: _scrollProvider,
          );
        },
      ),
    );
  }
}

*/