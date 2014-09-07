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

	if ([userDefaults boolForKey:kFirstLaunch]) {
		if (![userDefaults objectForKey:kUserInfo]) {
			identifier = kLoginNav;
		}
		else {
			identifier = kMainIndexNav;
		}
	}
	else {
		identifier = kIntroductionNav;
	}

	_navigationController = [storyboard instantiateViewControllerWithIdentifier:identifier];

	self.window.rootViewController = _navigationController;
	[self.window makeKeyAndVisible];

	[self initMap];

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

- (void)initMap {
	_mapManager = [[BMKMapManager alloc]init];
	// 如果要关注网络及授权验证事件，请设定     generalDelegate参数
	BOOL ret = [_mapManager start:@"G5nD4yh2tSuoUWL8sjSuh7GL"  generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
}

#pragma mark

@end
