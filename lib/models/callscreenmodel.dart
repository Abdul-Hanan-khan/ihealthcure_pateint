class Callingscreenmodel {
  dynamic callername;
	dynamic visitNo;
	dynamic activity;
	dynamic title;
	dynamic branchId;
	dynamic uRL;
	dynamic dateTime;
	dynamic isFirstTimeVisit;
	dynamic doctorId;
	dynamic doctorImagePath;
	dynamic deviceToken;
	dynamic notificationType;
	dynamic patientId;
	dynamic imagePath;
	dynamic id;
	dynamic prescribedInValue;
	dynamic body;
	dynamic location;

	Callingscreenmodel({this.visitNo, this.activity, this.title, this.branchId, this.uRL, this.dateTime, this.isFirstTimeVisit, this.doctorId, this.doctorImagePath, this.deviceToken, this.notificationType, this.patientId, this.imagePath, this.id, this.prescribedInValue, this.body, this.location});

	Callingscreenmodel.fromJson(Map<dynamic, dynamic> json) {
		visitNo = json['VisitNo'];
		activity = json['Activity'];
		title = json['Title'];
		branchId = json['BranchId'];
		uRL = json[' URL'];
		dateTime = json['DateTime'];
		isFirstTimeVisit = json[' IsFirstTimeVisit'];
		doctorId = json['DoctorId'];
		doctorImagePath = json['DoctorImagePath'];
		deviceToken = json[' DeviceToken'];
		notificationType = json['NotificationType'];
		patientId = json['PatientId'];
		imagePath = json[' ImagePath'];
		id = json['Id'];
		prescribedInValue = json['PrescribedInValue'];
		body = json['Body'];
		location = json['Location'];
	}

	Map<dynamic, dynamic> toJson() {
		final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
		data['VisitNo'] = visitNo;
		data['Activity'] = activity;
		data['Title'] = title;
		data['BranchId'] = branchId;
		data[' URL'] = uRL;
		data['DateTime'] = dateTime;
		data[' IsFirstTimeVisit'] = isFirstTimeVisit;
		data['DoctorId'] = doctorId;
		data['DoctorImagePath'] = doctorImagePath;
		data[' DeviceToken'] = deviceToken;
		data['NotificationType'] = notificationType;
		data['PatientId'] = patientId;
		data[' ImagePath'] = imagePath;
		data['Id'] = id;
		data['PrescribedInValue'] = prescribedInValue;
		data['Body'] = body;
		data['Location'] = location;
		return data;
	}
}
