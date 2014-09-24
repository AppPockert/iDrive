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

@interface VehicleExaminationViewController ()
{
	int progress;
	NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIView *examView;
@property (weak, nonatomic) IBOutlet UIButton *beginExamBtn;    // 开始体检
@property (weak, nonatomic) IBOutlet GPLoadingView *indicator;  // 等待指示器
@property (weak, nonatomic) IBOutlet UILabel *stautsLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (strong, nonatomic) CheckItemListView *checkListView; // 检测列表

@end

@implementation VehicleExaminationViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	_checkListView = [[CheckItemListView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:_checkListView];

	self.checkListView.hidden = YES;
	self.indicator.lineColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark -

// 开始检测
- (IBAction)beginExam:(id)sender {
	self.beginExamBtn.userInteractionEnabled = NO;
	[self.beginExamBtn setTitle:@"" forState:UIControlStateNormal];
	[self.indicator startAnimation];

	[self.stautsLabel setHidden:NO];

	progress = 0;
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doCheck:) userInfo:nil repeats:YES];

	[self.examView bringSubviewToFront:self.progressLabel];
	[self.progressLabel setText:@"0%"];
}

#pragma mark -

- (void)doCheck:(NSTimer *)sender {
	progress++;
	[self.progressLabel setText:[NSString stringWithFormat:@"%i%%", progress * 10]];

	if (progress == 10) {
		[timer invalidate];
		[self.examView setHidden:YES];
	}
}

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
