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
#define kAutoInsurance    @"AutoInsurance"    // 车险信息
#define kMaintenance      @"Maintenance"      // 保养信息
#define kHistoryList      @"HistoryList"      // 历史行程列表

#define kServerSetting    @"ServerSetting"

#define kMainIndexNav     @"MainIndexNav"
#define kLoginNav         @"LoginNav"
#define kIntroductionNav  @"IntroductionNav"
#define kMainTab          @"MainTab"


#pragma mark - UserDefaultKey

#define kUserInfo         @"UserInfo"
#define kFirstLaunched    @"FirstLaunched"
#define kCarAbnormal      @"CarAbnormal"

#define TestVersion       1
#define TestServer        @"TestServer"

#pragma mark - Common

#define kAppDelegate      ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define kScreenHeight     ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth      320.f // 暂不对应iphone6的宽屏
#define kNavBarHeight     64.f  // 包含状态栏
#define KTabBarHeight     49.f

#define kScreenHeight568  568.f
#define kScreenHeight480  480.f


#define RGB(r, g, b)      [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1.0]
#define RGBA(r, g, b, a)  [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : a / 255.0]

#define HexRGB(rgbValue)  [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]

#define kNavBarBgColor    0xa8c545



#pragma mark - Request API

//#define kBaseURL                 @"http://121.40.85.106:8081"
#define kBaseURL                 @"http://117.89.131.226:7788"

#define kLoginRequestUrl         @"/EasyCarServer/struts/loginAction!doLogin?userTelephone=%@&userPassword=%@"
#define kRegisterRequestUrl      @"/EasyCarServer/struts/registerAction!doRegister?userCarlicense=%@&userIdcard=%@&userPassword=%@&userTelephone=%@&userTianyitongid=%@"
#define kCarInfoRequestUrl       @"/EasyCarServer/struts/carInfoAction!queryCarInfo?userId=%@"
#define kRealTimeTrajectoryUrl   @"/EasyCarServer/struts/carTravelAction!doSelectLastTravelInfo?equipmentSNnum=%@"
#define kItineraryHistoryUrl     @"/EasyCarServer/struts/carTravelAction!doSelectTravelInfoList?equipmentSNnum=%@&startTime=%@&endTime=%@"
#define kExaminationInfoUrl      @"/EasyCarServer/struts/carInfoAction!queryCarTestInfo?carId=%@"


#define kTravelAction             @"/EasyCarServer/struts/carTravelAction!doSelectLastTravelInfo?equipmentSNnum='1'"
#define kSaveCarIno               @"/EasyCarServer/struts/carInfoAction!addCarInfo?icName=%@&ciiInsuranceType=%@&ciiInsurancetimeLeft=%@&ciiMaintaintimeLeft=%@&ciiMaintaindistanceLeft=%@&carLicenseid=%@&carModel=%@&carDriver=%@&userTianyitongid=%@"

//#define kSaveCarInfo @"/EasyCarServer/struts/carInfoAction!addCarInfo?icName=zhongguo&ciiInsuranceType=1&ciiInsurancetimeLeft=2014-10-08%2014:23:41&ciiMaintaintimeLeft=2014-10-08%2014:23:41&ciiMaintaindistanceLeft=1000.0&carLicenseid=A123&carModel=BMW&carDriver=zhangsan&userTianyitongid=6219034133056"

#define kBehaviorAnalysis         @"/EasyCarServer/struts/carTravelAction!selectCartreval?equipmentSNnum=%@"
#define kCarPanel                 @"/EasyCarServer/struts/carTravelAction!selectCarControl?equipmentSNnum=%@"
#define kCarAbnormalUrl           @""

#endif
