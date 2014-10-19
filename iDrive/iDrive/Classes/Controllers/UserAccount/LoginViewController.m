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
#import "GetCarInfoRequestParameter.h"
#import "UserInfo.h"

const int LoginRequest = 1;
const int CarInfoRequest = 2;

@interface LoginViewController () <UITextFieldDelegate>
{
	UITapGestureRecognizer *_tap;
}

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *account;  // 用户名
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *password; // 密码

@end

@implementation LoginViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    // 添加消键盘事件
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
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
// 登录事件
- (IBAction)login:(id)sender {
	[self.view endEditing:YES];

	// check账号
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

	// 向服务器提交登录请求
	RequestService *servive = [[RequestService alloc] init];
	servive.tag = LoginRequest;
	LoginRequestParameter *parameter = [[LoginRequestParameter alloc] init];
	parameter.userTelephone = self.account.text;
	parameter.userPassword = self.password.text;

	[self sendRequestTo:servive with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	// 登录结果处理
	if (service.tag == LoginRequest) {
		if ([result isKindOfClass:[NSArray class]] && [result[0] isEqualToString:kResultSuccess]) {

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			    // 登录成功后，再去服务器获取当前用户的车辆信息
			    RequestService *carInfoService = [[RequestService alloc] init];
			    carInfoService.tag = CarInfoRequest;

			    // 获取车辆信息时的参数
			    GetCarInfoRequestParameter *parameter = [[GetCarInfoRequestParameter alloc] init];
			    parameter.userId = self.account.text;

			    [self sendRequestTo:carInfoService with:parameter];
			});
		}
		else {
			[self.view makeToast:@"账号或密码错误"];
		}
	}
	// 获取车辆信息结果处理
	else {
		if ([result isKindOfClass:[NSDictionary class]]) {
			UserInfo *userInfo = [[UserInfo alloc] init];
			userInfo.userTelephone = self.account.text;
			userInfo.userPassword = self.password.text;
			userInfo.SN = result[@"equipmentSNnum"];

			if (result[@"carLicense"] && ![result[@"carLicense"] isKindOfClass:[NSNull class]]) {
				userInfo.carLicense = result[@"carLicense"];

				// 用户提交过车辆信息，则直接跳转到主页面
				[self performSegueWithIdentifier:kMainIndex sender:nil];
			}
			else {
				// 用户未提交过车辆信息，则跳转到车辆信息页面
				[self performSegueWithIdentifier:kCarInfo sender:nil];
			}

			[kAppDelegate saveUserInfo:userInfo];
		}
	}
}

#pragma mark - 取消键盘事件

- (void)keyboardWillShow:(id)sender {
	[self.view addGestureRecognizer:_tap];
}

- (void)keyboardWillHide:(id)sender {
	[self.view removeGestureRecognizer:_tap];
}

- (void)dismissKeyboard:(id)sender {
	[self.view endEditing:YES];
}

#pragma mark - 页面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kCarInfo]) {
		CarInfoViewController *controller = segue.destinationViewController;
		controller.shouldUpdate = NO;
		controller.isFirstTimeToFill = YES;
	}
	else if ([segue.identifier isEqualToString:kRegister]) {
		RegisterViewController *controller = segue.destinationViewController;
		controller.accountForRegister = self.account.text;
		controller.passwordForRegister = self.password.text;
	}
}

@end
