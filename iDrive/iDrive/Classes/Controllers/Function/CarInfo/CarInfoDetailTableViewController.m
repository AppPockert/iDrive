//
//  CarInfoDetailTableViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarInfoDetailTableViewController.h"
#import "PlistFilePathManager.h"
#import "UIPopoverListView.h"

@interface UIViewController (CarInfo)

- (void)saveCarInfo;
- (void)showDatePicker:(int)datePickerTag;
- (BOOL)shouldUpdate;

@end

#define FileName    @"LicensePlate.plist"

@interface CarInfoDetailTableViewController () <UIPopoverListViewDataSource, UIPopoverListViewDelegate>

@property (strong, nonatomic) NSString *fullCarLicense;              // 完整车牌号

@property (weak, nonatomic) IBOutlet UIButton *licenseSelectBtn;     // 车牌所属地区
@property (weak, nonatomic) IBOutlet UITextField *carLicense;        // 车牌号后半部分
@property (weak, nonatomic) IBOutlet UILabel *carBrandLabel;         // 车品牌
@property (weak, nonatomic) IBOutlet UITextField *driverField;       // 驾驶员
@property (weak, nonatomic) IBOutlet UITextField *mileageField;      // 行驶里程
@property (weak, nonatomic) IBOutlet UILabel *insuranceCompanyLabel; // 保险公司
@property (weak, nonatomic) IBOutlet UILabel *autoInsuranceLabel;    // 车险类型
@property (weak, nonatomic) IBOutlet UILabel *insuranceExpire;       // 保险到期日
@property (weak, nonatomic) IBOutlet UILabel *maintenanceDueDate;    // 保养到期日
@property (weak, nonatomic) IBOutlet UITextField *maintenanceMaMi;   // 保养到期里程

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;              // 完成按钮

@property (strong, nonatomic) NSMutableArray *carLicenseList;

@end

@implementation CarInfoDetailTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];
	_carLicenseList = [NSArray arrayWithContentsOfFile:path];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	BOOL isPushFromLogin = ![self.parentViewController shouldUpdate];
	CGRect frame = self.tableView.frame;
	if (isPushFromLogin) {
		frame.size.height = kScreenHeight - kNavBarHeight;
	}
	else {
		frame.size.height = kScreenHeight - kNavBarHeight - KTabBarHeight;
	}
	self.tableView.frame = frame;
}

- (NSString *)fullCarLicense {
	return [self.licenseSelectBtn.titleLabel.text stringByAppendingString:self.carLicense.text];
}

- (void)setFullCarLicense:(NSString *)fullCarLicense {
	[self.licenseSelectBtn setTitle:[fullCarLicense substringToIndex:1] forState:UIControlStateNormal];
	self.carLicense.text = [fullCarLicense substringFromIndex:1];
}

#pragma mark

// 保存
- (IBAction)save:(id)sender {
	[self.parentViewController saveCarInfo];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	[self.tableView endEditing:YES];

	// 车辆品牌
	if (indexPath.row == 1) {
		[self.parentViewController performSegueWithIdentifier:kCarBrand sender:nil];
	}
	// 车险类型
	else if (indexPath.row == 4) {
		[self.parentViewController performSegueWithIdentifier:kAutoInsurance sender:nil];
	}
	// 保险到期日
	else if (indexPath.row == 5) {
		[self.parentViewController showDatePicker:1];
	}
	// 保险公司
	else if (indexPath.row == 6) {
		[self.parentViewController performSegueWithIdentifier:kInsuranceCompany sender:nil];
	}
	// 保险公司
	else if (indexPath.row == 7) {
		[self.parentViewController showDatePicker:2];
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.tableView endEditing:YES];
}

#pragma mark

- (IBAction)selectLicense:(id)sender {
	CGFloat xWidth = self.view.bounds.size.width - 100.0f;
	CGFloat yHeight = 272.0f;
	CGFloat yOffset = (self.view.bounds.size.height - yHeight) / 2.0f;
	UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
	poplistview.delegate = self;
	poplistview.datasource = self;
	poplistview.listView.scrollEnabled = YES;
	[poplistview setTitle:@"所属地"];
	[poplistview show];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"cell";
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
	                                               reuseIdentifier:identifier];
	cell.textLabel.text = self.carLicenseList[indexPath.row];
	return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section {
	return self.carLicenseList.count;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath {
	[self.licenseSelectBtn setTitle:self.carLicenseList[indexPath.row] forState:UIControlStateNormal];
}

- (CGFloat) popoverListView:(UIPopoverListView *)popoverListView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.f;
}

@end
