class Endpoints {
  static const String baseUrl = 'https://moviesapi.ir/api/v1';
  static const String movies = '/movies';
  static String movieById(int id) => '/movies/$id';
}
