//
//  CarInfoDetailTableViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarInfoDetailTableViewController.h"

@interface CarInfoDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation CarInfoDetailTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	[self.tableView setTableFooterView:[UIView new]];

	self.tableView.scrollEnabled = (kScreenHeight < kScreenHeight568);
}

@end
