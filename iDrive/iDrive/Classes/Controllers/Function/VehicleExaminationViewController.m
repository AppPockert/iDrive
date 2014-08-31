//
//  VehicleExaminationViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-30.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "VehicleExaminationViewController.h"
#import "GPLoadingView.h"

@interface VehicleExaminationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beginExamBtn;    // 开始体检
@property (weak, nonatomic) IBOutlet GPLoadingView *indicator;  // 等待指示器

@end

@implementation VehicleExaminationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)beginExam:(id)sender {
	[self.indicator startAnimation];
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
