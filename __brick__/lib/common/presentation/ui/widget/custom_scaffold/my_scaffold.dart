
import '../../../../imports/imports.dart';

class MyScaffold<B extends BlocBase<S>, S, M> extends StatefulWidget {
  const MyScaffold({
    super.key,
    required this.title,
    required this.resultParam,
    this.footerWidget,
    this.actions = const [],
    this.subtitleWidget,
    this.floatingActionButton,
    this.isRoot,
  });

  final String? title;
  final ResultParam<B, S, M> resultParam;
  final Widget? footerWidget;
  final List<Widget> actions;
  final Widget? subtitleWidget;
  final Widget? floatingActionButton;
  final bool? isRoot;

  @override
  State<MyScaffold<B, S, M>> createState() => _MyScaffoldState<B, S, M>();
}

class _MyScaffoldState<B extends BlocBase<S>, S, M>
    extends State<MyScaffold<B, S, M>> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.resultParam.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: widget.floatingActionButton,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            MyAppBar(
              title: widget.title!,
              actions: widget.actions,
              isRoot: widget.isRoot,
            ),
          if (widget.subtitleWidget != null)
            Padding(
              padding: REdgeInsets.only(
                left: AppDesign.horizontalPadding,
                right: AppDesign.horizontalPadding,
              ),
              child: widget.subtitleWidget,
            ),
          Expanded(
            child: _Refresh(
              onRefresh: widget.resultParam.onRefresh,
              child: BlocProvider<B>.value(
                value: widget.resultParam.bloc,
                child: BlocBuilder<B, S>(
                  builder: (context, state) {
                    if (widget.resultParam.result == null) {
                      return widget.resultParam.bodyBuilder(unit as M);
                    }
                    return ResultBuilder<M>(
                      result: widget.resultParam.result!(state),
                      onError: widget.resultParam.onRefresh,
                      success: widget.resultParam.bodyBuilder,
                    );
                  },
                ),
              ),
            ),
          ),
          widget.footerWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Refresh extends StatelessWidget {
  const _Refresh({required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: child,
      );
    }
    return child;
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
