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
#import "LoginRequestParameter.h"
#import "CarInfoViewController.h"
#import "RegisterViewController.h"
#import "RequestService.h"
#import "TravelActionRequestParameter.h"
#import "GetCarInfoRequestParameter.h"
#import "UserInfo.h"

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
		[self login:nil];

		return YES;
	}
}

#pragma mark

- (IBAction)login:(id)sender {
	[self.view endEditing:YES];

	if (![NSStringUtil isValidate:self.account.text]) {
		[self.view makeToast:@"帐号不能为空"];
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


	RequestService *servive = [[RequestService alloc] init];
	servive.tag = 1;
	LoginRequestParameter *parameter = [[LoginRequestParameter alloc] init];
	parameter.userTelephone = self.account.text;
	parameter.userPassword = self.password.text;

	[self sendRequestTo:servive with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	if (service.tag == 1) {
		if ([result isKindOfClass:[NSArray class]] && [result[0] isEqualToString:@"success"]) {
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			    RequestService *servive = [[RequestService alloc] init];
			    servive.tag = 2;

			    GetCarInfoRequestParameter *parameter = [[GetCarInfoRequestParameter alloc] init];
			    parameter.userId = self.account.text;

			    [self sendRequestTo:service with:parameter];
			});
		}
		else {
			[self.view makeToast:@"登录失败"];
		}
	}
	else {
		if ([result isKindOfClass:[NSDictionary class]]) {
			UserInfo *userInfo = [[UserInfo alloc] init];
			userInfo.userTelephone = self.account.text;
			userInfo.userPassword = self.password.text;
			userInfo.SN = result[@"equipmentSNnum"];

			if (result[@"carLicenseid"] && ![result[@"carLicenseid"] isKindOfClass:[NSNull class]]) {
				userInfo.carLicense = result[@"carLicenseid"];

				[self performSegueWithIdentifier:kMainIndex sender:nil];
			}
			else {
				[self performSegueWithIdentifier:kCarInfo sender:nil];
			}

			[kAppDelegate saveUserInfo:userInfo];
		}
	}
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

#pragma mark

- (void)saveUserInfo {
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kCarInfo]) {
		CarInfoViewController *controller = segue.destinationViewController;
		controller.pushFromLogin = YES;
	}
	else if ([segue.identifier isEqualToString:kRegister]) {
		RegisterViewController *controller = segue.destinationViewController;
		controller.accountForRegister = self.account.text;
		controller.passwordForRegister = self.password.text;
	}
}

@end
