//
//  TrajectoryMapViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "TrajectoryMapViewController.h"
#import "BMapKit.h"

@interface TrajectoryMapViewController () <BMKMapViewDelegate>

@property (strong, nonatomic) BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation TrajectoryMapViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenHeight - kNavBarHeight)];
	_mapView.delegate = self;

	[self.backgroundView addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self.mapView viewWillAppear];
	self.mapView.delegate = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[self.mapView viewWillDisappear];
	self.mapView.delegate = nil;
}

#pragma mark - BMKMapViewDelegate

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay> )overlay {
	return nil;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation> )annotation {
	return nil;
}

@end
