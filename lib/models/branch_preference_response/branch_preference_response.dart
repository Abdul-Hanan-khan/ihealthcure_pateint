class BranchPreferenceResponse {
  int? status;
  String? message;
  Data? data;

  BranchPreferenceResponse({this.status, this.message, this.data});

  BranchPreferenceResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? virtualUserId;
  int? batchingType;
  bool? isMondayWorkingDay;
  String? mondayStartingTime;
  String? mondayClosingTime;
  bool? isTuesdayWorkingDay;
  String? tuesdayStartingTime;
  String? tuesdayClosingTime;
  bool? isWednesdayWorkingDay;
  String? wednesdayStartingTime;
  String? wednesdayClosingTime;
  bool? isThursdayWorkingDay;
  String? thursdayStartingTime;
  String? thursdayClosingTime;
  bool? isFridayWorkingDay;
  String? fridayStartingTime;
  String? fridayClosingTime;
  bool? isSaturdayWorkingDay;
  String? saturdayStartingTime;
  String? saturdayClosingTime;
  bool? isSundayWorkingDay;
  String? sundayStartingTime;
  String? sundayClosingTime;
  int? mRcardType;
  int? receiptType;
  int? labReceiptType;
  int? diagnosticsReceiptType;
  bool? patientReceiptCopy;
  bool? accountantReceiptCopy;
  bool? departmentReceiptCopy;
  String? hospitalStatisticsSummaryIds;
  String? todaySummaryIds;
  int? prescriptionHeaderType;
  int? prescriptionFooterType;
  String? branchPrescriptionStamp;
  int? prescriptionTopMargin;
  int? prescriptionBottomMargin;
  int? dischargeHeaderType;
  int? dischargeFooterType;
  int? dischargeTopMargin;
  int? dischargeBottomMargin;
  int? labReportHeaderType;
  int? labReportPatientDetailType;
  int? labReportFooterType;
  int? labReportTopMargin;
  int? labReportBottomMargin;
  int? procedureReportHeaderType;
  int? procedureReportFooterType;
  double? procedureReportTopMargin;
  double? procedureReportBottomMargin;
  int? deathCertificateHeaderType;
  int? deathCertificateFooterType;
  double? deathCertificateTopMargin;
  double? deathCertificateBottomMargin;
  bool? isEnglishDonorQuestionnaire;
  bool? isOnlyVerifiedReportsPrintable;
  bool? isUrduDonorQuestionnaire;
  String? donorAffidavitInEnglish;
  String? donorAffidavitInUrdu;
  bool? isEmailNotificationEnabled;
  bool? isSMSNotificationEnabled;
  bool? isPushNotificationEnabled;
  bool? isShowBioRadAffiliation;
  bool? isShowPatientAppQRDetail;
  String? inventoryInTransitionAccountId;
  int? microDrugDisplayType;
  String? dayClosingCashAccountId;
  String? dayClosingRevenueAccountId;
  String? dayClosingCreditAccountId;
  bool? isHideTotalItemsAvailableWhilePlacingDemandRequest;
  bool? isApplyEmployeePayrollRestriction;
  bool? isApplyDoctorFollowUpConsultancyFeeFeature;
  bool? isAllowCreditAmount;
  int? maxCreditAllowed;
  bool? isApplyDiscountRestriction;
  bool? isHideChargesInIPDMedicineReportForRegularPatient;
  int? challanFormReportPrintCopyType;
  int? labChallanFormReportPrintCopyType;
  bool? isRestrictedDataEnteryVerifiedChallansCancellation;
  bool? displayPatientVaultDataTableInfo;
  bool? isCustomPanelEntitleVisit;
  String? defaultSubServiceId;
  String? defaultAttributeNameId;
  bool? isShowDifferentLabChallansAsCombinedOne;
  int? dashboardServicesConsumptionDisplayType;
  String? emptyHeaderNormalSpacing;
  int? emptyHeaderQRCodeSpacing;
  int? noLogoPatientDetailTopMargin;
  int? labReportHeaderTopMargin;
  int? labReportFooterBottomMargin;
  int? labReportHeaderHeadingFont;
  int? labReportHeaderTextFont;
  String? labReportHeaderImagePath;
  String? labReportFooterImagePath;
  String? labReportFooterText;
  bool? isVerifyPhoneNumberforPatientSignUp;
  List<dynamic>? subServiceList;
  String? consentFormAttachment;
  double? prescriptionReportEmptyHeaderSpacing;
  bool? isDisplayCompletePatientNameInPrescription;
  bool? isLabReportDateTimeAdjustable;
  bool? isShowOnlyPatientPersonalNameInLabReport;
  bool? isShowIHCPatientAppQRCode;
  bool? isShowOnlineOfflineLabel;
  bool? isHidePrintedByLabReport;
  bool? isShowPendingCreditAmountInCashFlowReport;
  int? qRCodeHeight;
  bool? isCalculateDoctorServiceShareOnDiscountedBookings;
  bool? isTokenNumberEnabled;
  bool? isOPDQueueSysEnabled;
  bool? isShowRoomWithToken;
  bool? isERXDiagnosisMandatory;
  bool? isERXComplaintMandatory;
  bool? isERXBPMandatory;
  bool? isERXPulseMandatory;
  bool? isDischargeComplaintMandatory;
  bool? isDischargePulseMandatory;
  bool? isDischargeBPMandatory;
  bool? isDischargeDiagnosisMandatory;
  bool? isOpenEmptyERXOnCheckin;
  bool? isCreateNewChallanOnUpdatingDoctorChallanForms;
  bool? isDoctorCheckInPaymentAmountIncreaseable;
  bool? isIPDServicesPriceEditable;
  int? medicineDisplayType;
  bool? isApplyRefundOverflowRestriction;
  bool? isRestrictNursesListInNursingNotesWithLoggedInNurse;
  int? birthCertificateHeaderType;
  int? birthCertificateFooterType;
  String? birthCertificateTopMargin;
  String? birthCertificateBottomMargin;
  bool? isEnableLocationatPatientCheckIn;
  bool? isDisplayBookingReferenceDetailsAtPatientCheckIn;
  bool? isShowTotalChargesSumInCashFlowReport;
  bool? isShowHospitalShareInCashFlowReport;
  bool? isReferralPanelBookingEnabled;
  int? labBarCodeType;
  bool? isDisplayWaterMarkOnDischargeReport;
  int? isDisplayWaterMarkDisplayTypeOnDischargeReport;
  String? waterMarkTextForDischargeReport;
  String? imageWaterMarkPath;
  bool? isDisplayWaterMarkOnDiagnosticReport;
  int? isDisplayWaterMarkDisplayTypeOnDiagnosticReport;
  String? waterMarkTextOnDiagnosticReport;
  String? imageWaterMarkPathOnDiagnosticReport;
  bool? isDisplayWaterMarkOnLabReports;
  int? isDisplayWaterMarkDisplayTypeOnLabReports;
  String? waterMarkTextOnLabReports;
  String? imageWaterMarkPathOnLabReports;
  bool? isDisplayVerifiedByDoctorListOnLabReportVerification;
  bool? isDisplayVerifiedByInformationOnLabReports;
  bool? isDisplayOnlyLastVerifiedByInformationOnLabReports;
  bool? isStrongPasswordConfigurationEnabled;
  String? dynamicIdentityNoLabel;
  String? mobileNoDynamicPlaceHolder;
  String? dynamicMaskingForIdentityNumber;
  int? dynamicNumberOfDigitsForIdentityNumber;
  bool? isShowMobileAppLoginQRCodeOnMRCard;
  bool? isShowTokenNoWithAppointmentNo;
  String? receiptQRCodeType;
  bool? isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport;
  String? noteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport;
  bool? isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport;
  String? noteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport;
  bool? isWhatsAppNotificationEnabled;
  int? vATPercentageAmount;
  bool? isDisplayVATAmount;
  String? contactNoDynamicLabel;
  String? doctorRegistrationNoDynamicLabel;
  String? taxNoDynamicLabel;
  bool? isDisplayOEPFormDetailAtPatientCheckIn;
  String? labBookingSMSFormatWithCredit;
  String? labBookingSMSFormatWithoutCredit;
  String? labFirstReportVerificationSMSFormatWithCredit;
  String? labFirstReportVerificationSMSFormatWithoutCredit;
  String? labLastReportVerificationSMSFormatWithCredit;
  String? labLastReportVerificationSMSFormatWithoutCredit;
  String? defaultLabReportVerificationSMSFormatWithCredit;
  String? defaultLabReportVerificationSMSFormatWithoutCredit;
  int? customLanguageKeyBoardType;
  String? followUpListOrderByType;
  String? itemNameDisplayTypeInPurchaseOrderDetail;
  String? isDisplayReligionAndMaritalStatusOnLabReceipts;
  String? dynamicPanelKeyword;
  bool? isDisplayAppointmentBookingInterfaceAfterPatientRegistration;
  bool? isDisplayHeadCircumferenceAndBSRInVitals;
  String? healthCoordinatorsContactNumbers;
  int? geolocationFilteringDistance;
  bool? isApplyGeolocationFilterOnLabAppointments;
  bool? isNonHospitalOrganization;
  double? dehydrationAvoidanceReminderInterval;
  double? dehydrationAvoidanceReminderIntervalId;
  double? tirednessAvoidanceReminderInterval;
  double? tirednessAvoidanceReminderIntervalId;
  bool? isHighlightInsuranceCoveredForMedicines;
  bool? isDisplayAllergyAlertPopupInititally;
  bool? isDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface;
  bool? isDisableAutoPrintingofEmergencyChallan;
  bool? isDisableAutoPrintingofDepartmentChallan;
  bool? isDisableAutoPrintingofDoctorChallan;
  bool? isDisableAutoPrintingofLabChallan;
  bool? isDisableAutoPrintingofProcedureChallan;
  bool? isDisableAutoPrintingofBloodDonationChallan;
  bool? isDisableAutoPrintingofMiscServicesChallan;
  bool? isDisableAutoOpeningOfPrescriptionReport;
  bool? isDisableAutoOpeningofDischargeReport;
  String? sMSSendingTypeForDoctorAppointment;
  bool? isLabInternalNotificationEnabled;
  bool? isHideAdditionalInsuranceDetailsAtPatientRegistration;
  bool? isShowAirlineDetailAtCheckInInterface;
  bool? isDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface;
  bool? isShowCardDetailsWithCashPaymentTypeWhileBillReceiving;
  bool? isDisplayVATAmountInCashFlow;
  bool? isHideTypeInCheckIn;
  bool? isHideCheckInToInCheckIn;
  bool? isHidePrescribedByInCheckIn;
  bool? isHideDoctorInCheckIn;
  bool? isHideBookingSlipPrescriptionInCheckIn;
  bool? isHideDepartmentInCheckIn;
  bool? isHideServiceCategoryinCheckIn;
  bool? isHideAirlineInCheckIn;
  bool? isHideSMSAlertInCheckIn;
  bool? isHideSampleReceivedInCheckIn;
  bool? isHideShareEntityInCheckIn;
  bool? isHideDiscountInCheckIn;
  bool? isHideAdvisedByInCheckIn;
  bool? isHideBranchLocationInCheckIn;
  bool? isHideAdvanceSecurityInCheckIn;
  bool? isHidePaymentMethodInCheckIn;
  bool? isHideVIPBookingInCheckIn;
  bool? isHideSampleCollectionStickerInCheckIn;
  bool? isHideVoucherCouponInCheckIn;
  String? procurementTermAndConditions;
  bool? isProviderSetting;
  bool? isDisplayAppointmentButton;
  String? contingentBillStamp;
  String? whatsAppNotificationMessage;
  bool? isDisplayFooterTextonThermalReceiptType;
  bool? isDisplayReportingTimeonLabReports;
  bool? isDisplayAsteriskwithReferenceNumber;
  String? applyRestrictionOfMPLatDemandRequest;
  String? dynamicRegistrationDateLabel;

  Data(
      {this.id,
      this.virtualUserId,
      this.batchingType,
      this.isMondayWorkingDay,
      this.mondayStartingTime,
      this.mondayClosingTime,
      this.isTuesdayWorkingDay,
      this.tuesdayStartingTime,
      this.tuesdayClosingTime,
      this.isWednesdayWorkingDay,
      this.wednesdayStartingTime,
      this.wednesdayClosingTime,
      this.isThursdayWorkingDay,
      this.thursdayStartingTime,
      this.thursdayClosingTime,
      this.isFridayWorkingDay,
      this.fridayStartingTime,
      this.fridayClosingTime,
      this.isSaturdayWorkingDay,
      this.saturdayStartingTime,
      this.saturdayClosingTime,
      this.isSundayWorkingDay,
      this.sundayStartingTime,
      this.sundayClosingTime,
      this.mRcardType,
      this.receiptType,
      this.labReceiptType,
      this.diagnosticsReceiptType,
      this.patientReceiptCopy,
      this.accountantReceiptCopy,
      this.departmentReceiptCopy,
      this.hospitalStatisticsSummaryIds,
      this.todaySummaryIds,
      this.prescriptionHeaderType,
      this.prescriptionFooterType,
      this.branchPrescriptionStamp,
      this.prescriptionTopMargin,
      this.prescriptionBottomMargin,
      this.dischargeHeaderType,
      this.dischargeFooterType,
      this.dischargeTopMargin,
      this.dischargeBottomMargin,
      this.labReportHeaderType,
      this.labReportPatientDetailType,
      this.labReportFooterType,
      this.labReportTopMargin,
      this.labReportBottomMargin,
      this.procedureReportHeaderType,
      this.procedureReportFooterType,
      this.procedureReportTopMargin,
      this.procedureReportBottomMargin,
      this.deathCertificateHeaderType,
      this.deathCertificateFooterType,
      this.deathCertificateTopMargin,
      this.deathCertificateBottomMargin,
      this.isEnglishDonorQuestionnaire,
      this.isOnlyVerifiedReportsPrintable,
      this.isUrduDonorQuestionnaire,
      this.donorAffidavitInEnglish,
      this.donorAffidavitInUrdu,
      this.isEmailNotificationEnabled,
      this.isSMSNotificationEnabled,
      this.isPushNotificationEnabled,
      this.isShowBioRadAffiliation,
      this.isShowPatientAppQRDetail,
      this.inventoryInTransitionAccountId,
      this.microDrugDisplayType,
      this.dayClosingCashAccountId,
      this.dayClosingRevenueAccountId,
      this.dayClosingCreditAccountId,
      this.isHideTotalItemsAvailableWhilePlacingDemandRequest,
      this.isApplyEmployeePayrollRestriction,
      this.isApplyDoctorFollowUpConsultancyFeeFeature,
      this.isAllowCreditAmount,
      this.maxCreditAllowed,
      this.isApplyDiscountRestriction,
      this.isHideChargesInIPDMedicineReportForRegularPatient,
      this.challanFormReportPrintCopyType,
      this.labChallanFormReportPrintCopyType,
      this.isRestrictedDataEnteryVerifiedChallansCancellation,
      this.displayPatientVaultDataTableInfo,
      this.isCustomPanelEntitleVisit,
      this.defaultSubServiceId,
      this.defaultAttributeNameId,
      this.isShowDifferentLabChallansAsCombinedOne,
      this.dashboardServicesConsumptionDisplayType,
      this.emptyHeaderNormalSpacing,
      this.emptyHeaderQRCodeSpacing,
      this.noLogoPatientDetailTopMargin,
      this.labReportHeaderTopMargin,
      this.labReportFooterBottomMargin,
      this.labReportHeaderHeadingFont,
      this.labReportHeaderTextFont,
      this.labReportHeaderImagePath,
      this.labReportFooterImagePath,
      this.labReportFooterText,
      this.isVerifyPhoneNumberforPatientSignUp,
      this.subServiceList,
      this.consentFormAttachment,
      this.prescriptionReportEmptyHeaderSpacing,
      this.isDisplayCompletePatientNameInPrescription,
      this.isLabReportDateTimeAdjustable,
      this.isShowOnlyPatientPersonalNameInLabReport,
      this.isShowIHCPatientAppQRCode,
      this.isShowOnlineOfflineLabel,
      this.isHidePrintedByLabReport,
      this.isShowPendingCreditAmountInCashFlowReport,
      this.qRCodeHeight,
      this.isCalculateDoctorServiceShareOnDiscountedBookings,
      this.isTokenNumberEnabled,
      this.isOPDQueueSysEnabled,
      this.isShowRoomWithToken,
      this.isERXDiagnosisMandatory,
      this.isERXComplaintMandatory,
      this.isERXBPMandatory,
      this.isERXPulseMandatory,
      this.isDischargeComplaintMandatory,
      this.isDischargePulseMandatory,
      this.isDischargeBPMandatory,
      this.isDischargeDiagnosisMandatory,
      this.isOpenEmptyERXOnCheckin,
      this.isCreateNewChallanOnUpdatingDoctorChallanForms,
      this.isDoctorCheckInPaymentAmountIncreaseable,
      this.isIPDServicesPriceEditable,
      this.medicineDisplayType,
      this.isApplyRefundOverflowRestriction,
      this.isRestrictNursesListInNursingNotesWithLoggedInNurse,
      this.birthCertificateHeaderType,
      this.birthCertificateFooterType,
      this.birthCertificateTopMargin,
      this.birthCertificateBottomMargin,
      this.isEnableLocationatPatientCheckIn,
      this.isDisplayBookingReferenceDetailsAtPatientCheckIn,
      this.isShowTotalChargesSumInCashFlowReport,
      this.isShowHospitalShareInCashFlowReport,
      this.isReferralPanelBookingEnabled,
      this.labBarCodeType,
      this.isDisplayWaterMarkOnDischargeReport,
      this.isDisplayWaterMarkDisplayTypeOnDischargeReport,
      this.waterMarkTextForDischargeReport,
      this.imageWaterMarkPath,
      this.isDisplayWaterMarkOnDiagnosticReport,
      this.isDisplayWaterMarkDisplayTypeOnDiagnosticReport,
      this.waterMarkTextOnDiagnosticReport,
      this.imageWaterMarkPathOnDiagnosticReport,
      this.isDisplayWaterMarkOnLabReports,
      this.isDisplayWaterMarkDisplayTypeOnLabReports,
      this.waterMarkTextOnLabReports,
      this.imageWaterMarkPathOnLabReports,
      this.isDisplayVerifiedByDoctorListOnLabReportVerification,
      this.isDisplayVerifiedByInformationOnLabReports,
      this.isDisplayOnlyLastVerifiedByInformationOnLabReports,
      this.isStrongPasswordConfigurationEnabled,
      this.dynamicIdentityNoLabel,
      this.mobileNoDynamicPlaceHolder,
      this.dynamicMaskingForIdentityNumber,
      this.dynamicNumberOfDigitsForIdentityNumber,
      this.isShowMobileAppLoginQRCodeOnMRCard,
      this.isShowTokenNoWithAppointmentNo,
      this.receiptQRCodeType,
      this.isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport,
      this.noteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport,
      this.isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport,
      this.noteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport,
      this.isWhatsAppNotificationEnabled,
      this.vATPercentageAmount,
      this.isDisplayVATAmount,
      this.contactNoDynamicLabel,
      this.doctorRegistrationNoDynamicLabel,
      this.taxNoDynamicLabel,
      this.isDisplayOEPFormDetailAtPatientCheckIn,
      this.labBookingSMSFormatWithCredit,
      this.labBookingSMSFormatWithoutCredit,
      this.labFirstReportVerificationSMSFormatWithCredit,
      this.labFirstReportVerificationSMSFormatWithoutCredit,
      this.labLastReportVerificationSMSFormatWithCredit,
      this.labLastReportVerificationSMSFormatWithoutCredit,
      this.defaultLabReportVerificationSMSFormatWithCredit,
      this.defaultLabReportVerificationSMSFormatWithoutCredit,
      this.customLanguageKeyBoardType,
      this.followUpListOrderByType,
      this.itemNameDisplayTypeInPurchaseOrderDetail,
      this.isDisplayReligionAndMaritalStatusOnLabReceipts,
      this.dynamicPanelKeyword,
      this.isDisplayAppointmentBookingInterfaceAfterPatientRegistration,
      this.isDisplayHeadCircumferenceAndBSRInVitals,
      this.healthCoordinatorsContactNumbers,
      this.geolocationFilteringDistance,
      this.isApplyGeolocationFilterOnLabAppointments,
      this.isNonHospitalOrganization,
      this.dehydrationAvoidanceReminderInterval,
      this.dehydrationAvoidanceReminderIntervalId,
      this.tirednessAvoidanceReminderInterval,
      this.tirednessAvoidanceReminderIntervalId,
      this.isHighlightInsuranceCoveredForMedicines,
      this.isDisplayAllergyAlertPopupInititally,
      this.isDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface,
      this.isDisableAutoPrintingofEmergencyChallan,
      this.isDisableAutoPrintingofDepartmentChallan,
      this.isDisableAutoPrintingofDoctorChallan,
      this.isDisableAutoPrintingofLabChallan,
      this.isDisableAutoPrintingofProcedureChallan,
      this.isDisableAutoPrintingofBloodDonationChallan,
      this.isDisableAutoPrintingofMiscServicesChallan,
      this.isDisableAutoOpeningOfPrescriptionReport,
      this.isDisableAutoOpeningofDischargeReport,
      this.sMSSendingTypeForDoctorAppointment,
      this.isLabInternalNotificationEnabled,
      this.isHideAdditionalInsuranceDetailsAtPatientRegistration,
      this.isShowAirlineDetailAtCheckInInterface,
      this.isDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface,
      this.isShowCardDetailsWithCashPaymentTypeWhileBillReceiving,
      this.isDisplayVATAmountInCashFlow,
      this.isHideTypeInCheckIn,
      this.isHideCheckInToInCheckIn,
      this.isHidePrescribedByInCheckIn,
      this.isHideDoctorInCheckIn,
      this.isHideBookingSlipPrescriptionInCheckIn,
      this.isHideDepartmentInCheckIn,
      this.isHideServiceCategoryinCheckIn,
      this.isHideAirlineInCheckIn,
      this.isHideSMSAlertInCheckIn,
      this.isHideSampleReceivedInCheckIn,
      this.isHideShareEntityInCheckIn,
      this.isHideDiscountInCheckIn,
      this.isHideAdvisedByInCheckIn,
      this.isHideBranchLocationInCheckIn,
      this.isHideAdvanceSecurityInCheckIn,
      this.isHidePaymentMethodInCheckIn,
      this.isHideVIPBookingInCheckIn,
      this.isHideSampleCollectionStickerInCheckIn,
      this.isHideVoucherCouponInCheckIn,
      this.procurementTermAndConditions,
      this.isProviderSetting,
      this.isDisplayAppointmentButton,
      this.contingentBillStamp,
      this.whatsAppNotificationMessage,
      this.isDisplayFooterTextonThermalReceiptType,
      this.isDisplayReportingTimeonLabReports,
      this.isDisplayAsteriskwithReferenceNumber,
      this.applyRestrictionOfMPLatDemandRequest,
      this.dynamicRegistrationDateLabel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    virtualUserId = json['VirtualUserId'];
    batchingType = json['BatchingType'];
    isMondayWorkingDay = json['IsMondayWorkingDay'];
    mondayStartingTime = json['MondayStartingTime'];
    mondayClosingTime = json['MondayClosingTime'];
    isTuesdayWorkingDay = json['IsTuesdayWorkingDay'];
    tuesdayStartingTime = json['TuesdayStartingTime'];
    tuesdayClosingTime = json['TuesdayClosingTime'];
    isWednesdayWorkingDay = json['IsWednesdayWorkingDay'];
    wednesdayStartingTime = json['WednesdayStartingTime'];
    wednesdayClosingTime = json['WednesdayClosingTime'];
    isThursdayWorkingDay = json['IsThursdayWorkingDay'];
    thursdayStartingTime = json['ThursdayStartingTime'];
    thursdayClosingTime = json['ThursdayClosingTime'];
    isFridayWorkingDay = json['IsFridayWorkingDay'];
    fridayStartingTime = json['FridayStartingTime'];
    fridayClosingTime = json['FridayClosingTime'];
    isSaturdayWorkingDay = json['IsSaturdayWorkingDay'];
    saturdayStartingTime = json['SaturdayStartingTime'];
    saturdayClosingTime = json['SaturdayClosingTime'];
    isSundayWorkingDay = json['IsSundayWorkingDay'];
    sundayStartingTime = json['SundayStartingTime'];
    sundayClosingTime = json['SundayClosingTime'];
    mRcardType = json['MRcardType'];
    receiptType = json['ReceiptType'];
    labReceiptType = json['LabReceiptType'];
    diagnosticsReceiptType = json['DiagnosticsReceiptType'];
    patientReceiptCopy = json['PatientReceiptCopy'];
    accountantReceiptCopy = json['AccountantReceiptCopy'];
    departmentReceiptCopy = json['DepartmentReceiptCopy'];
    hospitalStatisticsSummaryIds = json['HospitalStatisticsSummaryIds'];
    todaySummaryIds = json['TodaySummaryIds'];
    prescriptionHeaderType = json['PrescriptionHeaderType'];
    prescriptionFooterType = json['PrescriptionFooterType'];
    branchPrescriptionStamp = json['BranchPrescriptionStamp'];
    prescriptionTopMargin = json['PrescriptionTopMargin'];
    prescriptionBottomMargin = json['PrescriptionBottomMargin'];
    dischargeHeaderType = json['DischargeHeaderType'];
    dischargeFooterType = json['DischargeFooterType'];
    dischargeTopMargin = json['DischargeTopMargin'];
    dischargeBottomMargin = json['DischargeBottomMargin'];
    labReportHeaderType = json['LabReportHeaderType'];
    labReportPatientDetailType = json['LabReportPatientDetailType'];
    labReportFooterType = json['LabReportFooterType'];
    labReportTopMargin = json['LabReportTopMargin'];
    labReportBottomMargin = json['LabReportBottomMargin'];
    procedureReportHeaderType = json['ProcedureReportHeaderType'];
    procedureReportFooterType = json['ProcedureReportFooterType'];
    procedureReportTopMargin = json['ProcedureReportTopMargin'];
    procedureReportBottomMargin = json['ProcedureReportBottomMargin'];
    deathCertificateHeaderType = json['DeathCertificateHeaderType'];
    deathCertificateFooterType = json['DeathCertificateFooterType'];
    deathCertificateTopMargin = json['DeathCertificateTopMargin'];
    deathCertificateBottomMargin = json['DeathCertificateBottomMargin'];
    isEnglishDonorQuestionnaire = json['IsEnglishDonorQuestionnaire'];
    isOnlyVerifiedReportsPrintable = json['IsOnlyVerifiedReportsPrintable'];
    isUrduDonorQuestionnaire = json['IsUrduDonorQuestionnaire'];
    donorAffidavitInEnglish = json['DonorAffidavitInEnglish'];
    donorAffidavitInUrdu = json['DonorAffidavitInUrdu'];
    isEmailNotificationEnabled = json['IsEmailNotificationEnabled'];
    isSMSNotificationEnabled = json['IsSMSNotificationEnabled'];
    isPushNotificationEnabled = json['IsPushNotificationEnabled'];
    isShowBioRadAffiliation = json['IsShowBioRadAffiliation'];
    isShowPatientAppQRDetail = json['IsShowPatientAppQRDetail'];
    inventoryInTransitionAccountId = json['InventoryInTransitionAccountId'];
    microDrugDisplayType = json['MicroDrugDisplayType'];
    dayClosingCashAccountId = json['DayClosingCashAccountId'];
    dayClosingRevenueAccountId = json['DayClosingRevenueAccountId'];
    dayClosingCreditAccountId = json['DayClosingCreditAccountId'];
    isHideTotalItemsAvailableWhilePlacingDemandRequest =
        json['IsHideTotalItemsAvailableWhilePlacingDemandRequest'];
    isApplyEmployeePayrollRestriction =
        json['IsApplyEmployeePayrollRestriction'];
    isApplyDoctorFollowUpConsultancyFeeFeature =
        json['IsApplyDoctorFollowUpConsultancyFeeFeature'];
    isAllowCreditAmount = json['IsAllowCreditAmount'];
    maxCreditAllowed = json['MaxCreditAllowed'];
    isApplyDiscountRestriction = json['IsApplyDiscountRestriction'];
    isHideChargesInIPDMedicineReportForRegularPatient =
        json['IsHideChargesInIPDMedicineReportForRegularPatient'];
    challanFormReportPrintCopyType = json['ChallanFormReportPrintCopyType'];
    labChallanFormReportPrintCopyType =
        json['LabChallanFormReportPrintCopyType'];
    isRestrictedDataEnteryVerifiedChallansCancellation =
        json['IsRestrictedDataEnteryVerifiedChallansCancellation'];
    displayPatientVaultDataTableInfo = json['DisplayPatientVaultDataTableInfo'];
    isCustomPanelEntitleVisit = json['IsCustomPanelEntitleVisit'];
    defaultSubServiceId = json['DefaultSubServiceId'];
    defaultAttributeNameId = json['DefaultAttributeNameId'];
    isShowDifferentLabChallansAsCombinedOne =
        json['IsShowDifferentLabChallansAsCombinedOne'];
    dashboardServicesConsumptionDisplayType =
        json['DashboardServicesConsumptionDisplayType'];
    emptyHeaderNormalSpacing = json['EmptyHeaderNormalSpacing'];
    emptyHeaderQRCodeSpacing = json['EmptyHeaderQRCodeSpacing'];
    noLogoPatientDetailTopMargin = json['NoLogoPatientDetailTopMargin'];
    labReportHeaderTopMargin = json['LabReportHeaderTopMargin'];
    labReportFooterBottomMargin = json['LabReportFooterBottomMargin'];
    labReportHeaderHeadingFont = json['LabReportHeaderHeadingFont'];
    labReportHeaderTextFont = json['LabReportHeaderTextFont'];
    labReportHeaderImagePath = json['LabReportHeaderImagePath'];
    labReportFooterImagePath = json['LabReportFooterImagePath'];
    labReportFooterText = json['LabReportFooterText'];
    isVerifyPhoneNumberforPatientSignUp =
        json['IsVerifyPhoneNumberforPatientSignUp'];
    subServiceList = json['SubServiceList'];
    consentFormAttachment = json['ConsentFormAttachment'];
    prescriptionReportEmptyHeaderSpacing =
        json['PrescriptionReportEmptyHeaderSpacing'];
    isDisplayCompletePatientNameInPrescription =
        json['IsDisplayCompletePatientNameInPrescription'];
    isLabReportDateTimeAdjustable = json['IsLabReportDateTimeAdjustable'];
    isShowOnlyPatientPersonalNameInLabReport =
        json['IsShowOnlyPatientPersonalNameInLabReport'];
    isShowIHCPatientAppQRCode = json['IsShowIHCPatientAppQRCode'];
    isShowOnlineOfflineLabel = json['IsShowOnlineOfflineLabel'];
    isHidePrintedByLabReport = json['IsHidePrintedByLabReport'];
    isShowPendingCreditAmountInCashFlowReport =
        json['IsShowPendingCreditAmountInCashFlowReport'];
    qRCodeHeight = json['QRCodeHeight'];
    isCalculateDoctorServiceShareOnDiscountedBookings =
        json['IsCalculateDoctorServiceShareOnDiscountedBookings'];
    isTokenNumberEnabled = json['IsTokenNumberEnabled'];
    isOPDQueueSysEnabled = json['IsOPDQueueSysEnabled'];
    isShowRoomWithToken = json['IsShowRoomWithToken'];
    isERXDiagnosisMandatory = json['IsERXDiagnosisMandatory'];
    isERXComplaintMandatory = json['IsERXComplaintMandatory'];
    isERXBPMandatory = json['IsERXBPMandatory'];
    isERXPulseMandatory = json['IsERXPulseMandatory'];
    isDischargeComplaintMandatory = json['IsDischargeComplaintMandatory'];
    isDischargePulseMandatory = json['IsDischargePulseMandatory'];
    isDischargeBPMandatory = json['IsDischargeBPMandatory'];
    isDischargeDiagnosisMandatory = json['IsDischargeDiagnosisMandatory'];
    isOpenEmptyERXOnCheckin = json['IsOpenEmptyERXOnCheckin'];
    isCreateNewChallanOnUpdatingDoctorChallanForms =
        json['IsCreateNewChallanOnUpdatingDoctor_ChallanForms'];
    isDoctorCheckInPaymentAmountIncreaseable =
        json['IsDoctorCheckInPaymentAmountIncreaseable'];
    isIPDServicesPriceEditable = json['IsIPDServicesPriceEditable'];
    medicineDisplayType = json['MedicineDisplayType'];
    isApplyRefundOverflowRestriction = json['IsApplyRefundOverflowRestriction'];
    isRestrictNursesListInNursingNotesWithLoggedInNurse =
        json['IsRestrictNursesListInNursingNotesWithLoggedInNurse'];
    birthCertificateHeaderType = json['BirthCertificateHeaderType'];
    birthCertificateFooterType = json['BirthCertificateFooterType'];
    birthCertificateTopMargin = json['BirthCertificateTopMargin'];
    birthCertificateBottomMargin = json['BirthCertificateBottomMargin'];
    isEnableLocationatPatientCheckIn = json['IsEnableLocationatPatientCheckIn'];
    isDisplayBookingReferenceDetailsAtPatientCheckIn =
        json['IsDisplayBookingReferenceDetailsAtPatientCheckIn'];
    isShowTotalChargesSumInCashFlowReport =
        json['IsShowTotalChargesSumInCashFlowReport'];
    isShowHospitalShareInCashFlowReport =
        json['IsShowHospitalShareInCashFlowReport'];
    isReferralPanelBookingEnabled = json['IsReferralPanelBookingEnabled'];
    labBarCodeType = json['LabBarCodeType'];
    isDisplayWaterMarkOnDischargeReport =
        json['IsDisplayWaterMarkOnDischargeReport'];
    isDisplayWaterMarkDisplayTypeOnDischargeReport =
        json['IsDisplayWaterMarkDisplayTypeOnDischargeReport'];
    waterMarkTextForDischargeReport = json['WaterMarkTextForDischargeReport'];
    imageWaterMarkPath = json['ImageWaterMarkPath'];
    isDisplayWaterMarkOnDiagnosticReport =
        json['IsDisplayWaterMarkOnDiagnosticReport'];
    isDisplayWaterMarkDisplayTypeOnDiagnosticReport =
        json['IsDisplayWaterMarkDisplayTypeOnDiagnosticReport'];
    waterMarkTextOnDiagnosticReport = json['WaterMarkTextOnDiagnosticReport'];
    imageWaterMarkPathOnDiagnosticReport =
        json['ImageWaterMarkPathOnDiagnosticReport'];
    isDisplayWaterMarkOnLabReports = json['IsDisplayWaterMarkOnLabReports'];
    isDisplayWaterMarkDisplayTypeOnLabReports =
        json['IsDisplayWaterMarkDisplayTypeOnLabReports'];
    waterMarkTextOnLabReports = json['WaterMarkTextOnLabReports'];
    imageWaterMarkPathOnLabReports = json['ImageWaterMarkPathOnLabReports'];
    isDisplayVerifiedByDoctorListOnLabReportVerification =
        json['IsDisplayVerifiedByDoctorListOnLabReportVerification'];
    isDisplayVerifiedByInformationOnLabReports =
        json['IsDisplayVerifiedByInformationOnLabReports'];
    isDisplayOnlyLastVerifiedByInformationOnLabReports =
        json['IsDisplayOnlyLastVerifiedByInformationOnLabReports'];
    isStrongPasswordConfigurationEnabled =
        json['IsStrongPasswordConfigurationEnabled'];
    dynamicIdentityNoLabel = json['DynamicIdentityNoLabel'];
    mobileNoDynamicPlaceHolder = json['MobileNoDynamicPlaceHolder'];
    dynamicMaskingForIdentityNumber = json['DynamicMaskingForIdentityNumber'];
    dynamicNumberOfDigitsForIdentityNumber =
        json['DynamicNumberOfDigitsForIdentityNumber'];
    isShowMobileAppLoginQRCodeOnMRCard =
        json['IsShowMobileAppLoginQRCodeOnMRCard'];
    isShowTokenNoWithAppointmentNo = json['IsShowTokenNoWithAppointmentNo'];
    receiptQRCodeType = json['ReceiptQRCodeType'];
    isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport = json[
        'IsDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport'];
    noteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport = json[
        'NoteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport'];
    isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport = json[
        'IsDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport'];
    noteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport =
        json['NoteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport'];
    isWhatsAppNotificationEnabled = json['IsWhatsAppNotificationEnabled'];
    vATPercentageAmount = json['VATPercentageAmount'];
    isDisplayVATAmount = json['IsDisplayVATAmount'];
    contactNoDynamicLabel = json['ContactNoDynamicLabel'];
    doctorRegistrationNoDynamicLabel = json['DoctorRegistrationNoDynamicLabel'];
    taxNoDynamicLabel = json['TaxNoDynamicLabel'];
    isDisplayOEPFormDetailAtPatientCheckIn =
        json['IsDisplayOEPFormDetailAtPatientCheckIn'];
    labBookingSMSFormatWithCredit = json['LabBookingSMSFormatWithCredit'];
    labBookingSMSFormatWithoutCredit = json['LabBookingSMSFormatWithoutCredit'];
    labFirstReportVerificationSMSFormatWithCredit =
        json['LabFirstReportVerificationSMSFormatWithCredit'];
    labFirstReportVerificationSMSFormatWithoutCredit =
        json['LabFirstReportVerificationSMSFormatWithoutCredit'];
    labLastReportVerificationSMSFormatWithCredit =
        json['LabLastReportVerificationSMSFormatWithCredit'];
    labLastReportVerificationSMSFormatWithoutCredit =
        json['LabLastReportVerificationSMSFormatWithoutCredit'];
    defaultLabReportVerificationSMSFormatWithCredit =
        json['DefaultLabReportVerificationSMSFormatWithCredit'];
    defaultLabReportVerificationSMSFormatWithoutCredit =
        json['DefaultLabReportVerificationSMSFormatWithoutCredit'];
    customLanguageKeyBoardType = json['CustomLanguageKeyBoardType'];
    followUpListOrderByType = json['FollowUpListOrderByType'];
    itemNameDisplayTypeInPurchaseOrderDetail =
        json['ItemNameDisplayTypeInPurchaseOrderDetail'];
    isDisplayReligionAndMaritalStatusOnLabReceipts =
        json['IsDisplayReligionAndMaritalStatusOnLabReceipts'];
    dynamicPanelKeyword = json['DynamicPanelKeyword'];
    isDisplayAppointmentBookingInterfaceAfterPatientRegistration =
        json['IsDisplayAppointmentBookingInterfaceAfterPatientRegistration'];
    isDisplayHeadCircumferenceAndBSRInVitals =
        json['IsDisplayHeadCircumferenceAndBSRInVitals'];
    healthCoordinatorsContactNumbers = json['HealthCoordinatorsContactNumbers'];
    geolocationFilteringDistance = json['GeolocationFilteringDistance'];
    isApplyGeolocationFilterOnLabAppointments =
        json['IsApplyGeolocationFilterOnLabAppointments'];
    isNonHospitalOrganization = json['IsNonHospitalOrganization'];
    dehydrationAvoidanceReminderInterval =
        json['DehydrationAvoidanceReminderInterval'];
    dehydrationAvoidanceReminderIntervalId =
        json['DehydrationAvoidanceReminderIntervalId'];
    tirednessAvoidanceReminderInterval =
        json['TirednessAvoidanceReminderInterval'];
    tirednessAvoidanceReminderIntervalId =
        json['TirednessAvoidanceReminderIntervalId'];
    isHighlightInsuranceCoveredForMedicines =
        json['IsHighlightInsuranceCoveredForMedicines'];
    isDisplayAllergyAlertPopupInititally =
        json['IsDisplayAllergyAlertPopupInititally'];
    isDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface =
        json['IsDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface'];
    isDisableAutoPrintingofEmergencyChallan =
        json['IsDisableAutoPrintingofEmergencyChallan'];
    isDisableAutoPrintingofDepartmentChallan =
        json['IsDisableAutoPrintingofDepartmentChallan'];
    isDisableAutoPrintingofDoctorChallan =
        json['IsDisableAutoPrintingofDoctorChallan'];
    isDisableAutoPrintingofLabChallan =
        json['IsDisableAutoPrintingofLabChallan'];
    isDisableAutoPrintingofProcedureChallan =
        json['IsDisableAutoPrintingofProcedureChallan'];
    isDisableAutoPrintingofBloodDonationChallan =
        json['IsDisableAutoPrintingofBloodDonationChallan'];
    isDisableAutoPrintingofMiscServicesChallan =
        json['IsDisableAutoPrintingofMiscServicesChallan'];
    isDisableAutoOpeningOfPrescriptionReport =
        json['IsDisableAutoOpeningOfPrescriptionReport'];
    isDisableAutoOpeningofDischargeReport =
        json['IsDisableAutoOpeningofDischargeReport'];
    sMSSendingTypeForDoctorAppointment =
        json['SMSSendingTypeForDoctorAppointment'];
    isLabInternalNotificationEnabled = json['IsLabInternalNotificationEnabled'];
    isHideAdditionalInsuranceDetailsAtPatientRegistration =
        json['IsHideAdditionalInsuranceDetailsAtPatientRegistration'];
    isShowAirlineDetailAtCheckInInterface =
        json['IsShowAirlineDetailAtCheckInInterface'];
    isDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface =
        json['IsDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface'];
    isShowCardDetailsWithCashPaymentTypeWhileBillReceiving =
        json['IsShowCardDetailsWithCashPaymentTypeWhileBillReceiving'];
    isDisplayVATAmountInCashFlow = json['IsDisplayVATAmountInCashFlow'];
    isHideTypeInCheckIn = json['isHideTypeInCheckIn'];
    isHideCheckInToInCheckIn = json['isHideCheckInToInCheckIn'];
    isHidePrescribedByInCheckIn = json['isHidePrescribedByInCheckIn'];
    isHideDoctorInCheckIn = json['isHideDoctorInCheckIn'];
    isHideBookingSlipPrescriptionInCheckIn =
        json['isHideBookingSlipPrescriptionInCheckIn'];
    isHideDepartmentInCheckIn = json['isHideDepartmentInCheckIn'];
    isHideServiceCategoryinCheckIn = json['isHideServiceCategoryinCheckIn'];
    isHideAirlineInCheckIn = json['isHideAirlineInCheckIn'];
    isHideSMSAlertInCheckIn = json['isHideSMSAlertInCheckIn'];
    isHideSampleReceivedInCheckIn = json['isHideSampleReceivedInCheckIn'];
    isHideShareEntityInCheckIn = json['isHideShareEntityInCheckIn'];
    isHideDiscountInCheckIn = json['isHideDiscountInCheckIn'];
    isHideAdvisedByInCheckIn = json['isHideAdvisedByInCheckIn'];
    isHideBranchLocationInCheckIn = json['isHideBranchLocationInCheckIn'];
    isHideAdvanceSecurityInCheckIn = json['isHideAdvanceSecurityInCheckIn'];
    isHidePaymentMethodInCheckIn = json['isHidePaymentMethodInCheckIn'];
    isHideVIPBookingInCheckIn = json['isHideVIPBookingInCheckIn'];
    isHideSampleCollectionStickerInCheckIn =
        json['isHideSampleCollectionStickerInCheckIn'];
    isHideVoucherCouponInCheckIn = json['isHideVoucherCouponInCheckIn'];
    procurementTermAndConditions = json['ProcurementTermAndConditions'];
    isProviderSetting = json['IsProviderSetting'];
    isDisplayAppointmentButton = json['IsDisplayAppointmentButton'];
    contingentBillStamp = json['ContingentBillStamp'];
    whatsAppNotificationMessage = json['WhatsAppNotificationMessage'];
    isDisplayFooterTextonThermalReceiptType =
        json['IsDisplayFooterTextonThermalReceiptType'];
    isDisplayReportingTimeonLabReports =
        json['IsDisplayReportingTimeonLabReports'];
    isDisplayAsteriskwithReferenceNumber =
        json['IsDisplayAsteriskwithReferenceNumber'];
    applyRestrictionOfMPLatDemandRequest =
        json['ApplyRestrictionOfMPLatDemandRequest'];
    dynamicRegistrationDateLabel = json['DynamicRegistrationDateLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['VirtualUserId'] = virtualUserId;
    data['BatchingType'] = batchingType;
    data['IsMondayWorkingDay'] = isMondayWorkingDay;
    data['MondayStartingTime'] = mondayStartingTime;
    data['MondayClosingTime'] = mondayClosingTime;
    data['IsTuesdayWorkingDay'] = isTuesdayWorkingDay;
    data['TuesdayStartingTime'] = tuesdayStartingTime;
    data['TuesdayClosingTime'] = tuesdayClosingTime;
    data['IsWednesdayWorkingDay'] = isWednesdayWorkingDay;
    data['WednesdayStartingTime'] = wednesdayStartingTime;
    data['WednesdayClosingTime'] = wednesdayClosingTime;
    data['IsThursdayWorkingDay'] = isThursdayWorkingDay;
    data['ThursdayStartingTime'] = thursdayStartingTime;
    data['ThursdayClosingTime'] = thursdayClosingTime;
    data['IsFridayWorkingDay'] = isFridayWorkingDay;
    data['FridayStartingTime'] = fridayStartingTime;
    data['FridayClosingTime'] = fridayClosingTime;
    data['IsSaturdayWorkingDay'] = isSaturdayWorkingDay;
    data['SaturdayStartingTime'] = saturdayStartingTime;
    data['SaturdayClosingTime'] = saturdayClosingTime;
    data['IsSundayWorkingDay'] = isSundayWorkingDay;
    data['SundayStartingTime'] = sundayStartingTime;
    data['SundayClosingTime'] = sundayClosingTime;
    data['MRcardType'] = mRcardType;
    data['ReceiptType'] = receiptType;
    data['LabReceiptType'] = labReceiptType;
    data['DiagnosticsReceiptType'] = diagnosticsReceiptType;
    data['PatientReceiptCopy'] = patientReceiptCopy;
    data['AccountantReceiptCopy'] = accountantReceiptCopy;
    data['DepartmentReceiptCopy'] = departmentReceiptCopy;
    data['HospitalStatisticsSummaryIds'] = hospitalStatisticsSummaryIds;
    data['TodaySummaryIds'] = todaySummaryIds;
    data['PrescriptionHeaderType'] = prescriptionHeaderType;
    data['PrescriptionFooterType'] = prescriptionFooterType;
    data['BranchPrescriptionStamp'] = branchPrescriptionStamp;
    data['PrescriptionTopMargin'] = prescriptionTopMargin;
    data['PrescriptionBottomMargin'] = prescriptionBottomMargin;
    data['DischargeHeaderType'] = dischargeHeaderType;
    data['DischargeFooterType'] = dischargeFooterType;
    data['DischargeTopMargin'] = dischargeTopMargin;
    data['DischargeBottomMargin'] = dischargeBottomMargin;
    data['LabReportHeaderType'] = labReportHeaderType;
    data['LabReportPatientDetailType'] = labReportPatientDetailType;
    data['LabReportFooterType'] = labReportFooterType;
    data['LabReportTopMargin'] = labReportTopMargin;
    data['LabReportBottomMargin'] = labReportBottomMargin;
    data['ProcedureReportHeaderType'] = procedureReportHeaderType;
    data['ProcedureReportFooterType'] = procedureReportFooterType;
    data['ProcedureReportTopMargin'] = procedureReportTopMargin;
    data['ProcedureReportBottomMargin'] = procedureReportBottomMargin;
    data['DeathCertificateHeaderType'] = deathCertificateHeaderType;
    data['DeathCertificateFooterType'] = deathCertificateFooterType;
    data['DeathCertificateTopMargin'] = deathCertificateTopMargin;
    data['DeathCertificateBottomMargin'] = deathCertificateBottomMargin;
    data['IsEnglishDonorQuestionnaire'] = isEnglishDonorQuestionnaire;
    data['IsOnlyVerifiedReportsPrintable'] = isOnlyVerifiedReportsPrintable;
    data['IsUrduDonorQuestionnaire'] = isUrduDonorQuestionnaire;
    data['DonorAffidavitInEnglish'] = donorAffidavitInEnglish;
    data['DonorAffidavitInUrdu'] = donorAffidavitInUrdu;
    data['IsEmailNotificationEnabled'] = isEmailNotificationEnabled;
    data['IsSMSNotificationEnabled'] = isSMSNotificationEnabled;
    data['IsPushNotificationEnabled'] = isPushNotificationEnabled;
    data['IsShowBioRadAffiliation'] = isShowBioRadAffiliation;
    data['IsShowPatientAppQRDetail'] = isShowPatientAppQRDetail;
    data['InventoryInTransitionAccountId'] = inventoryInTransitionAccountId;
    data['MicroDrugDisplayType'] = microDrugDisplayType;
    data['DayClosingCashAccountId'] = dayClosingCashAccountId;
    data['DayClosingRevenueAccountId'] = dayClosingRevenueAccountId;
    data['DayClosingCreditAccountId'] = dayClosingCreditAccountId;
    data['IsHideTotalItemsAvailableWhilePlacingDemandRequest'] =
        isHideTotalItemsAvailableWhilePlacingDemandRequest;
    data['IsApplyEmployeePayrollRestriction'] =
        isApplyEmployeePayrollRestriction;
    data['IsApplyDoctorFollowUpConsultancyFeeFeature'] =
        isApplyDoctorFollowUpConsultancyFeeFeature;
    data['IsAllowCreditAmount'] = isAllowCreditAmount;
    data['MaxCreditAllowed'] = maxCreditAllowed;
    data['IsApplyDiscountRestriction'] = isApplyDiscountRestriction;
    data['IsHideChargesInIPDMedicineReportForRegularPatient'] =
        isHideChargesInIPDMedicineReportForRegularPatient;
    data['ChallanFormReportPrintCopyType'] = challanFormReportPrintCopyType;
    data['LabChallanFormReportPrintCopyType'] =
        labChallanFormReportPrintCopyType;
    data['IsRestrictedDataEnteryVerifiedChallansCancellation'] =
        isRestrictedDataEnteryVerifiedChallansCancellation;
    data['DisplayPatientVaultDataTableInfo'] = displayPatientVaultDataTableInfo;
    data['IsCustomPanelEntitleVisit'] = isCustomPanelEntitleVisit;
    data['DefaultSubServiceId'] = defaultSubServiceId;
    data['DefaultAttributeNameId'] = defaultAttributeNameId;
    data['IsShowDifferentLabChallansAsCombinedOne'] =
        isShowDifferentLabChallansAsCombinedOne;
    data['DashboardServicesConsumptionDisplayType'] =
        dashboardServicesConsumptionDisplayType;
    data['EmptyHeaderNormalSpacing'] = emptyHeaderNormalSpacing;
    data['EmptyHeaderQRCodeSpacing'] = emptyHeaderQRCodeSpacing;
    data['NoLogoPatientDetailTopMargin'] = noLogoPatientDetailTopMargin;
    data['LabReportHeaderTopMargin'] = labReportHeaderTopMargin;
    data['LabReportFooterBottomMargin'] = labReportFooterBottomMargin;
    data['LabReportHeaderHeadingFont'] = labReportHeaderHeadingFont;
    data['LabReportHeaderTextFont'] = labReportHeaderTextFont;
    data['LabReportHeaderImagePath'] = labReportHeaderImagePath;
    data['LabReportFooterImagePath'] = labReportFooterImagePath;
    data['LabReportFooterText'] = labReportFooterText;
    data['IsVerifyPhoneNumberforPatientSignUp'] =
        isVerifyPhoneNumberforPatientSignUp;
    data['SubServiceList'] = subServiceList;
    data['ConsentFormAttachment'] = consentFormAttachment;
    data['PrescriptionReportEmptyHeaderSpacing'] =
        prescriptionReportEmptyHeaderSpacing;
    data['IsDisplayCompletePatientNameInPrescription'] =
        isDisplayCompletePatientNameInPrescription;
    data['IsLabReportDateTimeAdjustable'] = isLabReportDateTimeAdjustable;
    data['IsShowOnlyPatientPersonalNameInLabReport'] =
        isShowOnlyPatientPersonalNameInLabReport;
    data['IsShowIHCPatientAppQRCode'] = isShowIHCPatientAppQRCode;
    data['IsShowOnlineOfflineLabel'] = isShowOnlineOfflineLabel;
    data['IsHidePrintedByLabReport'] = isHidePrintedByLabReport;
    data['IsShowPendingCreditAmountInCashFlowReport'] =
        isShowPendingCreditAmountInCashFlowReport;
    data['QRCodeHeight'] = qRCodeHeight;
    data['IsCalculateDoctorServiceShareOnDiscountedBookings'] =
        isCalculateDoctorServiceShareOnDiscountedBookings;
    data['IsTokenNumberEnabled'] = isTokenNumberEnabled;
    data['IsOPDQueueSysEnabled'] = isOPDQueueSysEnabled;
    data['IsShowRoomWithToken'] = isShowRoomWithToken;
    data['IsERXDiagnosisMandatory'] = isERXDiagnosisMandatory;
    data['IsERXComplaintMandatory'] = isERXComplaintMandatory;
    data['IsERXBPMandatory'] = isERXBPMandatory;
    data['IsERXPulseMandatory'] = isERXPulseMandatory;
    data['IsDischargeComplaintMandatory'] = isDischargeComplaintMandatory;
    data['IsDischargePulseMandatory'] = isDischargePulseMandatory;
    data['IsDischargeBPMandatory'] = isDischargeBPMandatory;
    data['IsDischargeDiagnosisMandatory'] = isDischargeDiagnosisMandatory;
    data['IsOpenEmptyERXOnCheckin'] = isOpenEmptyERXOnCheckin;
    data['IsCreateNewChallanOnUpdatingDoctor_ChallanForms'] =
        isCreateNewChallanOnUpdatingDoctorChallanForms;
    data['IsDoctorCheckInPaymentAmountIncreaseable'] =
        isDoctorCheckInPaymentAmountIncreaseable;
    data['IsIPDServicesPriceEditable'] = isIPDServicesPriceEditable;
    data['MedicineDisplayType'] = medicineDisplayType;
    data['IsApplyRefundOverflowRestriction'] = isApplyRefundOverflowRestriction;
    data['IsRestrictNursesListInNursingNotesWithLoggedInNurse'] =
        isRestrictNursesListInNursingNotesWithLoggedInNurse;
    data['BirthCertificateHeaderType'] = birthCertificateHeaderType;
    data['BirthCertificateFooterType'] = birthCertificateFooterType;
    data['BirthCertificateTopMargin'] = birthCertificateTopMargin;
    data['BirthCertificateBottomMargin'] = birthCertificateBottomMargin;
    data['IsEnableLocationatPatientCheckIn'] = isEnableLocationatPatientCheckIn;
    data['IsDisplayBookingReferenceDetailsAtPatientCheckIn'] =
        isDisplayBookingReferenceDetailsAtPatientCheckIn;
    data['IsShowTotalChargesSumInCashFlowReport'] =
        isShowTotalChargesSumInCashFlowReport;
    data['IsShowHospitalShareInCashFlowReport'] =
        isShowHospitalShareInCashFlowReport;
    data['IsReferralPanelBookingEnabled'] = isReferralPanelBookingEnabled;
    data['LabBarCodeType'] = labBarCodeType;
    data['IsDisplayWaterMarkOnDischargeReport'] =
        isDisplayWaterMarkOnDischargeReport;
    data['IsDisplayWaterMarkDisplayTypeOnDischargeReport'] =
        isDisplayWaterMarkDisplayTypeOnDischargeReport;
    data['WaterMarkTextForDischargeReport'] = waterMarkTextForDischargeReport;
    data['ImageWaterMarkPath'] = imageWaterMarkPath;
    data['IsDisplayWaterMarkOnDiagnosticReport'] =
        isDisplayWaterMarkOnDiagnosticReport;
    data['IsDisplayWaterMarkDisplayTypeOnDiagnosticReport'] =
        isDisplayWaterMarkDisplayTypeOnDiagnosticReport;
    data['WaterMarkTextOnDiagnosticReport'] = waterMarkTextOnDiagnosticReport;
    data['ImageWaterMarkPathOnDiagnosticReport'] =
        imageWaterMarkPathOnDiagnosticReport;
    data['IsDisplayWaterMarkOnLabReports'] = isDisplayWaterMarkOnLabReports;
    data['IsDisplayWaterMarkDisplayTypeOnLabReports'] =
        isDisplayWaterMarkDisplayTypeOnLabReports;
    data['WaterMarkTextOnLabReports'] = waterMarkTextOnLabReports;
    data['ImageWaterMarkPathOnLabReports'] = imageWaterMarkPathOnLabReports;
    data['IsDisplayVerifiedByDoctorListOnLabReportVerification'] =
        isDisplayVerifiedByDoctorListOnLabReportVerification;
    data['IsDisplayVerifiedByInformationOnLabReports'] =
        isDisplayVerifiedByInformationOnLabReports;
    data['IsDisplayOnlyLastVerifiedByInformationOnLabReports'] =
        isDisplayOnlyLastVerifiedByInformationOnLabReports;
    data['IsStrongPasswordConfigurationEnabled'] =
        isStrongPasswordConfigurationEnabled;
    data['DynamicIdentityNoLabel'] = dynamicIdentityNoLabel;
    data['MobileNoDynamicPlaceHolder'] = mobileNoDynamicPlaceHolder;
    data['DynamicMaskingForIdentityNumber'] = dynamicMaskingForIdentityNumber;
    data['DynamicNumberOfDigitsForIdentityNumber'] =
        dynamicNumberOfDigitsForIdentityNumber;
    data['IsShowMobileAppLoginQRCodeOnMRCard'] =
        isShowMobileAppLoginQRCodeOnMRCard;
    data['IsShowTokenNoWithAppointmentNo'] = isShowTokenNoWithAppointmentNo;
    data['ReceiptQRCodeType'] = receiptQRCodeType;
    data['IsDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport'] =
        isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnPrescriptionReport;
    data['NoteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport'] =
        noteForDisplayAsteriskWithOutOfStockMedicinesOnPrescriptionReport;
    data['IsDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport'] =
        isDisplayAsteriskWithOutOfStockMedicinesAndNoteOnDischargeReport;
    data['NoteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport'] =
        noteForDisplayAsteriskWithOutOfStockMedicinesOnDischargeReport;
    data['IsWhatsAppNotificationEnabled'] = isWhatsAppNotificationEnabled;
    data['VATPercentageAmount'] = vATPercentageAmount;
    data['IsDisplayVATAmount'] = isDisplayVATAmount;
    data['ContactNoDynamicLabel'] = contactNoDynamicLabel;
    data['DoctorRegistrationNoDynamicLabel'] = doctorRegistrationNoDynamicLabel;
    data['TaxNoDynamicLabel'] = taxNoDynamicLabel;
    data['IsDisplayOEPFormDetailAtPatientCheckIn'] =
        isDisplayOEPFormDetailAtPatientCheckIn;
    data['LabBookingSMSFormatWithCredit'] = labBookingSMSFormatWithCredit;
    data['LabBookingSMSFormatWithoutCredit'] = labBookingSMSFormatWithoutCredit;
    data['LabFirstReportVerificationSMSFormatWithCredit'] =
        labFirstReportVerificationSMSFormatWithCredit;
    data['LabFirstReportVerificationSMSFormatWithoutCredit'] =
        labFirstReportVerificationSMSFormatWithoutCredit;
    data['LabLastReportVerificationSMSFormatWithCredit'] =
        labLastReportVerificationSMSFormatWithCredit;
    data['LabLastReportVerificationSMSFormatWithoutCredit'] =
        labLastReportVerificationSMSFormatWithoutCredit;
    data['DefaultLabReportVerificationSMSFormatWithCredit'] =
        defaultLabReportVerificationSMSFormatWithCredit;
    data['DefaultLabReportVerificationSMSFormatWithoutCredit'] =
        defaultLabReportVerificationSMSFormatWithoutCredit;
    data['CustomLanguageKeyBoardType'] = customLanguageKeyBoardType;
    data['FollowUpListOrderByType'] = followUpListOrderByType;
    data['ItemNameDisplayTypeInPurchaseOrderDetail'] =
        itemNameDisplayTypeInPurchaseOrderDetail;
    data['IsDisplayReligionAndMaritalStatusOnLabReceipts'] =
        isDisplayReligionAndMaritalStatusOnLabReceipts;
    data['DynamicPanelKeyword'] = dynamicPanelKeyword;
    data['IsDisplayAppointmentBookingInterfaceAfterPatientRegistration'] =
        isDisplayAppointmentBookingInterfaceAfterPatientRegistration;
    data['IsDisplayHeadCircumferenceAndBSRInVitals'] =
        isDisplayHeadCircumferenceAndBSRInVitals;
    data['HealthCoordinatorsContactNumbers'] = healthCoordinatorsContactNumbers;
    data['GeolocationFilteringDistance'] = geolocationFilteringDistance;
    data['IsApplyGeolocationFilterOnLabAppointments'] =
        isApplyGeolocationFilterOnLabAppointments;
    data['IsNonHospitalOrganization'] = isNonHospitalOrganization;
    data['DehydrationAvoidanceReminderInterval'] =
        dehydrationAvoidanceReminderInterval;
    data['DehydrationAvoidanceReminderIntervalId'] =
        dehydrationAvoidanceReminderIntervalId;
    data['TirednessAvoidanceReminderInterval'] =
        tirednessAvoidanceReminderInterval;
    data['TirednessAvoidanceReminderIntervalId'] =
        tirednessAvoidanceReminderIntervalId;
    data['IsHighlightInsuranceCoveredForMedicines'] =
        isHighlightInsuranceCoveredForMedicines;
    data['IsDisplayAllergyAlertPopupInititally'] =
        isDisplayAllergyAlertPopupInititally;
    data['IsDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface'] =
        isDisplayRiskFactorAlertPopupInititallyInPrescriptionInterface;
    data['IsDisableAutoPrintingofEmergencyChallan'] =
        isDisableAutoPrintingofEmergencyChallan;
    data['IsDisableAutoPrintingofDepartmentChallan'] =
        isDisableAutoPrintingofDepartmentChallan;
    data['IsDisableAutoPrintingofDoctorChallan'] =
        isDisableAutoPrintingofDoctorChallan;
    data['IsDisableAutoPrintingofLabChallan'] =
        isDisableAutoPrintingofLabChallan;
    data['IsDisableAutoPrintingofProcedureChallan'] =
        isDisableAutoPrintingofProcedureChallan;
    data['IsDisableAutoPrintingofBloodDonationChallan'] =
        isDisableAutoPrintingofBloodDonationChallan;
    data['IsDisableAutoPrintingofMiscServicesChallan'] =
        isDisableAutoPrintingofMiscServicesChallan;
    data['IsDisableAutoOpeningOfPrescriptionReport'] =
        isDisableAutoOpeningOfPrescriptionReport;
    data['IsDisableAutoOpeningofDischargeReport'] =
        isDisableAutoOpeningofDischargeReport;
    data['SMSSendingTypeForDoctorAppointment'] =
        sMSSendingTypeForDoctorAppointment;
    data['IsLabInternalNotificationEnabled'] = isLabInternalNotificationEnabled;
    data['IsHideAdditionalInsuranceDetailsAtPatientRegistration'] =
        isHideAdditionalInsuranceDetailsAtPatientRegistration;
    data['IsShowAirlineDetailAtCheckInInterface'] =
        isShowAirlineDetailAtCheckInInterface;
    data['IsDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface'] =
        isDisplayComplaintsAlertPopupInitiallyInPrescriptionInterface;
    data['IsShowCardDetailsWithCashPaymentTypeWhileBillReceiving'] =
        isShowCardDetailsWithCashPaymentTypeWhileBillReceiving;
    data['IsDisplayVATAmountInCashFlow'] = isDisplayVATAmountInCashFlow;
    data['isHideTypeInCheckIn'] = isHideTypeInCheckIn;
    data['isHideCheckInToInCheckIn'] = isHideCheckInToInCheckIn;
    data['isHidePrescribedByInCheckIn'] = isHidePrescribedByInCheckIn;
    data['isHideDoctorInCheckIn'] = isHideDoctorInCheckIn;
    data['isHideBookingSlipPrescriptionInCheckIn'] =
        isHideBookingSlipPrescriptionInCheckIn;
    data['isHideDepartmentInCheckIn'] = isHideDepartmentInCheckIn;
    data['isHideServiceCategoryinCheckIn'] = isHideServiceCategoryinCheckIn;
    data['isHideAirlineInCheckIn'] = isHideAirlineInCheckIn;
    data['isHideSMSAlertInCheckIn'] = isHideSMSAlertInCheckIn;
    data['isHideSampleReceivedInCheckIn'] = isHideSampleReceivedInCheckIn;
    data['isHideShareEntityInCheckIn'] = isHideShareEntityInCheckIn;
    data['isHideDiscountInCheckIn'] = isHideDiscountInCheckIn;
    data['isHideAdvisedByInCheckIn'] = isHideAdvisedByInCheckIn;
    data['isHideBranchLocationInCheckIn'] = isHideBranchLocationInCheckIn;
    data['isHideAdvanceSecurityInCheckIn'] = isHideAdvanceSecurityInCheckIn;
    data['isHidePaymentMethodInCheckIn'] = isHidePaymentMethodInCheckIn;
    data['isHideVIPBookingInCheckIn'] = isHideVIPBookingInCheckIn;
    data['isHideSampleCollectionStickerInCheckIn'] =
        isHideSampleCollectionStickerInCheckIn;
    data['isHideVoucherCouponInCheckIn'] = isHideVoucherCouponInCheckIn;
    data['ProcurementTermAndConditions'] = procurementTermAndConditions;
    data['IsProviderSetting'] = isProviderSetting;
    data['IsDisplayAppointmentButton'] = isDisplayAppointmentButton;
    data['ContingentBillStamp'] = contingentBillStamp;
    data['WhatsAppNotificationMessage'] = whatsAppNotificationMessage;
    data['IsDisplayFooterTextonThermalReceiptType'] =
        isDisplayFooterTextonThermalReceiptType;
    data['IsDisplayReportingTimeonLabReports'] =
        isDisplayReportingTimeonLabReports;
    data['IsDisplayAsteriskwithReferenceNumber'] =
        isDisplayAsteriskwithReferenceNumber;
    data['ApplyRestrictionOfMPLatDemandRequest'] =
        applyRestrictionOfMPLatDemandRequest;
    data['DynamicRegistrationDateLabel'] = dynamicRegistrationDateLabel;
    return data;
  }
}
