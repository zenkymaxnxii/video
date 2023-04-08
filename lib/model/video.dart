class Video {
  int? id;
  int? userId;
  String? type;
  String? subject;
  String? content;
  String? typeScope;
  int? isNews;
  Null? parentId;
  String? createdAt;
  int? totalShared;
  int? totalReaction;
  int? totalComment;
  int? totalSaved;
  bool? isHearted;
  bool? isSaved;
  Null? parent;
  User? user;
  List<Medias>? medias;

  Video(
      {this.id,
      this.userId,
      this.type,
      this.subject,
      this.content,
      this.typeScope,
      this.isNews,
      this.parentId,
      this.createdAt,
      this.totalShared,
      this.totalReaction,
      this.totalComment,
      this.totalSaved,
      this.isHearted,
      this.isSaved,
      this.parent,
      this.user,
      this.medias});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    subject = json['subject'];
    content = json['content'];
    typeScope = json['typeScope'];
    isNews = json['isNews'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    totalShared = json['totalShared'];
    totalReaction = json['totalReaction'];
    totalComment = json['totalComment'];
    totalSaved = json['totalSaved'];
    isHearted = json['isHearted'];
    isSaved = json['isSaved'];
    parent = json['parent'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(new Medias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['subject'] = this.subject;
    data['content'] = this.content;
    data['typeScope'] = this.typeScope;
    data['isNews'] = this.isNews;
    data['parentId'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['totalShared'] = this.totalShared;
    data['totalReaction'] = this.totalReaction;
    data['totalComment'] = this.totalComment;
    data['totalSaved'] = this.totalSaved;
    data['isHearted'] = this.isHearted;
    data['isSaved'] = this.isSaved;
    data['parent'] = this.parent;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.medias != null) {
      data['medias'] = this.medias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? avatar;
  String? pDoneId;
  String? hexId;
  String? displayName;
  bool? isPDone;
  bool? isJA;
  bool? isVShop;
  bool? isFriend;
  bool? isFollowed;

  User(
      {this.id,
      this.avatar,
      this.pDoneId,
      this.hexId,
      this.displayName,
      this.isPDone,
      this.isJA,
      this.isVShop,
      this.isFriend,
      this.isFollowed});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    pDoneId = json['pDoneId'];
    hexId = json['hexId'];
    displayName = json['displayName'];
    isPDone = json['isPDone'];
    isJA = json['isJA'];
    isVShop = json['isVShop'];
    isFriend = json['isFriend'];
    isFollowed = json['isFollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['pDoneId'] = this.pDoneId;
    data['hexId'] = this.hexId;
    data['displayName'] = this.displayName;
    data['isPDone'] = this.isPDone;
    data['isJA'] = this.isJA;
    data['isVShop'] = this.isVShop;
    data['isFriend'] = this.isFriend;
    data['isFollowed'] = this.isFollowed;
    return data;
  }
}

class Medias {
  int? id;
  String? link;

  Medias({this.id, this.link});

  Medias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    return data;
  }
}
