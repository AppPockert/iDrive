//
//  SettingViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UIAlertViewDelegate>

@end

@implementation SettingViewController

- (IBAction)logout:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[kAppDelegate logout];
		[self.view makeToast:@"退出成功"];
	}
}

@end
