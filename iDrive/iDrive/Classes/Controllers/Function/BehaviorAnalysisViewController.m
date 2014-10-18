//
//  BehaviorAnalysisViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-25.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "BehaviorAnalysisViewController.h"
#import "BehaviorAnalysisRequestParameter.h"
#import "UserInfo.h"
#import "RequestService.h"
#import "NSStringUtil.h"

@interface BehaviorAnalysisViewController ()

@property (weak, nonatomic) IBOutlet UILabel *carBrand;          // 车型
@property (weak, nonatomic) IBOutlet UILabel *oilConsumptionPM;  // 百公里油耗
@property (weak, nonatomic) IBOutlet UILabel *oilConsumption;    // 瞬时油耗
@property (weak, nonatomic) IBOutlet UILabel *averageSpeed;      // 平均速度
@property (weak, nonatomic) IBOutlet UILabel *rapidAcceleration; // 急加速
@property (weak, nonatomic) IBOutlet UILabel *rapidDeceleration; // 急减速
@property (weak, nonatomic) IBOutlet UILabel *sharpTurn;         // 急转弯

@end

@implementation BehaviorAnalysisViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	HUD.labelText = @"正在分析，请稍后...";
	BehaviorAnalysisRequestParameter *parameter = [[BehaviorAnalysisRequestParameter alloc] init];
	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSDictionary class]]) {
		if ([[result allKeys] containsObject:@"error"]) {
			[self.view makeToast:@"获取分析数据失败，请稍后重试"];
		}
		else {
			// 车型
			if ([NSStringUtil isValidate:result[@"carModel"]]) {
				self.carBrand.text = [NSString stringWithFormat:@"车型：%@", result[@"carModel"]];
			}
			// 百公里油耗
			if ([NSStringUtil isValidate:result[@"avlOilHundMeter"]]) {
				self.oilConsumptionPM.text = [NSString stringWithFormat:@"%@ L", result[@"avlOilHundMeter"]];
			}
			// 瞬时油耗
			if ([NSStringUtil isValidate:result[@"currentOilConsumption"]]) {
				self.oilConsumption.text = [NSString stringWithFormat:@"%@ L", result[@"currentOilConsumption"]];
			}
			// 平均速度
			if ([NSStringUtil isValidate:result[@"avlSpeed"]]) {
				self.averageSpeed.text = [NSString stringWithFormat:@"%@ km/h", result[@"avlSpeed"]];
			}
			// 急加速
			if ([NSStringUtil isValidate:result[@"addSpeed"]]) {
				self.rapidAcceleration.text = [NSString stringWithFormat:@"%@ 次", result[@"addSpeed"]];
			}
			// 急减速
			if ([NSStringUtil isValidate:result[@"reduceSpeed"]]) {
				self.rapidDeceleration.text = [NSString stringWithFormat:@"%@ 次", result[@"reduceSpeed"]];
			}
			// 急转弯
			if ([NSStringUtil isValidate:result[@"wheel"]]) {
				self.sharpTurn.text = [NSString stringWithFormat:@"%@ 次", result[@"wheel"]];
			}
		}
	}
	else {
		[self.view makeToast:@"获取分析数据失败，请稍后重试"];
	}
}

@end
