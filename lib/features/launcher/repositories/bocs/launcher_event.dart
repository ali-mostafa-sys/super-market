part of 'launcher_bloc.dart';

abstract class LauncherEvent extends Equatable {
  const LauncherEvent();
  @override
  List<Object> get props => [];
}


class LauncherPageEvent extends LauncherEvent{}
