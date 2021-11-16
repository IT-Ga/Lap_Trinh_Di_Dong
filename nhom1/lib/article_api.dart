
import 'package:nhom1/article.dart';
abstract class ArticleApi {
  Future<List<Article>> getListArticles(String topic);
}