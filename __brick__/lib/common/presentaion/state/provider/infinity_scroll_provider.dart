import '../../../imports/imports.dart';

class InfinityScrollProvider extends ChangeNotifier {
  //! Variables=================================================
  int _pageNumber = KPageNumber;
  bool _isLoadingMore = false;

  //! Getters=================================================
  int get pageNumber => _pageNumber;
  bool get isLoadingMore => _isLoadingMore;

  //! Setters=================================================
  void setPageNumber({required int pageNumber, bool notify = true}) {
    _pageNumber = pageNumber;
    _isLoadingMore = (_pageNumber > KPageNumber);
    if (notify) {
      notifyListeners();
    }
  }

  void finishLoadingMore() {
    _isLoadingMore = false;
    notifyListeners();
  }

  //! Initializers==============================================
  void resetToDefault() {
    _pageNumber = KPageNumber;
    _isLoadingMore = false;
  }
}
