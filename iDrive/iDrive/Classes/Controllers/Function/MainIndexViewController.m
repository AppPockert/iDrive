//
//  MainIndexViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "MainIndexViewController.h"
#import "CDCircleOverlayView.h"

#define IntroductionImgs  @[@"主界面-车辆监控", @"主界面-车辆信息", @"主界面-车险及保养", @"主界面-车辆体检", @"主界面-实时轨迹", @"主界面-行为分析", @"主界面-行程管理", @"主界面-车辆异动", @"主界面-道路救援"]
#define FunctionBtns      @[@"圆盘按钮-车辆监控", @"圆盘按钮-车辆信息", @"圆盘按钮-车险及保养", @"圆盘按钮-车辆体检", @"圆盘按钮-实时轨迹", @"圆盘按钮-行为分析", @"圆盘按钮-行程管理", @"圆盘按钮-车辆异动", @"圆盘按钮-道路救援"]
#define Identifiers       @[@"Panel", @"CarInfo", @"AutoInsurance", @"Exam", @"RealTime", @"Behavior", @"History", @"Abnormal", @"Recscue"]

@interface MainIndexViewController () <CDCircleDataSource, CDCircleDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *introduction;

@end

@implementation MainIndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(14, 199.5, 291, 291) numberOfSegments:9 ringWidth:91.5f];
	circle.dataSource = self;
	circle.delegate = self;
	CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];

	[self.view addSubview:circle];
	//Overlay cannot be subview of a circle because then it would turn around with the circle
	[self.view addSubview:overlay];
	[self.view bringSubviewToFront:[self.view viewWithTag:100]];

	overlay.overlayThumb.arcColor = [UIColor clearColor];
	overlay.overlayThumb.separatorColor = [UIColor clearColor];

	for (CDCircleThumb *thumb in circle.thumbs) {
		[thumb.iconView setHighlitedIconColor:[UIColor clearColor]];
		thumb.separatorColor = [UIColor clearColor];
		thumb.separatorStyle = CDCircleThumbsSeparatorNone;
		thumb.gradientFill = NO;
		thumb.arcColor = [UIColor clearColor];

		CGRect frame = thumb.iconView.frame;
		frame.size.height = 91.5;
		frame.size.width = 100;
		frame.origin.x = 0;
		frame.origin.y = 0;
		thumb.iconView.frame = frame;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Circle delegate & data source

- (void)circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
	[self.introduction setImage:[UIImage imageNamed:IntroductionImgs[segment]]];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	    [self performSegueWithIdentifier:Identifiers[segment] sender:nil];
	});
}

- (UIImage *)circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
	return [UIImage imageNamed:FunctionBtns[row]];
}

@end
