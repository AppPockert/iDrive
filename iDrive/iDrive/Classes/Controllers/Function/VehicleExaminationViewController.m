//
//  VehicleExaminationViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "VehicleExaminationViewController.h"
#import "GPLoadingView.h"
#import "CheckItemListView.h"
#import "PlistFilePathManager.h"
#import "GetExaminationInfoRequestParameter.h"
#import "RequestService.h"

#define  FileName    @"ExaminationItem.plist"

@interface VehicleExaminationViewController ()
{
	int progress;
	NSTimer *timer;

	BOOL _listCheckDone;
	BOOL _getDataDone;
}

@property (weak, nonatomic) IBOutlet UIView *examView;
@property (weak, nonatomic) IBOutlet UIButton *beginExamBtn;    // 开始体检
@property (weak, nonatomic) IBOutlet GPLoadingView *indicator;  // 等待指示器
@property (weak, nonatomic) IBOutlet UILabel *stautsLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (strong, nonatomic) CheckItemListView *checkListView; // 检测列表

@property (strong, nonatomic) NSMutableArray *checkList;

/*------------------------------*/

@property (weak, nonatomic) IBOutlet UILabel *sumOilConsumption;
@property (weak, nonatomic) IBOutlet UILabel *sumMileage;
@property (weak, nonatomic) IBOutlet UILabel *currentOilConsumption;
@property (weak, nonatomic) IBOutlet UILabel *avlOilConsumption;
@property (weak, nonatomic) IBOutlet UILabel *batteryVoltage;
@property (weak, nonatomic) IBOutlet UILabel *rotateSpeed;
@property (weak, nonatomic) IBOutlet UILabel *carSpeed;
@property (weak, nonatomic) IBOutlet UILabel *coolantTemperature;

@end

@implementation VehicleExaminationViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	_checkListView = [[CheckItemListView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:_checkListView];

	self.checkListView.hidden = YES;
	self.indicator.lineColor = [UIColor yellowColor];

	NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];
	_checkList = [NSArray arrayWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark -

// 开始检测
- (IBAction)beginExam:(id)sender {
	GetExaminationInfoRequestParameter *p = [[GetExaminationInfoRequestParameter alloc] init];
	p.equipmentSNnum = @"vip10";
	[self sendRequestTo:[[RequestService alloc] init] with:p];

	self.beginExamBtn.userInteractionEnabled = NO;
	[self.beginExamBtn setTitle:@"" forState:UIControlStateNormal];
	[self.indicator startAnimation];

	[self.stautsLabel setHidden:NO];

	[self.examView bringSubviewToFront:self.progressLabel];
	[self.progressLabel setText:@"0%"];
}

#pragma mark -

- (void)doCheck:(NSTimer *)sender {
	progress++;
	[self.progressLabel setText:[NSString stringWithFormat:@"%i%%", 100 * (progress + 1) / self.checkList.count]];
	[self.stautsLabel setText:[NSString stringWithFormat:@"正在检测: %@", self.checkList[progress]]];

	if (progress == [self.checkList count] - 1) {
		[timer invalidate];

		[UIView animateWithDuration:0.2 delay:100 / self.checkList.count options:UIViewAnimationOptionCurveEaseInOut animations: ^{
		    self.examView.alpha = 0;
		} completion: ^(BOOL finished) {
		    [self.examView setHidden:YES];
		}];
	}
}

#pragma mark

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSDictionary class]]) {
		if ([[result allKeys] containsObject:@"error"]) {
			[self examinationFailed];
		}
		else {
			progress = -1;
			timer = [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(doCheck:) userInfo:nil repeats:YES];

			self.sumOilConsumption.text = [NSString stringWithFormat:@"%@ 升", result[@"sumOilConsumption"]];
			self.sumMileage.text = [NSString stringWithFormat:@"%@ 公里", result[@"sumMileage"]];
			self.currentOilConsumption.text = [NSString stringWithFormat:@"%@ 升", result[@"currentOilConsumption"]];
			self.avlOilConsumption.text = [NSString stringWithFormat:@"%@ 升", result[@"avlOilConsumption"]];
			self.batteryVoltage.text = [NSString stringWithFormat:@"%@ 伏", result[@"batteryVoltage"]];
			self.carSpeed.text = [NSString stringWithFormat:@"%@ 公里/小时", result[@"carSpeed"]];
			self.rotateSpeed.text = [NSString stringWithFormat:@"%@ 转/分钟", result[@"rotateSpeed"]];
			self.coolantTemperature.text = [NSString stringWithFormat:@"%@ 度", result[@"coolantTemperature"]];
		}
	}
	else {
		[self examinationFailed];
	}
}

- (void)examinationFailed {
	[self.view makeToast:@"获取车辆体检信息失败，请稍后重试"];

	self.beginExamBtn.userInteractionEnabled = YES;
	[self.beginExamBtn setTitle:@"开始体检" forState:UIControlStateNormal];
	[self.indicator stopAnimation];
	[self.stautsLabel setHidden:YES];
	[self.examView bringSubviewToFront:self.beginExamBtn];
}

@end
