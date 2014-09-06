//
//  IntroductionViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "IntroductionViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLaunch];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
