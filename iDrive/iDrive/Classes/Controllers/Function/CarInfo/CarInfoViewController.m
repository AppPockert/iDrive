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


@interface CarInfoDetailTableViewController ()

@property (nonatomic) UITextField *carLicense;        // 车牌号
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
		if (self.isPushFromLogin) {
			buttonTitle = @"保存";
		}
		else {
			buttonTitle = @"完成修改";
		}

		[self.detail.doneBtn setTitle:buttonTitle forState:UIControlStateNormal];
	}
	self.backBtn.hidden = !self.isPushFromLogin;
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
	RequestService *service = [[RequestService alloc] init];

	// 追加车辆信息
	if (self.isPushFromLogin) {
		service.tag = AddCarInfo;

		AddCarInfoRequestParameter *parameter = [[AddCarInfoRequestParameter alloc] init];
		parameter.carLicenseid = self.detail.carLicense.text;
		parameter.carModel = self.detail.carBrandLabel.text;
		parameter.carDriver = self.detail.driverField.text;
		parameter.carInsurancemaintainInfo = self.detail.autoInsuranceLabel.text;

		[self sendRequestTo:service with:parameter];
	}
	// 保存车辆信息
	else {
		service.tag = ModifyCarInfo;

		ModifyCarInfoRequestParameter *parameter = [[ModifyCarInfoRequestParameter alloc] init];

		[self sendRequestTo:service with:parameter];
	}
}

#pragma mark

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSArray class]] && [result[0] isEqualToString:@"success"]) {
		UserInfo *user = [kAppDelegate getUserInfo];
		user.carLicense = self.detail.carLicense.text;
		[kAppDelegate saveUserInfo:user];

		// 追加车辆信息成功后跳转到首页面
		if (service.tag == AddCarInfo) {
			[self performSegueWithIdentifier:kMainIndex sender:nil];
		}
		// 修改车辆信息成功后返回上一个页面
		else {
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
	else {
		[self.view makeToast:@"保存失败"];
	}
}

@end
