class Notificationmodel {
  String? id;
  dynamic title;
  dynamic body;
  dynamic uRL;
  dynamic icon;
  dynamic deviceToken;
  dynamic activity;
  dynamic dateTime;
  dynamic webToken;
  dynamic userName;
  dynamic userId;
  dynamic NotificationmodelType;
  dynamic isViewed;
  dynamic email;
  Notificationmodel(
      {this.id,
      this.title,
      this.body,
      this.uRL,
      this.icon,
      this.deviceToken,
      this.activity,
      this.dateTime,
      this.webToken,
      this.userName,
      this.userId,
      this.NotificationmodelType,
      this.isViewed,
      this.email});
  Notificationmodel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    body = json['Body'];
    uRL = json['URL'];
    icon = json['Icon'];
    deviceToken = json['DeviceToken'];
    activity = json['Activity'];
    dateTime = json['DateTime'];
    webToken = json['WebToken'];
    userName = json['UserName'];
    userId = json['UserId'];
    NotificationmodelType = json['NotificationmodelType'];
    isViewed = json['IsViewed'];
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['Body'] = body;
    data['URL'] = uRL;
    data['Icon'] = icon;
    data['DeviceToken'] = deviceToken;
    data['Activity'] = activity;
    data['DateTime'] = dateTime;
    data['WebToken'] = webToken;
    data['UserName'] = userName;
    data['UserId'] = userId;
    data['NotificationmodelType'] = NotificationmodelType;
    data['IsViewed'] = isViewed;
    data['email'] = email;
    return data;
  }
}
