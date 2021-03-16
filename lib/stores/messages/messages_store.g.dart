// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesStore on _MessagesStore, Store {
  final _$messagesListAtom = Atom(name: '_MessagesStore.messagesList');

  @override
  MessageModel get messagesList {
    _$messagesListAtom.context.enforceReadPolicy(_$messagesListAtom);
    _$messagesListAtom.reportObserved();
    return super.messagesList;
  }

  @override
  set messagesList(MessageModel value) {
    _$messagesListAtom.context.conditionallyRunInAction(() {
      super.messagesList = value;
      _$messagesListAtom.reportChanged();
    }, _$messagesListAtom, name: '${_$messagesListAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_MessagesStore.success');

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

  final _$loadingAtom = Atom(name: '_MessagesStore.loading');

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

  final _$getMessagesAsyncAction = AsyncAction('getMessages');

  @override
  Future<dynamic> getMessages() {
    return _$getMessagesAsyncAction.run(() => super.getMessages());
  }
}
