//
//  AppDelegate.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-29.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfo;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)logout;

- (UserInfo *)getUserInfo;
- (void)saveUserInfo:(UserInfo *)userInfo;

- (void)shouldCheckCarAbnormal:(BOOL)check;

@end
