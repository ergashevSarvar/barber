part of 'lang_bloc.dart';

@immutable
sealed class LangEvent extends Equatable{
  const LangEvent();

  @override
  List<Object> get props => [];
}


class LangRequest extends LangEvent{

}

class ChangeLangRequest extends LangEvent {
  final Map<String, dynamic> language;
  const ChangeLangRequest(this.language);

  @override
  List<Object> get props => [language];
}