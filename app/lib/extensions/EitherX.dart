import 'package:either_option/either_option.dart';

extension EitherX<K, V> on Either<K, V> {
  Right<K, V> get asRight => this as Right<K, V>;
  Left<K, V> get asLeft => this as Left<K, V>;
}
