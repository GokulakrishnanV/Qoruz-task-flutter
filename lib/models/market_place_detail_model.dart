class MarketPlaceDetail {
  bool? ok;
  WebMarketplaceRequests? webMarketplaceRequests;

  MarketPlaceDetail({this.ok, this.webMarketplaceRequests});

  MarketPlaceDetail.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    webMarketplaceRequests = json['web_marketplace_requests'] != null ? WebMarketplaceRequests.fromJson(json['web_marketplace_requests']) : null;
  }
}

class WebMarketplaceRequests {
  String? idHash;
  UserDetails? userDetails;
  bool? isHighValue;
  String? createdAt;
  String? description;
  String? requestDetails;
  String? status;
  String? serviceType;
  String? targetAudience;
  bool? isOpen;
  bool? isPanIndia;
  bool? anyLanguage;
  bool? isDealClosed;
  String? slug;

  WebMarketplaceRequests({
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

  WebMarketplaceRequests.fromJson(Map<String, dynamic> json) {
    idHash = json['id_hash'];
    userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
    isHighValue = json['is_high_value'];
    createdAt = json['created_at'];
    description = json['description'];
    requestDetails = json['request_details'];
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
