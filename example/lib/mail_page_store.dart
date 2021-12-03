import 'package:empty_placeholder_view/emptylistplaceholderview.dart';
import 'package:example/mail_page.dart';
import 'package:example/values/strings.dart';
import 'package:mobx/mobx.dart';
import 'mail_page_store.g.dart';

class MailPageStore = _MailPageStoreBase with _$MailPageStore;

abstract class _MailPageStoreBase with Store {
  @observable
  ApiState state = ApiState.loading;

  @observable
  String? serverError;

  Observable<ObservableList<Mail>> mailsObservable =
      Observable(ObservableList.of([]));

  @computed
  ObservableList<Mail> get mailsList => mailsObservable.value;

  @action
  Future<void> fetchMailData() async {
    state = ApiState.loading;
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      _addData();
      state = ApiState.success;
    } catch (error, stacktrace) {
      serverError = AppStrings.errorSubTitle;
      state = ApiState.error;
    }
  }

  void _addData() {
    mailsList.addAll(
      [
        Mail(
          sender: 'Medium',
          sub: 'Showcase View',
          msg: 'Check new showcase View',
          date: '25 May',
          isUnread: false,
        ),
        Mail(
          sender: 'Quora',
          sub: 'New Question for you',
          msg: 'Hi, There is new question for you',
          date: '22 May',
          isUnread: false,
        ),
        Mail(
          sender: 'Google',
          sub: 'Flutter 1.5',
          msg: 'We have launched Flutter 1.5',
          date: '20 May',
          isUnread: true,
        ),
        Mail(
          sender: 'Github',
          sub: 'Showcase View',
          msg: 'New star on your showcase view.',
          date: '21 May ',
          isUnread: false,
        ),
        Mail(
          sender: 'Simform',
          sub: 'Credit card Plugin',
          msg: 'Check out our credit card plugin',
          date: '19 May',
          isUnread: true,
        ),
      ],
    );
  }
}
