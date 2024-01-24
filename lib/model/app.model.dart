class AppModel {
    int? id;
    String? version;
    int? appBuildNumber;
    int? claimMode;
    bool? forceUpdate;
    More? more;
    DateTime? createdAt;
    DateTime? updatedAt;

    AppModel({
        this.id,
        this.version,
        this.appBuildNumber,
        this.claimMode,
        this.forceUpdate,
        this.more,
        this.createdAt,
        this.updatedAt,
    });

    factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        id: json["id"],
        version: json["version"],
        appBuildNumber: json["appBuildNumber"],
        claimMode: json["claimMode"],
        forceUpdate: json["forceUpdate"],
        more: json["more"] == null ? null : More.fromJson(json["more"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "appBuildNumber": appBuildNumber,
        "claimMode": claimMode,
        "forceUpdate": forceUpdate,
        "more": more?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class More {
    String? primary;
    String? brand;

    More({
        this.primary,
        this.brand,
    });

    factory More.fromJson(Map<String, dynamic> json) => More(
        primary: json["primary"],
        brand: json["brand"],
    );

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "brand": brand,
    };
}
