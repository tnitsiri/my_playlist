// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaylistStore on PlaylistStoreBase, Store {
  late final _$fetchListTokenAtom =
      Atom(name: 'PlaylistStoreBase.fetchListToken', context: context);

  @override
  String? get fetchListToken {
    _$fetchListTokenAtom.reportRead();
    return super.fetchListToken;
  }

  @override
  set fetchListToken(String? value) {
    _$fetchListTokenAtom.reportWrite(value, super.fetchListToken, () {
      super.fetchListToken = value;
    });
  }

  late final _$PlaylistStoreBaseActionController =
      ActionController(name: 'PlaylistStoreBase', context: context);

  @override
  void fetchList() {
    final _$actionInfo = _$PlaylistStoreBaseActionController.startAction(
        name: 'PlaylistStoreBase.fetchList');
    try {
      return super.fetchList();
    } finally {
      _$PlaylistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchListToken: ${fetchListToken}
    ''';
  }
}
