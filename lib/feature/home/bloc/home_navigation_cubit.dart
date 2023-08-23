import 'package:bloc/bloc.dart';
import 'package:greenmind/Utils.dart';

class PageState {
  PageIndex pageIndex;
  PageState({required this.pageIndex});
}

class HomeNavigationCubit extends Cubit<PageState> {
  HomeNavigationCubit() : super(PageState(pageIndex: PageIndex.HOME));

  onNavigate({required PageIndex pageIndex}) {
    print("new page $pageIndex");
    emit(PageState(pageIndex: pageIndex));
  }
}
