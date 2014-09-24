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

@property (nonatomic) UIButton *doneBtn;


@end

@interface CarInfoViewController () <SelectableViewControllerDelegate>
{
	BOOL isShowDatePicker;
	int currDatePicker;
}

@property (strong, nonatomic) CarInfoDetailTableViewController *detail; // 车辆信息详情

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

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
	}
}

#pragma mark - SelectableViewControllerDelegate

- (void)didSelectObject:(id)object with:(NSString *)identifer {
	// 车辆品牌
	if ([identifer isEqualToString:kCarBrand]) {
		self.detail.carBrandLabel.text = object;
	}
	// 保险公司
	else if ([identifer isEqualToString:kInsuranceCompany]) {
		self.detail.insuranceCompanyLabel.text = object;
	}
	else {
		self.detail.autoInsuranceLabel.text = object;
	}
}

#pragma mark

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
		[UIView animateWithDuration:.5 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y - rect.size.height - 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (void)hideDatePicker {
	if (isShowDatePicker) {
		isShowDatePicker = NO;
		[UIView animateWithDuration:.5 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y + rect.size.height + 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

// 保存车辆信息
- (void)saveCarInfo {
#warning 暂时直接迁移到主页面，等能和服务器交互后，再替换
	[self performSegueWithIdentifier:kMainIndex sender:nil];
}

@end
