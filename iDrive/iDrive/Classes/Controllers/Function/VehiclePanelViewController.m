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

@property (weak, nonatomic) IBOutlet WMGaugeView *engieSpeedGaugeView; // 发动机转速
@property (weak, nonatomic) IBOutlet WMGaugeView *runningSpeedGaugeView; // 行驶车速


@end

@implementation VehiclePanelViewController


- (void)viewDidLoad {
	[super viewDidLoad];


	[self.temperature addSubview:[self gifImageNamed:@"温度计表动画背景.gif" atFrame:self.temperature.bounds]];
//	[self.iFuelConsumptionView addSubview:[self gifImageNamed:@"瞬时油耗动画.gif" atFrame:CGRectMake(0, 0, 130, 57)]];

	// 发动机转速
	_engieSpeedGaugeView.minValue = 0.0;
	_engieSpeedGaugeView.maxValue = 5000.0;
	_engieSpeedGaugeView.scaleDivisions = 10.0;
	_engieSpeedGaugeView.scaleSubdivisions = 10.0;
	_engieSpeedGaugeView.scaleStartAngle = 75.0;
	_engieSpeedGaugeView.scaleEndAngle = 285.0;
	_engieSpeedGaugeView.rangeValues = @[@1000, @2000, @3000, @4000, @5000.0];
	_engieSpeedGaugeView.rangeColors = @[RGB(255, 255, 255), RGB(232, 111, 33), RGB(232, 231, 33), RGB(27, 202, 33), RGB(231, 32, 43)];

	// 行驶车速
	_runningSpeedGaugeView.minValue = 0.0;
	_runningSpeedGaugeView.maxValue = 160.0;
	_runningSpeedGaugeView.scaleDivisions = 8.0;
	_runningSpeedGaugeView.scaleSubdivisions = 10.0;
	_runningSpeedGaugeView.scaleStartAngle = 75.0;
	_runningSpeedGaugeView.scaleEndAngle = 285.0;
	_runningSpeedGaugeView.rangeValues = @[@30, @60, @90, @120, @160.0];
	_runningSpeedGaugeView.rangeColors = @[RGB(255, 255, 255), RGB(232, 111, 33), RGB(232, 231, 33), RGB(27, 202, 33), RGB(231, 32, 43)];

	GetCarPanelInfoRequestParameter *parameter = [[GetCarPanelInfoRequestParameter alloc] init];
	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSDictionary class]]) {
		if ([[result allKeys] containsObject:@"error"]) {
			[self.view makeToast:@"车辆监控数据取得失败，请稍后重试"];
		}
		else {
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
	else {
		[self.view makeToast:@"车辆监控数据取得失败，请稍后重试"];
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
	    frame.origin.y = 113 - 57 * value / 100.f;
	    self.solarTermView.frame = frame;
	}];

	[self.solarTerm setText:[NSString stringWithFormat:@"%i%%", value]];
}

// 设置发动机负荷
- (void)setEngieLoad:(int)value {
	[UIView animateWithDuration:.5 animations: ^{
	    CGRect frame = self.engineLoadView.frame;
	    frame.origin.y = 113 - 57 * value / 100.f;
	    self.engineLoadView.frame = frame;
	}];
	[self.engineLoad setText:[NSString stringWithFormat:@"%i%%", value]];
}

// 设置瞬时油耗
- (void)setiFuelConsumption:(int)value {
	self.iFuelConsumption.text = [NSString stringWithFormat:@"%d", value];

	CGRect frame = self.iFuelConsumptionView.frame;
	frame.size.width = 130 * (1 - value / 100.f);
	frame.origin.x = 130 * (value / 100.f);

	[UIView animateWithDuration:.5 animations: ^{
	    self.iFuelConsumptionView.frame = frame;
	}];
}

// 设置平均油耗
- (void)setaFuelConsumption:(int)value {
	self.aFuelConsumption.text = [NSString stringWithFormat:@"%d", value];

	__block CGRect frame = self.aFuelConsumptionView.frame;
	frame.origin.y = 113 - 57 * value / 100.f;
	frame.size.width = 0;
	self.aFuelConsumptionView.frame = frame;

	[UIView animateWithDuration:.5 animations: ^{
	    frame.size.width = 128;
	    self.aFuelConsumptionView.frame = frame;
	}];
}

// 设置发动机转速
- (void)setengieSpeed:(int)speed {
	self.engieSpeedGaugeView.value = speed;
}

// 设置行驶车速
- (void)setrunningSpeed:(int)speed {
	self.runningSpeedGaugeView.value = speed;
}

@end
