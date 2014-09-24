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

#define kMainIndex        @"MainIndex"        // 首页
#define kLogin            @"Login"            // 登陆
#define kRegister         @"Register"         // 注册
#define kItineraryHistory @"ItineraryHistory" // 历史轨迹
#define kVehicleExam      @"VehicleExam"      // 车辆体检
#define kRealTimeTraj     @"RealTimeTraj"     // 实时轨迹
#define kCarInfo          @"CarInfo"          // 车辆信息
#define kCarInfoDetail    @"CarInfoDetail"    // 车辆信息详情
#define kCarBrand         @"CarBrand"         // 汽车品牌
#define kInsuranceCompany @"InsuranceCompany" // 保险公司
#define kItinerayDetial   @"ItinerayDetial"   // 行程详情

#define kServerSetting    @"ServerSetting"

#define kMainIndexNav     @"MainIndexNav"
#define kLoginNav         @"LoginNav"
#define kIntroductionNav  @"IntroductionNav"
#define kMainTab          @"MainTab"


#pragma mark - UserDefaultKey

#define kUserInfo         @"UserInfo"
#define kFirstLaunched    @"FirstLaunched"

#define TestServer        @"TestServer"

#pragma mark - Common

#define kAppDelegate      ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define kScreenHeight     ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth      320.f // 暂不对应iphone6的宽屏
#define kNavBarHeight     64.f  // 包含状态栏

#define kScreenHeight568  568.f
#define kScreenHeight480  480.f


#define RGB(r, g, b)      [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1.0]
#define RGBA(r, g, b, a)  [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : a / 255.0]

#define HexRGB(rgbValue)  [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]



#pragma mark - Request API

#define kBaseURL                 @"http://localhost:8080"

#define kLoginRequestUrl         @"/EasyCarServer/struts/loginAction!doLogin?userTelephone=%@&userPassword=%@"
#define kRegisterRequestUrl      @"/EasyCarServer/struts/registerAction!doRegister?userCarlicense=%@&userIdcard=%@&userPassword=%@&userTelephone=%@&userTianyitongid=%@"
#define kCarInfoRequestUrl       @"/EasyCarServer/struts/carInfoAction!queryCarInfo?userId=%@"
#define kRealTimeTrajectoryUrl   @"/EasyCarServer/struts/carTravelAction!doSelectLastTravelInfo?tdCarId=%@"
#define kItineraryHistoryUrl     @"/EasyCarServer/struts/carTravelAction!doSelectTravelInfoList?tdCarId=%@&startTime=%@&endTime=%@"
#define kExaminationInfoUrl      @"/EasyCarServer/struts/carInfoAction!queryCarTestInfo?carId=%@"

#endif
