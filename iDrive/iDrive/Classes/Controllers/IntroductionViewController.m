//
//  IntroductionViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-6.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "IntroductionViewController.h"

#define Infos  @[@"    详尽的地图令您随时掌握周围\n路况信息，行车路线一目了然", @"    无论您身在何处，开车与否，\n车辆异动情况尽在您掌握之中", @"    车险及保养一直为您提供及\n时、省时、方便的商家信息"]
#define pages  @[@"欢迎页小按钮一", @"欢迎页小按钮二", @"欢迎页小按钮三"]

@interface IntroductionViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *page1;
@property (weak, nonatomic) IBOutlet UIImageView *page2;
@property (weak, nonatomic) IBOutlet UIImageView *page3;

@property (weak, nonatomic) IBOutlet UILabel *info;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLaunched];
	[[NSUserDefaults standardUserDefaults] synchronize];

	self.info.text = Infos[0];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	CGFloat width = self.scrollView.frame.size.width;
	self.scrollView.contentSize = CGSizeMake(width * pages.count, 0);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.x == 640.f) {
		[self performSegueWithIdentifier:kLogin sender:nil];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	int index = scrollView.contentOffset.x / 320;

	if (index > 2) {
		return;
	}

	self.info.text = Infos[index];
    
//    self.page1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[index], (index + 3) / 2]];

	if (index == 0) {
		self.page1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[0], 1]];
		self.page2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[1], 2]];
		self.page3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[2], 2]];
	}
	else if (index == 1) {
		self.page1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[0], 2]];
		self.page2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[1], 1]];
		self.page3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[2], 2]];
	}
	else {
		self.page1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[0], 2]];
		self.page2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[1], 2]];
		self.page3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%i", pages[2], 1]];
	}
}

@end
