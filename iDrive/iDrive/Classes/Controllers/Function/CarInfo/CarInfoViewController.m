//
//  CarInfoViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarInfoDetailTableViewController.h"
#import "SelectableViewController.h"
#import "AddCarInfoRequestParameter.h"
#import "ModifyCarInfoRequestParameter.h"
#import "RequestService.h"
#import "UserInfo.h"
#import "NSStringUtil.h"
#import "RegexHelper.h"
#import "GetCarInfoRequestParameter.h"

@interface CarInfoDetailTableViewController ()

@property (nonatomic) NSString *fullCarLicense;       // 车牌号
@property (nonatomic) UILabel *carBrandLabel;         // 车品牌
@property (nonatomic) UITextField *driverField;       // 驾驶员
@property (nonatomic) UITextField *mileageField;      // 行驶里程
@property (nonatomic) UILabel *insuranceCompanyLabel; // 保险公司
@property (nonatomic) UILabel *autoInsuranceLabel;    // 车险类型
@property (nonatomic) UILabel *insuranceExpire;       // 保险到期日
@property (nonatomic) UILabel *maintenanceDueDate;    // 保养到期日
@property (nonatomic) UITextField *maintenanceMaMi;   // 保养到期里程

@property (nonatomic) UIButton *doneBtn;  // 「完成」按钮

@end

const int AddCarInfo = 1;
const int ModifyCarInfo = 2;
const int GetCarInfo = 3;

@interface CarInfoViewController () <SelectableViewControllerDelegate>
{
	BOOL isShowDatePicker;
	int currDatePicker;
}
@property (weak, nonatomic) IBOutlet UIView *detailViewController;

@property (strong, nonatomic) CarInfoDetailTableViewController *detail; // 车辆信息详情

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation CarInfoViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	{ // 设置完成按钮的标题
		NSString *buttonTitle;
		if (self.shouldUpdate) {
			buttonTitle = @"完成修改";
		}
		else {
			buttonTitle = @"保存";
		}

		[self.detail.doneBtn setTitle:buttonTitle forState:UIControlStateNormal];
	}
	self.backBtn.hidden = !self.shouldUpdate;

	// 已经是登陆状态进入该页面
	if (self.shouldUpdate) {
		RequestService *service = [[RequestService alloc] init];
		service.tag = GetCarInfo;
		GetCarInfoRequestParameter *parameter = [[GetCarInfoRequestParameter alloc] init];
//		parameter.userId = @"13770519290";
		[self sendRequestTo:service with:parameter];
	}

	// 已填写过，但是未完成
	if (!self.isFirstTimeToFill && !self.shouldUpdate) {
		[self.view makeToast:@"请填写完车辆信息"];
	}
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// 车辆信息详情
	if ([segue.identifier isEqualToString:kCarInfoDetail]) {
		self.detail = segue.destinationViewController;
	}
	// 车辆品牌/保险公司
	else if ([segue.identifier isEqualToString:kInsuranceCompany]
	         || [segue.identifier isEqualToString:kCarBrand]
	         || [segue.identifier isEqualToString:kAutoInsurance]) {
		SelectableViewController *controller = segue.destinationViewController;
		controller.delegate = self;
		controller.selectedItem = [[self lableForItem:segue.identifier] text];
	}
}

- (UILabel *)lableForItem:(NSString *)identifer {
	// 车辆品牌
	if ([identifer isEqualToString:kCarBrand]) {
		return self.detail.carBrandLabel;
	}
	// 保险公司
	else if ([identifer isEqualToString:kInsuranceCompany]) {
		return self.detail.insuranceCompanyLabel;
	}
	// 车险信息
	else {
		return self.detail.autoInsuranceLabel;
	}
}

#pragma mark - SelectableViewControllerDelegate

- (void)didSelectObject:(id)object with:(NSString *)identifer {
	[[self lableForItem:identifer] setText:object];
}

#pragma mark - 时间选择

- (IBAction)actionDone:(id)sender {
	if (currDatePicker == 1) {
		[self.detail.insuranceExpire setText:[self getTheDate]];
	}
	else {
		[self.detail.maintenanceDueDate setText:[self getTheDate]];
	}
	[self hideDatePicker];
}

- (NSString *)getTheDate {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	return [dateFormatter stringFromDate:self.dataPicker.date];
}

- (void)showDatePicker:(int)datePickerTag {
	currDatePicker = datePickerTag;

	self.dataPicker.minimumDate = [NSDate date];
	self.dataPicker.maximumDate = nil;

	if (!isShowDatePicker) {
		isShowDatePicker = YES;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y - 253;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (void)hideDatePicker {
	if (isShowDatePicker) {
		isShowDatePicker = NO;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y + 253;
		    self.datePickerView.frame = rect;
		}];
	}
}

#pragma mark - 保存车辆信息

