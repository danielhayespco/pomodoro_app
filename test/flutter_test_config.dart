import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  goldenFileComparator = LocalFileComparator(
      Uri.parse('file://${Directory.current.path}/test/goldens'));
}
