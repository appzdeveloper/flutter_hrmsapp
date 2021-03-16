// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlobalStore on _GlobalStore, Store {
  final _$dashboardDataAtom = Atom(name: '_GlobalStore.dashboardData');

  @override
  DashboardModel get dashboardData {
    _$dashboardDataAtom.context.enforceReadPolicy(_$dashboardDataAtom);
    _$dashboardDataAtom.reportObserved();
    return super.dashboardData;
  }

  @override
  set dashboardData(DashboardModel value) {
    _$dashboardDataAtom.context.conditionallyRunInAction(() {
      super.dashboardData = value;
      _$dashboardDataAtom.reportChanged();
    }, _$dashboardDataAtom, name: '${_$dashboardDataAtom.name}_set');
  }

  final _$chatDataAtom = Atom(name: '_GlobalStore.chatData');

  @override
  ChatModel get chatData {
    _$chatDataAtom.context.enforceReadPolicy(_$chatDataAtom);
    _$chatDataAtom.reportObserved();
    return super.chatData;
  }

  @override
  set chatData(ChatModel value) {
    _$chatDataAtom.context.conditionallyRunInAction(() {
      super.chatData = value;
      _$chatDataAtom.reportChanged();
    }, _$chatDataAtom, name: '${_$chatDataAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_GlobalStore.success');

  @override
  bool get success {
    _$successAtom.context.enforceReadPolicy(_$successAtom);
    _$successAtom.reportObserved();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.context.conditionallyRunInAction(() {
      super.success = value;
      _$successAtom.reportChanged();
    }, _$successAtom, name: '${_$successAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_GlobalStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$getDashboardAsyncAction = AsyncAction('getDashboard');

  @override
  Future<dynamic> getDashboard() {
    return _$getDashboardAsyncAction.run(() => super.getDashboard());
  }

  final _$getConversationAsyncAction = AsyncAction('getConversation');

  @override
  Future<dynamic> getConversation() {
    return _$getConversationAsyncAction.run(() => super.getConversation());
  }
}