- (void)saveCarInfo {
	if (self.detail.fullCarLicense.length < 2) {
		[self.view makeToast:@"请输入车牌号"];
		return;
	}
	else {
		NSString *errMsg = [RegexHelper check:self.detail.fullCarLicense with:RegexTypeCarLicense];
		if (errMsg) {
			[self.view makeToast:errMsg];
			return;
		}
	}

	RequestService *service = [[RequestService alloc] init];

	// 追加车辆信息
	if (!self.shouldUpdate) {
		service.tag = AddCarInfo;

		AddCarInfoRequestParameter *parameter = [[AddCarInfoRequestParameter alloc] init];
		parameter.carLicenseid = self.detail.fullCarLicense;
		parameter.carModel = [self valueOfLabel:self.detail.carBrandLabel];
		parameter.carDriver = [self valueOfField:self.detail.driverField];
		parameter.insuranceType = [self valueOfLabel:self.detail.autoInsuranceLabel];
		parameter.insuranceCompany = [self valueOfLabel:self.detail.insuranceCompanyLabel];
		parameter.ciiInsurancetimeLeft = [self valueOfLabel:self.detail.insuranceExpire];
		parameter.ciiMaintaintimeLeft = [self valueOfLabel:self.detail.maintenanceDueDate];
		parameter.ciiMaintaindistanceLeft = [self valueOfField:self.detail.maintenanceMaMi];

//		parameter.equipmentSNnum = @"6334128330095";

		[self sendRequestTo:service with:parameter];
	}
	// 保存车辆信息
	else {
		service.tag = ModifyCarInfo;

		ModifyCarInfoRequestParameter *parameter = [[ModifyCarInfoRequestParameter alloc] init];
		parameter.carLicenseid = self.detail.fullCarLicense;
		parameter.carModel = [self valueOfLabel:self.detail.carBrandLabel];
		parameter.carDriver = [self valueOfField:self.detail.driverField];
		parameter.insuranceType = [self valueOfLabel:self.detail.autoInsuranceLabel];
		parameter.insuranceCompany = [self valueOfLabel:self.detail.insuranceCompanyLabel];
		parameter.ciiInsurancetimeLeft = [self valueOfLabel:self.detail.insuranceExpire];
		parameter.ciiMaintaintimeLeft = [self valueOfLabel:self.detail.maintenanceDueDate];
		parameter.ciiMaintaindistanceLeft = [self valueOfField:self.detail.maintenanceMaMi];

//		parameter.equipmentSNnum = @"6334128330095";
//		parameter.userTelphone = @"13770519290";

		[self sendRequestTo:service with:parameter];
	}
}

- (NSString *)valueOfLabel:(UILabel *)label {
	if (label.text) {
		return label.text;
	}
	else {
		return @"";
	}
}

- (NSString *)valueOfField:(UITextField *)field {
	if (field.text) {
		return field.text;
	}
	else {
		return @"";
	}
}

#pragma mark

- (void)handleResult:(id)result of:(RequestService *)service {
	// 获取车辆信息
	if (service.tag == GetCarInfo) {
		if ([result isKindOfClass:[NSDictionary class]]) {
			if ([[result allKeys] containsObject:@"error"]) {
				if ([result[@"error"] isEqualToString:@"error"]) {
					[self.view makeToast:@"服务器错误"];
				}

				if ([NSStringUtil isValidate:result[@"carLicense"]]) {
					self.detail.fullCarLicense = result[@"carLicense"];
				}
			}
			else {
				// 车牌
				if ([NSStringUtil isValidate:result[@"carLicense"]]) {
					self.detail.fullCarLicense = result[@"carLicense"];
				}
				// 车型
				if ([NSStringUtil isValidate:result[@"carModel"]]) {
					self.detail.carBrandLabel.text = result[@"carModel"];
				}
				// 驾驶员
				if ([NSStringUtil isValidate:result[@"carDriver"]]) {
					self.detail.driverField.text = result[@"carDriver"];
				}
				// 行驶公里数
				if (result[@"sumMileage"] && [NSStringUtil isValidate:result[@"sumMileage"]]) {
					self.detail.mileageField.text = [NSString stringWithFormat:@"%@", result[@"sumMileage"]];
				}
				// 保险公司
				if ([NSStringUtil isValidate:result[@"IcName"]]) {
					self.detail.insuranceCompanyLabel.text = result[@"IcName"];
				}
				// 保险类型
				if (result[@"CiiInsuranceType"] && [NSStringUtil isValidate:[NSString stringWithFormat:@"%@", result[@"CiiInsuranceType"]]]) {
					self.detail.autoInsuranceLabel.text = [NSString stringWithFormat:@"%@", result[@"CiiInsuranceType"]];
				}
				// 保险到期日
				if ([NSStringUtil isValidate:result[@"CiiInsurancetimeLeft"]]) {
					self.detail.insuranceExpire.text = result[@"CiiInsurancetimeLeft"];
				}
				// 保养到期日
				if ([NSStringUtil isValidate:result[@"CiiMaintaintimeLeft"]]) {
					self.detail.maintenanceDueDate.text = result[@"CiiMaintaintimeLeft"];
				}
				// 保养到期里程
				if (result[@"CiiMaintaindistanceLeft"] && [NSStringUtil isValidate:[NSString stringWithFormat:@"%@", result[@"CiiMaintaindistanceLeft"]]]) {
					self.detail.maintenanceMaMi.text = [NSString stringWithFormat:@"%@", result[@"CiiMaintaindistanceLeft"]];
				}
			}
		}
	}
	// 保存/追加车辆信息
	else {
		if ([result isKindOfClass:[NSArray class]] && [result[0] isEqualToString:@"success"]) {
			UserInfo *user = [kAppDelegate getUserInfo];
			user.carLicense = self.detail.fullCarLicense;
			[kAppDelegate saveUserInfo:user];

			// 追加车辆信息成功后跳转到首页面
			if (service.tag == AddCarInfo) {
				[self performSegueWithIdentifier:kMainIndex sender:nil];
			}
			// 修改车辆信息成功后返回上一个页面
			else {
				[self.navigationController popViewControllerAnimated:YES];
			}
			[self.view makeToast:@"保存成功"];
		}
		else {
			[self.view makeToast:@"保存失败"];
		}
	}
}

@end
