part of 'lang_bloc.dart';

@immutable
abstract class LangState extends Equatable {
  const LangState();

  @override
  List<Object> get props => [];
}

final class LangInitial extends LangState {}

final class LangSuccess extends LangState {
  final List<dynamic> lang;
  final int langId;

  const LangSuccess(this.lang, this.langId);

  @override
  List<Object> get props => [lang];
}

final class LangChanged extends LangState {
  final String lang;
  final int langId;

  const LangChanged(this.lang, this.langId);

  @override
  List<Object> get props => [lang, langId];
}

final class LangLoading extends LangState {}

final class LangFailure extends LangState {
  final String error;

  const LangFailure(this.error);

  @override
  List<Object> get props => [error];
}
