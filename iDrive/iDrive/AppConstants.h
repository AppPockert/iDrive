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
#define kLogout           @"Logout"           // 注销
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
#define kMainTabNav       @"MainTabNav"
#define kCarInfoNav       @"CarInfoNav"

#pragma mark - UserDefaultKey

#define kUserInfo         @"UserInfo"
#define kFirstLaunched    @"FirstLaunched"
#define kCarAbnormal      @"CarAbnormal"

#define kEngineOil        @"HasEngineOil"
#define kAirConditioner   @"HasAirConditioner"

#define kResultSuccess    @"success"

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

#define kBaseURL                 @"http://121.40.85.106:8082"
//#define kBaseURL                 @"http://117.89.129.25:7788"

// 登录
#define kLoginRequestUrl         @"/EasyCarServer/struts/loginAction!doLogin?userTelephone=%@&userPassword=%@"
// 注册
#define kRegisterRequestUrl      @"/EasyCarServer/struts/registerAction!doRegister?userCarlicense=%@&userIdcard=%@&userPassword=%@&userTelephone=%@&userTianyitongid=%@"
// 获取车辆信息
#define kCarInfoRequestUrl       @"/EasyCarServer/struts/carInfoAction!queryCarInfo?userTelephone=%@"
// 实时轨迹
#define kRealTimeTrajectoryUrl   @"/EasyCarServer/struts/carTravelAction!doSelectLastTravelInfo?equipmentSNnum=%@"
// 查询历史历程
#define kItineraryHistoryUrl     @"/EasyCarServer/struts/carTravelAction!doSelectTravelInfoList?equipmentSNnum=%@&startTime=%@&endTime=%@"
// 获取体检信息
#define kExaminationInfoUrl      @"/EasyCarServer/struts/carInfoAction!queryCarTestInfo?equipmentSNnum=%@"
// 添加车辆信息
#define kAddCarIno               @"/EasyCarServer/struts/carInfoAction!addCarInfo?icName=%@&ciiInsuranceType=%@&ciiInsurancetimeLeft=%@&ciiMaintaintimeLeft=%@&ciiMaintaindistanceLeft=%@&carLicenseid=%@&carModel=%@&carDriver=%@&userTianyitongid=%@"
// 编辑保存车辆信息
#define kSaveCarIno               @"/EasyCarServer/struts/carInfoAction!updateCarInfo?icName=%@&ciiInsuranceType=%@&ciiInsurancetimeLeft=%@&ciiMaintaintimeLeft=%@&ciiMaintaindistanceLeft=%@&carLicenseid=%@&carModel=%@&carDriver=%@&userTianyitongid=%@&userTelephone=%@"
// 行为分析
#define kBehaviorAnalysis         @"/EasyCarServer/struts/carTravelAction!selectCartreval?equipmentSNnum=%@"
// 获取车辆面板的监控信息
#define kCarPanel                 @"/EasyCarServer/struts/carTravelAction!selectCarControl?equipmentSNnum=%@"
// 获取车辆异动信息
#define kCarAbnormalUrl           @"/EasyCarServer/struts/carTravelAction!selectCarAbnormal?equipmentSNnum=%@"
// 获取车险及保养信息
#define kGetMaintenanceInfoUrl    @"/EasyCarServer/struts/insuranceInfoAction!queryInsuranceInfo?userTelephone=%@"
// 保存车型及保养信息
#define kSaveMaintenanceInfoUrl   @"/EasyCarServer/struts/insuranceInfoAction!updateInsuranceInfo?userTelephone=%@&icName=%@&ciiInsuranceType=%@&ciiInsurancetimeLeft=%@&ciiMaintaintimeLeft=%@&ciiMaintaindistanceLeft=%@&ciiMaintainInfo=1"

#define kGetCarTestInfo           @"/EasyCarServer/struts/carInfoAction!getCarTestInfo"

#endif
