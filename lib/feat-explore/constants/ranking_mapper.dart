import 'package:audiory_v0/feat-explore/models/ranking.dart';

RankingType mapStringToRankingType(String? typeString) {
  switch (typeString) {
    case "author":
      return RankingType.author;
    case "reader":
      return RankingType.reader;
    default:
      return RankingType.story;
  }
}

RankingMetric mapStringToRankingMetric(String? metricString) {
  switch (metricString) {
    case "view":
      return RankingMetric.view;
    case "vote":
      return RankingMetric.vote;
    case "comment":
      return RankingMetric.comment;
    case "gift":
      return RankingMetric.gift;
    case "follower":
      return RankingMetric.follower;
    default:
      return RankingMetric.view;
  }
}

RankingTimeRange mapStringToRankingTimeRange(String? timeRangeString) {
  switch (timeRangeString) {
    case "today":
      return RankingTimeRange.today;
    case "this_week":
      return RankingTimeRange.this_week;
    case "this_month":
      return RankingTimeRange.this_month;
    case "this_year":
      return RankingTimeRange.this_year;
    case "all_time":
      return RankingTimeRange.all_time;
    default:
      return RankingTimeRange.this_month;
  }
}
