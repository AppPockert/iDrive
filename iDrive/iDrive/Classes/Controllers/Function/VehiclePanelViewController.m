//
//  VehiclePanelViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-28.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "VehiclePanelViewController.h"
#import "WMGaugeView.h"
#import "SCGIFImageView.h"
#import "GetCarPanelInfoRequestParameter.h"
#import "UserInfo.h"
#import "RequestService.h"

@interface VehiclePanelViewController ()

@property (weak, nonatomic) IBOutlet UILabel *voltage;
@property (weak, nonatomic) IBOutlet UIView *temperature;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *solarTerm; // 节气门开度
@property (weak, nonatomic) IBOutlet UILabel *engineLoad; // 发动机负荷
@property (weak, nonatomic) IBOutlet UIView *solarTermView;
@property (weak, nonatomic) IBOutlet UIView *engineLoadView;

@property (weak, nonatomic) IBOutlet UILabel *iFuelConsumption; // 瞬时油耗
@property (weak, nonatomic) IBOutlet UILabel *aFuelConsumption; //平均油耗
@property (weak, nonatomic) IBOutlet UIView *iFuelConsumptionView;
@property (weak, nonatomic) IBOutlet UIView *aFuelConsumptionView;

@property (weak, nonatomic) IBOutlet UIImageView *engieSpeed; // 发动机转速
@property (weak, nonatomic) IBOutlet UIImageView *runningSpeed; // 行驶车速


@end

@implementation VehiclePanelViewController


- (void)viewDidLoad {
	[super viewDidLoad];


	[self.temperature addSubview:[self gifImageNamed:@"温度计表动画背景.gif" atFrame:self.temperature.bounds]];
	[self.iFuelConsumptionView addSubview:[self gifImageNamed:@"瞬时油耗动画.gif" atFrame:CGRectMake(0, 0, 130, 57)]];

	GetCarPanelInfoRequestParameter *parameter = [[GetCarPanelInfoRequestParameter alloc] init];
	parameter.equipmentSNnum = [[kAppDelegate getUserInfo] SN];

	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSDictionary class]]) {
		self.voltage.text = result[@"batteryVoltage"];
		self.tempLabel.text = [NSString stringWithFormat:@"%@%%", result[@"coolantTemperature"]];

		[self setSolarterm:[result[@"throttlePercentage"] intValue]];
		[self setEngieLoad:[result[@"engineLoad"] intValue]];
		[self setiFuelConsumption:[result[@"instantOilConsumption"] intValue]];
		[self setaFuelConsumption:[result[@"avlOilConsumption"] intValue]];
		[self setengieSpeed:[result[@"rotateSpeed"] intValue]];
		[self setrunningSpeed:[result[@"carSpeed"] intValue]];
	}
}

- (SCGIFImageView *)gifImageNamed:(NSString *)imgName atFrame:(CGRect)frame {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
	SCGIFImageView *gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
	gifImageView.frame = frame;

	return gifImageView;
}

// 设置节气门开度
- (void)setSolarterm:(int)value {
	[UIView animateWithDuration:.5 animations: ^{
	    CGRect frame = self.solarTermView.frame;
	    frame.origin.y = 113 - 57 * value / 100;
	    self.solarTermView.frame = frame;
	}];

	[self.solarTerm setText:[NSString stringWithFormat:@"%i%%", value]];
}

// 设置发动机负荷
- (void)setEngieLoad:(int)value {
	[UIView animateWithDuration:.5 animations: ^{
	    CGRect frame = self.engineLoadView.frame;
	    frame.origin.y = 113 - 57 * value / 100;
	    self.engineLoadView.frame = frame;
	}];
	[self.engineLoad setText:[NSString stringWithFormat:@"%i%%", value]];
}

// 设置瞬时油耗
- (void)setiFuelConsumption:(int)value {
	self.iFuelConsumption.text = [NSString stringWithFormat:@"%d", value];

	CGRect frame = self.iFuelConsumptionView.frame;
	frame.size.width = 130 * value / 100;
	self.iFuelConsumptionView.frame = frame;
}

// 设置平均油耗
- (void)setaFuelConsumption:(int)value {
	self.aFuelConsumption.text = [NSString stringWithFormat:@"%d", value];

	__block CGRect frame = self.aFuelConsumptionView.frame;
	frame.origin.y = 113 - 57 * value / 100;
	frame.size.width = 0;
	self.aFuelConsumptionView.frame = frame;

	[UIView animateWithDuration:.5 animations: ^{
	    frame.size.width = 128;
	    self.aFuelConsumptionView.frame = frame;
	}];
}

// 设置发动机转速
- (void)setengieSpeed:(int)speed {
	self.engieSpeed.transform = CGAffineTransformIdentity;
	[UIView animateWithDuration:0.5 animations: ^{
	    CGAffineTransform transform = CGAffineTransformMakeRotation((speed - 30) * 3 * M_PI / 180.f);
	    self.engieSpeed.transform = transform;
	}];
}

// 设置行驶车速
- (void)setrunningSpeed:(int)speed {
	self.runningSpeed.transform = CGAffineTransformIdentity;
	[UIView animateWithDuration:0.5 animations: ^{
	    CGAffineTransform transform = CGAffineTransformMakeRotation((speed - 80) * 9  * M_PI / (8 * 180.f));
	    self.runningSpeed.transform = transform;
	}];
}

@end
