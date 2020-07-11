// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.user,
        this.schemas,
        this.token,
        this.redirectUrl,
        this.modulesEnabled,
        this.message,
    });

    User user;
    List<String> schemas;
    String token;
    String redirectUrl;
    List<String> modulesEnabled;
    String message;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        schemas: List<String>.from(json["schemas"].map((x) => x)),
        token: json["token"],
        redirectUrl: json["redirect_url"],
        modulesEnabled: List<String>.from(json["modules_enabled"].map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "schemas": List<dynamic>.from(schemas.map((x) => x)),
        "token": token,
        "redirect_url": redirectUrl,
        "modules_enabled": List<dynamic>.from(modulesEnabled.map((x) => x)),
        "message": message,
    };
}

class User {
    User({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.role,
        this.designation,
        this.companyType,
        this.emailVerified,
        this.deleted,
        this.timeZone,
        this.isApprovalMatrix,
        this.approvalMatrix,
    });

    String id;
    String name;
    String email;
    String phone;
    String role;
    String designation;
    String companyType;
    bool emailVerified;
    bool deleted;
    String timeZone;
    bool isApprovalMatrix;
    ApprovalMatrix approvalMatrix;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        designation: json["designation"],
        companyType: json["company_type"],
        emailVerified: json["email_verified"],
        deleted: json["deleted"],
        timeZone: json["time_zone"],
        isApprovalMatrix: json["is_approval_matrix"],
        approvalMatrix: ApprovalMatrix.fromJson(json["approval_matrix"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "designation": designation,
        "company_type": companyType,
        "email_verified": emailVerified,
        "deleted": deleted,
        "time_zone": timeZone,
        "is_approval_matrix": isApprovalMatrix,
        "approval_matrix": approvalMatrix.toJson(),
    };
}

class ApprovalMatrix {
    ApprovalMatrix({
        this.type,
        this.hierarchy,
        this.nextApprovals,
    });

    String type;
    int hierarchy;
    List<dynamic> nextApprovals;

    factory ApprovalMatrix.fromJson(Map<String, dynamic> json) => ApprovalMatrix(
        type: json["type"],
        hierarchy: json["hierarchy"],
        nextApprovals: List<dynamic>.from(json["next_approvals"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "hierarchy": hierarchy,
        "next_approvals": List<dynamic>.from(nextApprovals.map((x) => x)),
    };
}
