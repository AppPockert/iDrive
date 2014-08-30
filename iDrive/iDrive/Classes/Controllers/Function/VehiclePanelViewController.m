//
//  VehiclePanelViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-28.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "VehiclePanelViewController.h"
#import "WMGaugeView.h"

@interface VehiclePanelViewController ()

@property (weak, nonatomic) IBOutlet WMGaugeView *gauge1;
@property (weak, nonatomic) IBOutlet WMGaugeView *gauge2;
@property (weak, nonatomic) IBOutlet WMGaugeView *gauge3;
@property (weak, nonatomic) IBOutlet WMGaugeView *gauge4;

@end

@implementation VehiclePanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	_gauge1.maxValue = 240.0;
	_gauge1.showRangeLabels = YES;
	_gauge1.rangeValues = @[@50,                  @90,                @130,               @240.0];
	_gauge1.rangeColors = @[RGB(232, 111, 33),    RGB(232, 231, 33),  RGB(27, 202, 33),   RGB(231, 32, 43)];
	_gauge1.rangeLabels = @[@"VERY LOW",          @"LOW",             @"OK",              @"OVER FILL"];
	_gauge1.unitOfMeasurement = @"psi";
	_gauge1.showUnitOfMeasurement = YES;


	_gauge2.maxValue = 240.0;
	_gauge2.showRangeLabels = YES;
	_gauge2.rangeValues = @[@50,                  @90,                @130,               @240.0];
	_gauge2.rangeColors = @[RGB(232, 111, 33),    RGB(232, 231, 33),  RGB(27, 202, 33),   RGB(231, 32, 43)];
	_gauge2.rangeLabels = @[@"VERY LOW",          @"LOW",             @"OK",              @"OVER FILL"];
	_gauge2.unitOfMeasurement = @"psi";
	_gauge2.showUnitOfMeasurement = YES;


	_gauge3.maxValue = 240.0;
	_gauge3.showRangeLabels = YES;
	_gauge3.rangeValues = @[@50,                  @90,                @130,               @240.0];
	_gauge3.rangeColors = @[RGB(232, 111, 33),    RGB(232, 231, 33),  RGB(27, 202, 33),   RGB(231, 32, 43)];
	_gauge3.rangeLabels = @[@"VERY LOW",          @"LOW",             @"OK",              @"OVER FILL"];
	_gauge3.unitOfMeasurement = @"psi";
	_gauge3.showUnitOfMeasurement = YES;


	_gauge4.maxValue = 100.0;
	_gauge4.scaleDivisions = 10;
	_gauge4.scaleSubdivisions = 5;
	_gauge4.scaleStartAngle = 30;
	_gauge4.scaleEndAngle = 280;
	_gauge4.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
	_gauge4.showScaleShadow = NO;
	_gauge4.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
	_gauge4.scalesubdivisionsaligment = WMGaugeViewSubdivisionsAlignmentCenter;
	_gauge4.scaleSubdivisionsWidth = 0.002;
	_gauge4.scaleSubdivisionsLength = 0.04;
	_gauge4.scaleDivisionsWidth = 0.007;
	_gauge4.scaleDivisionsLength = 0.07;
	_gauge4.needleStyle = WMGaugeViewNeedleStyleFlatThin;
	_gauge4.needleWidth = 0.012;
	_gauge4.needleHeight = 0.4;
	_gauge4.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain;
	_gauge4.needleScrewRadius = 0.05;
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
