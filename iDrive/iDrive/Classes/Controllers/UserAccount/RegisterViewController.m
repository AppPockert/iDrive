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

- (IBAction)back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(id)sender {
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

	if (![NSStringUtil isValidate:self.deviceNo.text]) {
		[self.view makeToast:@"请输入\"爱开车\"编号"];
		return;
	}
	else {
		// check“爱开车”编号格式正确性
	}

	RegisterRequestParameter *parameter = [[RegisterRequestParameter alloc] init];
	parameter.userTelephone = self.account.text;
	parameter.userPassword = self.password.text;
	parameter.userTianyitongid = self.deviceNo.text;

	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

#pragma mark

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
