import 'package:hive/hive.dart';
part 'turnover_model.g.dart';

@HiveType(typeId: 0)
class Turnover {
  @HiveField(0)
  String title;
  @HiveField(1)
  double amount;
  @HiveField(2)
  bool deposit;
  @HiveField(3)
  String category;
  @HiveField(4)
  String description;
  Turnover({
    required this.title,
    required this.amount,
    required this.deposit,
    required this.category,
    required this.description,
  });
  static List<String> depositCategories = [
    'حقوق و دستمزد',
    'دریافت سود',
    'پول تو جیبی',
    'موجودی اولیه',
  ];
  static List<String> spendCategories = [
    'خرید روزانه',
    'کافه و رستوران',
    'رفت و آمد',
    'شارژ و قبض',
    'مد و پوشاک',
    'تفریح و سرگرمی',
    'پس انداز',
    'خیریه'
  ];
}
