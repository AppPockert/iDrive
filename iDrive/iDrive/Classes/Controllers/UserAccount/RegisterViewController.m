//
//  RegisterViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "RegisterViewController.h"
#import "JVFloatLabeledTextField.h"
#import "NSStringUtil.h"
#import "RegexHelper.h"
#import "RequestService.h"
#import "RegisterRequestParameter.h"
#import "UserInfo.h"
#import "CarInfoViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *account;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *password;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *repeatPassword;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *deviceNo;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.account.text = self.accountForRegister;
	self.password.text = self.passwordForRegister;
}

#pragma mark

- (IBAction)registerAction:(id)sender {
	[self.view endEditing:YES];

	// check用户名
	if (![NSStringUtil isValidate:self.account.text]) {
		[self.view makeToast:@"手机号不能为空"];
		return;
	}
	else {
		NSString *errMsg = [RegexHelper check:self.account.text with:RegexTypePhone];
		if (errMsg) {
			[self.view makeToast:errMsg];
			return;
		}
	}

	// check密码
	if (![NSStringUtil isValidate:self.password.text]) {
		[self.view makeToast:@"密码不能为空"];
		return;
	}
	else {
		NSString *errMsg = [RegexHelper check:self.password.text with:RegexTypePassword];
		if (errMsg) {
			[self.view makeToast:errMsg];
			return;
		}
	}

	// check重复密码
	if (![NSStringUtil isValidate:self.repeatPassword.text]) {
		[self.view makeToast:@"请输入确认密码"];
		return;
	}
	else {
		if (![self.password.text isEqualToString:self.repeatPassword.text]) {
			[self.view makeToast:@"确认密码不正确"];
			return;
		}
	}

	// check爱开车编号
	if (![NSStringUtil isValidate:self.deviceNo.text]) {
		[self.view makeToast:@"请输入\"爱开车\"编号"];
		return;
	}
	else {
		// check“爱开车”编号格式正确性
	}

	// 向服务器提交注册请求
	RegisterRequestParameter *parameter = [[RegisterRequestParameter alloc] init];
	parameter.userTelephone = self.account.text;
	parameter.userPassword = self.password.text;
	parameter.userTianyitongid = self.deviceNo.text;

	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

#pragma mark

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSArray class]] && [result[0] isEqualToString:@"success"]) {
		UserInfo *userInfo = [[UserInfo alloc] init];
		userInfo.userTelephone = self.account.text;
		userInfo.userPassword = self.password.text;
		userInfo.SN = self.deviceNo.text;

		[kAppDelegate saveUserInfo:userInfo];

		[self performSegueWithIdentifier:kMainIndex sender:nil];
	}
	else {
		[self.view makeToast:@"注册失败"];
	}
}

#pragma mark - 页面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kCarInfo]) {
		CarInfoViewController *controller = segue.destinationViewController;
		controller.pushFromLogin = YES;
	}
}

@end
