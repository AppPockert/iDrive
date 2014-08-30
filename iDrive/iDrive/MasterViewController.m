//
//  MasterViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-8-29.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
	NSMutableArray *_objects;
}

@property (strong, nonatomic)IBOutletCollection(UIView) NSArray * tabs;

@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (IBAction)click:(id)sender {
	UIButton *btn = (UIButton *)sender;

	[self.view bringSubviewToFront:self.tabs[btn.tag]];
}

@end
