//
//  CarInfoDetailTableViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarInfoDetailTableViewController.h"

@interface UIViewController (CarInfo)

- (void)saveCarInfo;

@end


@interface CarInfoDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *carBrandLabel;         // 车品牌
@property (weak, nonatomic) IBOutlet UITextField *driverField;       // 驾驶员
@property (weak, nonatomic) IBOutlet UITextField *mileageField;      // 行驶里程
@property (weak, nonatomic) IBOutlet UILabel *insuranceCompanyLabel; // 保险公司


@property (weak, nonatomic) IBOutlet UIButton *doneBtn;              // 完成按钮

@end

@implementation CarInfoDetailTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];

//	[self.tableView setTableFooterView:[UIView new]];
//	self.tableView.scrollEnabled = (kScreenHeight < kScreenHeight568);
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
	// 保险公司
	else if (indexPath.row == 6) {
		[self.parentViewController performSegueWithIdentifier:kInsuranceCompany sender:nil];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self.tableView endEditing:YES];
}

@end
