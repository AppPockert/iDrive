//
//  AppDelegate.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-17.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "BMapKit.h"
#import "UserInfo.h"
#import "PlistFilePathManager.h"
#import "ServerSettingViewController.h"
#import "ASIHTTPRequest.h"

@interface AppDelegate () <ASIHTTPRequestDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;

@end

@implementation AppDelegate
{
	BMKMapManager *_mapManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *identifier;

	do {
		// 程序启动过
		if ([userDefaults boolForKey:kFirstLaunched]) {
			// 未登录
			if ([userDefaults objectForKey:kUserInfo]) {
				identifier = kLoginNav;
			}
			// 已登录
			else {
				self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:kMainTab];
				break;
			}
		}
		// 程序首次启动
		else {
			identifier = kIntroductionNav;
		}

		_navigationController = [storyboard instantiateViewControllerWithIdentifier:identifier];
		self.window.rootViewController = _navigationController;
	}
	while (0);

	[self.window makeKeyAndVisible];

	// 初始化百度地图
	[self initMap];

	if ([userDefaults boolForKey:kCarAbnormal]) {
		[self checkCarAbnormal];
	}

#if TestVersion
	[self setTestServer];
#endif

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark

/**
 *  初始化百度地图
 */
- (void)initMap {
	_mapManager = [[BMKMapManager alloc]init];
	// 如果要关注网络及授权验证事件，请设定     generalDelegate参数
	BOOL ret = [_mapManager start:@"G5nD4yh2tSuoUWL8sjSuh7GL"  generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
}

- (UserInfo *)getUserInfo {
	NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfo];
	UserInfo *userInfo = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
	return userInfo;
}

- (void)saveUserInfo:(UserInfo *)userInfo {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserInfo];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)shouldCheckCarAbnormal:(BOOL)check {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkCarAbnormal) object:nil];
	if (check) {
		[self checkCarAbnormal];
	}
}

- (void)checkCarAbnormal {
#warning 替换url
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:nil]];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	request.delegate = self;
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[self performSelector:@selector(checkCarAbnormal) withObject:nil afterDelay:300.f];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self performSelector:@selector(checkCarAbnormal) withObject:nil afterDelay:300.f];
}

#if TestVersion
#pragma mark - 设置测试服务器地址

- (void)setTestServer {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showServerSetting:)];
	tap.numberOfTapsRequired = 4;

	[self.window addGestureRecognizer:tap];
}

- (void)showServerSetting:(id)sender {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	ServerSettingViewController *serverSetting = [storyboard instantiateViewControllerWithIdentifier:kServerSetting];
	[self.navigationController presentViewController:serverSetting animated:YES completion:nil];
}

#endif

@end
