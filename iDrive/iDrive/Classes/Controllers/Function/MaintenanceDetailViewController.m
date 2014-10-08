//
//  MaintenanceDetailViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "MaintenanceDetailViewController.h"

@interface UIViewController (CarInfo)

- (void)showDatePicker:(int)datePickerTag;
- (void)save;

@end

@interface MaintenanceDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *insuranceCompanyLabel; // 保险公司
@property (weak, nonatomic) IBOutlet UILabel *autoInsuranceLabel;    // 车险类型
@property (weak, nonatomic) IBOutlet UILabel *insuranceExpire;       // 保险到期日
@property (weak, nonatomic) IBOutlet UILabel *maintenanceDueDate;    // 保养到期日
@property (weak, nonatomic) IBOutlet UITextField *maintenanceMaMi;   // 保养到期里程

@property (assign, nonatomic) BOOL hasEngineOil;      // 机油
@property (assign, nonatomic) BOOL hasAirConditioner; // 空调

@end

@implementation MaintenanceDetailViewController


- (UIImage *)getSelectedImage:(BOOL)selected {
	if (selected) {
		return [UIImage imageNamed:@"复选二"];
	}
	else {
		return [UIImage imageNamed:@"复选一"];
	}
}

// 选择机油
- (IBAction)selectEngineOil:(id)sender {
	_hasEngineOil = !_hasEngineOil;
	[((UIButton *)sender)setImage :[self getSelectedImage:_hasEngineOil] forState : UIControlStateNormal];
}

// 选择空调
- (IBAction)selectAirConditioner:(id)sender {
	_hasAirConditioner = !_hasAirConditioner;
	[((UIButton *)sender)setImage :[self getSelectedImage:_hasAirConditioner] forState : UIControlStateNormal];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	[self.tableView endEditing:YES];

	// 车险类型
	if (indexPath.row == 0) {
		[self.parentViewController performSegueWithIdentifier:kAutoInsurance sender:nil];
	}
	// 保险到期日
	else if (indexPath.row == 1) {
		[self.parentViewController showDatePicker:1];
	}
	// 保险公司
	else if (indexPath.row == 2) {
		[self.parentViewController performSegueWithIdentifier:kInsuranceCompany sender:nil];
	}
	// 保养到期日
	else if (indexPath.row == 3) {
		[self.parentViewController showDatePicker:2];
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.tableView endEditing:YES];
}

#pragma mark - 保存

- (IBAction)save:(id)sender {
	[self.parentViewController save];
}

@end
