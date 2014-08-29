//
//  ItineraryHistoryViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "ItineraryHistoryViewController.h"
#import "BMapKit.h"

@interface ItineraryHistoryViewController () <BMKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) BMKMapView *mapView;

@end

@implementation ItineraryHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	_mapView = [[BMKMapView alloc] initWithFrame:self.backgroundView.bounds];
	_mapView.delegate = self;
	[self.backgroundView addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self.mapView viewWillAppear];
	self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[self.mapView viewWillDisappear];
	self.mapView.delegate = nil;
}

#pragma mark - BMKMapViewDelegatee

@end
