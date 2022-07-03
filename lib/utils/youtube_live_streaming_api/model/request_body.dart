import 'dart:convert';

class YoutubeVideoInfo {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Status? status;

  YoutubeVideoInfo({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.status,
  });

  YoutubeVideoInfo fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    print("Snippet ------------------");
    snippet = Snippet().fromJson(json['snippet']);
    print(snippet);
    print("ContentDetails ------------------");
    contentDetails = ContentDetails().fromJson(json['contentDetails']);
    print(contentDetails);
    print("Status ------------------");
    status = Status().fromJson(json['status']);
    print(status);

    return this;
  }

  Map<String, dynamic> toJson() => {
        'snippet': snippet?.toJson() ?? "",
        'contentDetails': contentDetails?.toJson() ?? "",
        'status': status?.toJson() ?? "",
      };

  Map<String, dynamic> toJsonForPostingComment() => {
        'snippet': snippet?.toJsonForPostingComment() ?? "",
      };
}

class Snippet {
  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Map<String, Thumbnail>? thumbnails = {};
  DateTime? scheduledStartTime;
  DateTime? actualStartTime;
  DateTime? actualEndTime;
  bool? isDefaultBroadcast;
  String? liveChatId;
  String? type;
  String? authorChannelId;
  bool? hasDisplayContent;
  String? displayMessage;
  String? messageText;

  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.scheduledStartTime,
    this.actualStartTime,
    this.actualEndTime,
    this.isDefaultBroadcast,
    this.liveChatId,
    this.type,
    this.authorChannelId,
    this.hasDisplayContent,
    this.displayMessage,
    this.messageText,
  });

  Snippet fromJson(Map<String, dynamic> json) {
    thumbnails = {};

    publishedAt = DateTime.tryParse(json['publishedAt'] ?? "");
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails?['default'] = Thumbnail(json['thumbnails']?['default'] ?? {});
    thumbnails?['medium'] = Thumbnail(json['thumbnails']?['medium'] ?? {});
    thumbnails?['high'] = Thumbnail(json['thumbnails']?['high'] ?? {});
    thumbnails?['standard'] = Thumbnail(json['thumbnails']?['standard'] ?? {});
    thumbnails?['maxres'] = Thumbnail(json['thumbnails']?['maxres'] ?? {});
    scheduledStartTime = DateTime.tryParse(json['scheduledStartTime'] ?? '');
    actualStartTime = DateTime.tryParse(json['actualStartTime'] ?? '');
    actualEndTime = DateTime.tryParse(json['actualEndTime'] ?? '');
    isDefaultBroadcast = json['isDefaultBroadcast'];
    liveChatId = json['liveChatId'];
    type = json['type'];
    authorChannelId = json['authorChannelId'];
    hasDisplayContent = json['hasDisplayContent'];
    displayMessage = json['displayMessage'];
    messageText = json['textMessageDetails']?['messageText'];

    return this;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'scheduledStartTime': scheduledStartTime?.toIso8601String(),
      };

  Map<String, dynamic> toJsonForPostingComment() => {
        'liveChatId': liveChatId,
        'type': type,
        'textMessageDetails': {
          'messageText': messageText,
        },
      };
}

class AuthorDetails {
  String? channelId;
  String? channelUrl;
  String? displayName;
  String? profileImageUrl;
  bool? isVerified;
  bool? isChatOwner;
  bool? isChatSponsor;
  bool? isChatModerator;

  AuthorDetails({
    this.channelId,
    this.channelUrl,
    this.displayName,
    this.profileImageUrl,
    this.isVerified,
    this.isChatOwner,
    this.isChatSponsor,
    this.isChatModerator,
  });

  AuthorDetails fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    channelUrl = json['channelUrl'];
    displayName = json['displayName'];
    profileImageUrl = json['profileImageUrl'];
    isVerified = json['isVerified'];
    isChatOwner = json['isChatOwner'];
    isChatSponsor = json['isChatSponsor'];
    isChatModerator = json['isChatModerator'];

    return this;
  }
}

class ContentDetails {
  String? boundStreamId;
  DateTime? boundStreamLastUpdateTimeMs;
  bool? enableMonitorStream;
  bool? enableEmbed;
  bool? enableDvr;
  bool? enableContentEncryption;
  bool? startWithSlate;
  bool? recordFromStart;
  bool? enableClosedCaptions;
  String? closedCaptionsType;
  bool? enableLowLatency;
  String? latencyPreference;
  String? projection;
  bool? enableAutoStart;
  bool? enableAutoStop;

  ContentDetails({
    this.boundStreamId,
    this.boundStreamLastUpdateTimeMs,
    this.enableMonitorStream,
    this.enableEmbed,
    this.enableDvr,
    this.enableContentEncryption,
    this.startWithSlate,
    this.recordFromStart,
    this.enableClosedCaptions,
    this.closedCaptionsType,
    this.enableLowLatency,
    this.latencyPreference,
    this.projection,
    this.enableAutoStart,
    this.enableAutoStop,
  });

  ContentDetails fromJson(Map<String, dynamic> json) {
    boundStreamId = json['boundStreamId'];
    closedCaptionsType = json['closedCaptionsType'];
    latencyPreference = json['latencyPreference'];
    projection = json['projection'];
    boundStreamLastUpdateTimeMs =
        DateTime.tryParse(json['boundStreamLastUpdateTimeMs'] ?? '');
    enableMonitorStream = json['monitorStream']?['enableMonitorStream'];
    enableEmbed = json['enableEmbed'];
    enableDvr = json['enableDvr'];
    enableContentEncryption = json['enableContentEncryption'];
    startWithSlate = json['startWithSlate'];
    recordFromStart = json['recordFromStart'];
    enableClosedCaptions = json['enableClosedCaptions'];
    enableLowLatency = json['enableLowLatency'];
    enableAutoStart = json['enableAutoStart'];
    enableAutoStop = json['enableAutoStop'];

    return this;
  }

  Map<String, dynamic> toJson() => {
        'enableClosedCaptions': enableClosedCaptions,
        'enableContentEncryption': enableContentEncryption,
        'enableDvr': enableDvr,
        'enableEmbed': enableEmbed,
        'recordFromStart': recordFromStart,
        'startWithSlate': startWithSlate,
      };
}

class Status {
  String? lifeCycleStatus;
  String? privacyStatus;
  String? recordingStatus;
  bool? madeForKids;
  bool? selfDeclaredMadeForKids;

  Status({
    this.lifeCycleStatus,
    this.privacyStatus,
    this.recordingStatus,
    this.madeForKids,
    this.selfDeclaredMadeForKids,
  });

  Status fromJson(Map<String, dynamic> json) {
    lifeCycleStatus = json['lifeCycleStatus'];
    privacyStatus = json['privacyStatus'];
    recordingStatus = json['recordingStatus'];
    madeForKids = json['madeForKids'];
    selfDeclaredMadeForKids = json['selfDeclaredMadeForKids'];

    return this;
  }

  Map<String, dynamic> toJson() => {
        'privacyStatus': privacyStatus,
      };
}

class Thumbnail {
  String? url;
  int? width;
  int? height;

  Thumbnail(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }
}

class ChatMessage {
  String authorName;
  String message;
  String profileImageUrl;

  ChatMessage(this.authorName, this.message, this.profileImageUrl);
}
