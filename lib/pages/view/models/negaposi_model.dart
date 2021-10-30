class NegaposiRes {
  final String res;
  final String imageUrl_1;
  final String imageUrl_2;
  final double score_1;
  final double score_2;
  final List<dynamic> sentence_1;
  final List<dynamic> sentence_2;
  final List<dynamic> siteUrl_1;
  final List<dynamic> siteUrl_2;

  NegaposiRes({
      required this.res,
      required this.imageUrl_1,
      required this.imageUrl_2,
      required this.score_1,
      required this.score_2,
      required this.sentence_1,
      required this.sentence_2,
      required this.siteUrl_1,
      required this.siteUrl_2,
      });

  factory NegaposiRes.fromJson(Map<String, dynamic> json) {
    return NegaposiRes(
        res: json['res'],
        imageUrl_1: json['image_url_1'],
        imageUrl_2: json['image_url_2'],
        score_1: json['score_1'],
        score_2: json['score_2'],
        sentence_1: json['sentence_1'],
        sentence_2: json['sentence_2'],
        siteUrl_1: json['site_url_1'],
        siteUrl_2: json['site_url_2'],
        );
  }
}