part of 'connection_cubit.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState.initial() = ConnectionInitial;
  const factory ConnectionState.online() = ConnectionOnline;
  const factory ConnectionState.offline() = ConnectionOffline;
}
