//
//  AppConstants.h
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#pragma mark - Identifer

#define kMainIndex        @"MainIndex"
#define kLogin            @"Login"
#define kRegister         @"Register"
#define kItineraryHistory @"ItineraryHistory"
#define kVehicleExam      @"VehicleExam"
#define kRealTimeTraj     @"RealTimeTraj"

#define kMainIndexNav     @"MainIndexNav"
#define kLoginNav         @"LoginNav"


#pragma mark - UserDefaultKey

#define kUserInfo         @"UserInfo"

#pragma mark - Common

#define kAppDelegate      ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define kScreenHeight     ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth      320.f
#define kStatusBarHeight  20.f

#define RGB(r, g, b)      [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1.0]
#define RGBA(r, g, b, a)  [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : a / 255.0]

#endif
