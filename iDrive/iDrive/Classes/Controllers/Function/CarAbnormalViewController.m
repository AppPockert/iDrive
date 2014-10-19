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

// 开关事件
- (IBAction)switchDidChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:self.abnormalSwitch.isOn forKey:kCarAbnormal];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [kAppDelegate.carAbnormalService shouldCheckCarAbnormal:self.abnormalSwitch.isOn];
}

@end
