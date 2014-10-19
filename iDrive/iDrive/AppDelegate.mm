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
#import "Reachability.h"

@interface AppDelegate ()

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

	// 程序启动过
	if ([userDefaults boolForKey:kFirstLaunched]) {
		// 已登录
		if ([self getUserInfo]) {
			if ([[self getUserInfo] carLicense]) {
				identifier = kMainTabNav;
			}
			else {
				identifier = kCarInfoNav;
			}
		}
		// 未登录
		else {
			identifier = kLoginNav;
		}
	}
	// 程序首次启动
	else {
		identifier = kIntroductionNav;
	}

	_navigationController = [storyboard instantiateViewControllerWithIdentifier:identifier];
	self.window.rootViewController = _navigationController;

	[self.window makeKeyAndVisible];

	// 初始化百度地图
	[self initMap];

    // 车辆异动检测
    _carAbnormalService = [[CarAbnormalService alloc] init];
	if ([userDefaults boolForKey:kCarAbnormal]) {
		[_carAbnormalService shouldCheckCarAbnormal:YES];
	}

#if TestVersion
	[self setTestServer];
#endif
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == kNotReachable) {
        [self.window makeToast:@"网络未设置，请先检查网络设置"];
    }

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.carAbnormalService applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.carAbnormalService applicationWillEnterForeground:(UIApplication *)application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 百度地图

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

#pragma mark

- (void)logout {
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfo];
	[[NSUserDefaults standardUserDefaults] synchronize];

	for (UIViewController *controller in[self.navigationController viewControllers]) {
		if ([NSStringFromClass([controller class]) isEqualToString:@"MainTabViewController"]) {
			[controller performSegueWithIdentifier:kLogout sender:nil];
			break;
		}
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
