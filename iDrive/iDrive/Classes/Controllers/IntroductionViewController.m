//
//  IntroductionViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "IntroductionViewController.h"

@interface IntroductionViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIImageView *car;

@property (weak, nonatomic) IBOutlet UIImageView *pageController;

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLaunched];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.x < 0.f) {
		scrollView.userInteractionEnabled = NO;
		return;
	}

	if (scrollView.contentOffset.x > scrollView.contentSize.width) {
		// 转到登陆画面
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

@end
