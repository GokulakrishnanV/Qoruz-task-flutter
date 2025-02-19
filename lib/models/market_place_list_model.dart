class MarketPlaceList {
  bool? ok;
  List<MarketplaceRequests>? marketplaceRequests;
  Pagination? pagination;

  MarketPlaceList({this.ok, this.marketplaceRequests, this.pagination});

  MarketPlaceList.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['marketplace_requests'] != null) {
      marketplaceRequests = <MarketplaceRequests>[];
      json['marketplace_requests'].forEach((v) {
        marketplaceRequests!.add(MarketplaceRequests.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
}

class MarketplaceRequests {
  String? idHash;
  UserDetails? userDetails;
  bool? isHighValue;
  String? createdAt;
  String? description;
  RequestDetails? requestDetails;
  String? status;
  String? serviceType;
  String? targetAudience;
  bool? isOpen;
  bool? isPanIndia;
  bool? anyLanguage;
  bool? isDealClosed;
  String? slug;

  MarketplaceRequests({
    this.idHash,
    this.userDetails,
    this.isHighValue,
    this.createdAt,
    this.description,
    this.requestDetails,
    this.status,
    this.serviceType,
    this.targetAudience,
    this.isOpen,
    this.isPanIndia,
    this.anyLanguage,
    this.isDealClosed,
    this.slug,
  });

  MarketplaceRequests.fromJson(Map<String, dynamic> json) {
    idHash = json['id_hash'];
    userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
    isHighValue = json['is_high_value'];
    createdAt = json['created_at'];
    description = json['description'];
    requestDetails = json['request_details'] != null ? RequestDetails.fromJson(json['request_details']) : null;
    status = json['status'];
    serviceType = json['service_type'];
    targetAudience = json['target_audience'];
    isOpen = json['is_open'];
    isPanIndia = json['is_pan_india'];
    anyLanguage = json['any_language'];
    isDealClosed = json['is_deal_closed'];
    slug = json['slug'];
  }
}

class UserDetails {
  String? name;
  String? profileImage;
  String? company;
  String? designation;

  UserDetails({this.name, this.profileImage, this.company, this.designation});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
    company = json['company'];
    designation = json['designation'];
  }
}

class RequestDetails {
  List<String>? cities;
  FollowersRange? followersRange;
  List<String>? categories;
  List<String>? languages;
  List<String>? platform;
  int? creatorCountMin;
  int? creatorCountMax;
  String? budget;
  String? brand;
  String? gender;

  RequestDetails({
    this.cities,
    this.followersRange,
    this.categories,
    this.languages,
    this.platform,
    this.creatorCountMin,
    this.creatorCountMax,
    this.budget,
    this.brand,
    this.gender,
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    cities = json['cities'].cast<String>();
    followersRange = json['followers_range'] != null ? FollowersRange.fromJson(json['followers_range']) : null;
    categories = json['categories'].cast<String>();
    languages = json['languages'].cast<String>();
    platform = json['platform'].cast<String>();
    creatorCountMin = json['creator_count_min'];
    creatorCountMax = json['creator_count_max'];
    budget = json['budget'];
    brand = json['brand'];
    gender = json['gender'];
  }
}

class FollowersRange {
  String? igFollowersMin;
  String? igFollowersMax;
  String? ytSubscribersMin;
  String? ytSubscribersMax;

  FollowersRange({this.igFollowersMin, this.igFollowersMax, this.ytSubscribersMin, this.ytSubscribersMax});

  FollowersRange.fromJson(Map<String, dynamic> json) {
    igFollowersMin = json['ig_followers_min'];
    igFollowersMax = json['ig_followers_max'];
    ytSubscribersMin = json['yt_subscribers_min'];
    ytSubscribersMax = json['yt_subscribers_max'];
  }
}

class Pagination {
  bool? hasMore;
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  String? nextPageUrl;
  String? previousPageUrl;
  String? url;

  Pagination({
    this.hasMore,
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.nextPageUrl,
    this.previousPageUrl,
    this.url,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    hasMore = json['has_more'];
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['has_more'] = hasMore;
    data['total'] = total;
    data['count'] = count;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    data['url'] = url;
    return data;
  }
}
