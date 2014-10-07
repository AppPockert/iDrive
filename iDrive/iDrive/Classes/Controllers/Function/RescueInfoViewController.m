//
//  RescueInfoViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RescueInfoViewController.h"

@interface RescueInfoViewController ()

@end

@implementation RescueInfoViewController

- (IBAction)call:(id)sender {
	NSString *telUrl = [NSString stringWithFormat:@"tel://%@", @"4008208889"];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];

	NSLog(@"%@", telUrl);
}

// 搭电
- (IBAction)takeTheElectric:(id)sender {
}

// 加油
- (IBAction)refuel:(id)sender {
}

// 换胎
- (IBAction)changeTire:(id)sender {
}

// 拖车
- (IBAction)trailCar:(id)sender {
}

// 代驾
- (IBAction)drivingService:(id)sender {
}

// 知识
- (IBAction)knowledge:(id)sender {
}

@end
