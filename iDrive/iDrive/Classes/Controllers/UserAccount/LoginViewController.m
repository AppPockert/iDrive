//
//  LoginViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "LoginViewController.h"
#import "JVFloatLabeledTextField.h"
#import "NSStringUtil.h"
#import "RegexHelper.h"
#import "TestLoginService.h"
#import "LoginRequestParameter.h"

@interface LoginViewController () <UITextFieldDelegate>
{
	UITapGestureRecognizer *_tap;
}


@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *account;  // 用户名
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *password; // 密码

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.account) {
		[textField resignFirstResponder];
		[self.password becomeFirstResponder];
		return NO;
	}
	else {
		[textField resignFirstResponder];
		return YES;
	}
}

#pragma mark

- (IBAction)login:(id)sender {
	[self.view endEditing:YES];

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

	// test
	if ([self.account.text isEqualToString:@"13611113333"] && [self.password.text isEqualToString:@"123456"]) {
		[self performSegueWithIdentifier:kMainIndex sender:nil];
	}
	else {
		[self.view makeToast:@"手机号码未注册"];
	}

//	TestLoginService *servive = [[TestLoginService alloc] init];
//	LoginRequestParameter *parameter = [[LoginRequestParameter alloc] init];
//	parameter.account = self.account.text;
//	parameter.password = self.password.text;
//
//	[self sendRequestTo:servive with:nil];
}

- (void)handleResult:(id)result of:(RequestService *)service {
}

#pragma mark

- (void)keyboardWillShow:(id)sender {
	[self.view addGestureRecognizer:_tap];
}

- (void)keyboardWillHide:(id)sender {
	[self.view removeGestureRecognizer:_tap];
}

- (void)dismissKeyboard:(id)sender {
	[self.view endEditing:YES];
}

@end