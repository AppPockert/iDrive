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

@property (strong, nonatomic) CarInfoDetailTableViewController *detail;

@end

@implementation CarInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *buttonTitle;
	if (self.isPushFromLogin) {
		buttonTitle = @"保存";
	}
	else {
		buttonTitle = @"完成修改";
	}

	[self.detail.doneBtn setTitle:buttonTitle forState:UIControlStateNormal];
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kCarInfoDetail]) {
		self.detail = segue.destinationViewController;
	}
	else if ([segue.identifier isEqualToString:kInsuranceCompany]
	         || [segue.identifier isEqualToString:kCarBrand]) {
		SelectableViewController *controller = segue.destinationViewController;
		controller.delegate = self;
	}
}

#pragma mark - SelectableViewControllerDelegate

- (void)didSelectObject:(id)object with:(NSString *)identifer {
	if ([identifer isEqualToString:kCarBrand]) {
		self.detail.carBrandLabel.text = object;
	}
	else if ([identifer isEqualToString:kInsuranceCompany]) {
		self.detail.insuranceCompanyLabel.text = object;
	}
}

#pragma mark

- (void)saveCarInfo {
}

@end
