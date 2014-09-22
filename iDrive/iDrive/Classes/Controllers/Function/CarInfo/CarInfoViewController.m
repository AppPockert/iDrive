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

@property (nonatomic) UIButton *doneBtn;
@property (nonatomic) UILabel *carBrandLabel;
@property (nonatomic) UITextField *driverField;
@property (nonatomic) UITextField *mileageField;
@property (nonatomic) UILabel *insuranceCompanyLabel;

@end

@interface CarInfoViewController () <SelectableViewControllerDelegate>

@property (strong, nonatomic) CarInfoDetailTableViewController *detail; // 车辆信息详情

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
	         || [segue.identifier isEqualToString:kCarBrand]) {
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
}

#pragma mark

// 保存车辆信息
- (void)saveCarInfo {
#warning 暂时直接迁移到主页面，等能和服务器交互后，再替换
	[self performSegueWithIdentifier:kMainIndex sender:nil];
}

@end
