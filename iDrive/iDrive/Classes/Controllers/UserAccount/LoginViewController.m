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
#import "AccountRequestParameter.h"
#import "CarInfoViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController () <UITextFieldDelegate, UIScrollViewDelegate>
{
	UITapGestureRecognizer *_tap;
}

@property (weak, nonatomic) IBOutlet UIView *introductionView;

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIImageView *car;

@property (weak, nonatomic) IBOutlet UIImageView *pageController;

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

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

	if (![userDefaults boolForKey:kFirstLaunched]) {
		self.introductionView.hidden = NO;

		[userDefaults setBool:YES forKey:kFirstLaunched];
		[userDefaults synchronize];
	}

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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	// 到左边第一张展示不能滑动
	if (scrollView.contentOffset.x < 0) {
		scrollView.userInteractionEnabled = NO;
		return;
	}

	// 最后一张后结束
	if (scrollView.contentOffset.x > scrollView.contentSize.width) {
		scrollView.userInteractionEnabled = NO;
		self.introductionView.hidden = YES;
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	scrollView.userInteractionEnabled = YES;
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

#warning 暂时写死，等服务器通了再替换成与服务器交互
	// test
	if ([self.account.text isEqualToString:@"13611113333"] && [self.password.text isEqualToString:@"123456"]) {
		[self performSegueWithIdentifier:kCarInfo sender:nil];
	}
	else {
		[self.view makeToast:@"手机号码未注册"];
	}

//	TestLoginService *servive = [[TestLoginService alloc] init];
//	AccountRequestParameter *parameter = [[AccountRequestParameter alloc] init];
//	parameter.account = self.account.text;
//	parameter.password = self.password.text;
//
//	[self sendRequestTo:servive with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	NSLog(@"%@", result);
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
