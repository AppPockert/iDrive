//
//  ServerSettingViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-22.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ServerSettingViewController.h"

@interface ServerSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ServerSettingViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	if ([[NSUserDefaults standardUserDefaults] objectForKey:TestServer]) {
		self.textView.text  = [[NSUserDefaults standardUserDefaults] objectForKey:TestServer];
	}
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
	[self.view endEditing:YES];

	if (self.textView.text && ![self.textView.text isEqualToString:@""]) {
		[[NSUserDefaults standardUserDefaults] setObject:[self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]] forKey:TestServer];
		[[NSUserDefaults standardUserDefaults] synchronize];

		[self dismissViewControllerAnimated:YES completion: ^{
		    [self.view makeToast:@"测试服务器设置成功"];
		}];
	}
	else {
		[self.view makeToast:@"请输入测试服务器地址"];
	}
}

@end
