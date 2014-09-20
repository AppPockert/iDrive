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

@property (weak, nonatomic) IBOutlet UIButton *beginExamBtn;    // 开始体检
@property (weak, nonatomic) IBOutlet GPLoadingView *indicator;  // 等待指示器

@property (strong, nonatomic) CheckItemListView *checkListView; // 检测列表

@end

@implementation VehicleExaminationViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	_checkListView = [[CheckItemListView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:_checkListView];

	self.checkListView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark -

// 开始检测
- (IBAction)beginExam:(id)sender {
	[self.indicator startAnimation];
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
