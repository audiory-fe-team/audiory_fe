import 'package:audiory_v0/feat-explore/models/ranking.dart';

RankingType mapStringToRankingType(String? typeString) {
  switch (typeString) {
    case "author":
      return RankingType.author;
    default:
      return RankingType.story;
  }
}

RankingMetric mapStringToRankingMetric(String? metricString) {
  switch (metricString) {
    case "total_view":
      return RankingMetric.total_read;
    case "total_vote":
      return RankingMetric.total_vote;
    case "total_comment":
      return RankingMetric.total_comment;

    default:
      return RankingMetric.total_read;
  }
}

RankingTimeRange mapStringToRankingTimeRange(String? timeRangeString) {
  switch (timeRangeString) {
    case "daily":
      return RankingTimeRange.daily;
    case "weekly":
      return RankingTimeRange.weekly;
    case "monthly":
      return RankingTimeRange.monthly;
    case "all_time":
      return RankingTimeRange.all_time;
    default:
      return RankingTimeRange.monthly;
  }
}

String getValueString(String rankingEnum) {
  return rankingEnum.split(".").last;
}
