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

	BehaviorAnalysisRequestParameter *parameter = [[BehaviorAnalysisRequestParameter alloc] init];
	parameter.equipmentSNnum = [[kAppDelegate getUserInfo] SN];

	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
