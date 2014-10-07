//
//  CarAbnormalViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-24.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarAbnormalViewController.h"

@interface CarAbnormalViewController ()

@property (nonatomic, weak) IBOutlet UISwitch *abnormalSwitch;

@end

@implementation CarAbnormalViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:kCarAbnormal];
	self.abnormalSwitch.on = isOn;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[[NSUserDefaults standardUserDefaults] setBool:self.abnormalSwitch.isOn forKey:kCarAbnormal];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
