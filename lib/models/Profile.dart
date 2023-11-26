import 'package:audiory_v0/models/Library.dart';
import 'package:audiory_v0/models/story/story_model.dart';

class Profile {
  final String? avatarUrl;
  final String? backgroundUrl;
  final String? bankAccountNumber;
  final String? bankHolderName;
  final String? bankName;
  final String? createdDate;
  final String? description;
  final String? dob;
  final String? sex;
  final String? email;
  final String? facebookUrl;
  final String? firstName;
  final String? fullName;
  final String? id;
  final bool? isEnabled;
  final bool? isOnline;
  final String? lastName;
  final int? totalDonation;
  final int? numberOfFollowers;
  final List<Profile>? followings;
  final int? numberOfFollowing;
  final List<Profile>? followers;
  final int? reportCount;
  final int? totalVote;
  final int? totalRead;
  final int? levelId;
  final int? authorLevelId;
  final bool? isAuthorFlairSelected;
  final bool? isFollowed;
  final bool? isNotified;
  final int? totalComment;
  final String? updatedDate;
  final String? username;
  final List<Story>? stories;
  final Library? library;

  Profile(
      {this.avatarUrl,
      this.backgroundUrl,
      this.bankAccountNumber,
      this.bankHolderName,
      this.bankName,
      this.createdDate,
      this.description,
      this.dob,
      this.email,
      this.facebookUrl = '',
      this.firstName,
      this.fullName,
      required this.id,
      this.isEnabled,
      this.isOnline,
      this.lastName,
      this.totalDonation,
      this.numberOfFollowers,
      this.numberOfFollowing,
      this.followings,
      this.followers,
      this.reportCount,
      this.totalComment,
      this.totalRead,
      this.totalVote,
      this.levelId = 1,
      this.authorLevelId = 1,
      this.isAuthorFlairSelected = false,
      this.isFollowed = false,
      this.isNotified = false,
      this.updatedDate,
      required this.username,
      this.stories,
      this.library,
      this.sex});

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<dynamic> storiesJson = json["stories"] ?? [];
    List<Story> stories = storiesJson.map((p) => Story.fromJson(p)).toList();

    List<dynamic> followersJsonList = json['followers'] ?? [];
    List<Profile> followers = followersJsonList
        .map((follower) => Profile.fromJson(follower))
        .toList();

    List<dynamic> followingsJsonList = json['followings'] ?? [];
    List<Profile> followings = followingsJsonList
        .map((following) => Profile.fromJson(following))
        .toList();

    return Profile(
      avatarUrl: json['avatar_url'],
      backgroundUrl: json['background_url'],
      bankAccountNumber: json['bank_account_number'],
      bankHolderName: json['bank_holder_name'],
      bankName: json['bank_name'],
      createdDate: json['created_date'],
      description: json['description'],
      dob: json['dob'],
      sex: json['sex'],
      email: json['email'],
      facebookUrl: json['facebook_url'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      id: json['id'],
      isEnabled: json['is_enabled'],
      isOnline: json['is_online'],
      lastName: json['last_name'],
      totalDonation: json['total_donation'],
      numberOfFollowers: json['number_of_followers'],
      numberOfFollowing: json['number_of_following'],
      followings: followings,
      followers: followers,
      reportCount: json['report_count'],
      totalComment: json['total_comment'],
      totalRead: json['total_read'],
      totalVote: json['total_vote'],
      levelId: json['level_id'],
      authorLevelId: json['author_level_id'],
      isAuthorFlairSelected: json['is_author_flair_selected'],
      isFollowed: json['is_followed'],
      isNotified: json['is_notified'],
      updatedDate: json['updated_date'],
      username: json['username'],
      library:
          json['library'] == null ? null : Library.fromJson(json['library']),
      stories: stories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar_url': avatarUrl,
      'background_url': backgroundUrl,
      'bank_account_number': bankAccountNumber,
      'bank_holder_name': bankHolderName,
      'bank_name': bankName,
      'created_date': createdDate,
      'description': description,
      'dob': dob,
      'sex': sex,
      'email': email,
      'facebook_url': facebookUrl,
      'first_name': firstName,
      'full_name': fullName,
      'id': id,
      'is_enabled': isEnabled,
      'is_online': isOnline,
      'last_name': lastName,
      'number_of_followers': numberOfFollowers,
      'total_donation': totalDonation,
      'number_of_following': numberOfFollowing,
      'followers': followers,
      'followings': followings,
      'report_count': reportCount,
      'total_comment': totalComment,
      'total_read': totalRead,
      'total_vote': totalVote,
      'level_id': levelId,
      'author_level_id': authorLevelId,
      'is_author_flair_selected': isAuthorFlairSelected,
      'is_followed': isFollowed,
      'is_notified': isNotified,
      'updated_date': updatedDate,
      'username': username,
      'library': library?.toJson(),
      "stories": stories?.map((story) => story.toJson()).toList(),
    };
  }
}
