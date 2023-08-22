import 'package:audiory_v0/models/Library.dart';
import 'package:audiory_v0/models/Story.dart';

class Profile {
  final String? avatarUrl;
  final String? backgroundUrl;
  final String? bankAccountNumber;
  final String? bankHolderName;
  final String? bankName;
  final String? createdDate;
  final String? description;
  final String? dob;
  final String? email;
  final String? facebookUrl;
  final String? firstName;
  final String? fullName;
  final String id;
  final bool? isEnabled;
  final bool? isOnline;
  final String? lastName;
  final int? numberOfFollowers;
  final int? numberOfFollowing;
  final int? reportCount;
  final String? updatedDate;
  final String username;
  final List<Story>? stories;
  final Library? library;

  Profile({
    this.avatarUrl,
    this.backgroundUrl,
    this.bankAccountNumber,
    this.bankHolderName,
    this.bankName,
    this.createdDate,
    this.description,
    this.dob,
    this.email,
    this.facebookUrl,
    this.firstName,
    this.fullName,
    required this.id,
    this.isEnabled,
    this.isOnline,
    this.lastName,
    this.numberOfFollowers,
    this.numberOfFollowing,
    this.reportCount,
    this.updatedDate,
    required this.username,
    this.stories,
    this.library,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<dynamic> storiesJson = json["stories"] ?? [];
    List<Story> stories = storiesJson.map((p) => Story.fromJson(p)).toList();

    return Profile(
      avatarUrl: json['avatar_url'],
      backgroundUrl: json['background_url'],
      bankAccountNumber: json['bank_account_number'],
      bankHolderName: json['bank_holder_name'],
      bankName: json['bank_name'],
      createdDate: json['created_date'],
      description: json['description'],
      dob: json['dob'],
      email: json['email'],
      facebookUrl: json['facebook_url'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      id: json['id'],
      isEnabled: json['is_enabled'],
      isOnline: json['is_online'],
      lastName: json['last_name'],
      numberOfFollowers: json['number_of_followers'],
      numberOfFollowing: json['number_of_following'],
      reportCount: json['report_count'],
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
      'email': email,
      'facebook_url': facebookUrl,
      'first_name': firstName,
      'full_name': fullName,
      'id': id,
      'is_enabled': isEnabled,
      'is_online': isOnline,
      'last_name': lastName,
      'number_of_followers': numberOfFollowers,
      'number_of_following': numberOfFollowing,
      'report_count': reportCount,
      'updated_date': updatedDate,
      'username': username,
      'library': library?.toJson(),
      "stories": stories?.map((story) => story.toJson()).toList(),
    };
  }
}
