//
//  CarInfoViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarInfoDetailTableViewController.h"

@interface CarInfoDetailTableViewController ()

@property (nonatomic) UIButton *doneBtn;

@end

@interface CarInfoViewController ()

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

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kCarInfoDetail]) {
		self.detail = segue.destinationViewController;
	}
}

@end
