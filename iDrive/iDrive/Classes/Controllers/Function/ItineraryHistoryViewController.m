//
//  ItineraryHistoryViewController.m
//  CarMaster
//
//  Created by 钱宇杰 on 14-8-23.
//  Copyright (c) 2014年 钱宇杰. All rights reserved.
//

#import "ItineraryHistoryViewController.h"
#import "BMapKit.h"
#import "BMKStartOrEndPointAnnotation.h"
#import "BMKStartOrEndPolyline.h"

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

#pragma mark - BMKMapViewDelegate

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay> )overlay {
	if ([overlay isKindOfClass:[BMKStartOrEndPolyline class]]) {
		BMKStartOrEndPolyline *line = (BMKStartOrEndPolyline *)overlay;

		BMKMapPoint *points = [line points];
		BMKMapPoint startPoint = points[0];
		BMKMapPoint endPoint = points[line.pointCount - 1];

		// 起始点
		BMKStartOrEndPointAnnotation *startAnnotation = [[BMKStartOrEndPointAnnotation alloc]init];
		startAnnotation.coordinate = BMKCoordinateForMapPoint(startPoint);
		startAnnotation.type = PointTypeStart;
		[self addAnnotation:startAnnotation with:line];

		// 终点
		BMKStartOrEndPointAnnotation *endAnnotation = [[BMKStartOrEndPointAnnotation alloc]init];
		endAnnotation.coordinate = BMKCoordinateForMapPoint(endPoint);
		endAnnotation.type = PointTypeEnd;
		[self addAnnotation:endAnnotation with:line];
	}
	BMKOverlayPathView *path = [[BMKOverlayPathView alloc] initWithOverlay:overlay];
	return path;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation> )annotation {
	static NSString *annotationIdentifier = @"Annotation";
	if ([annotation isKindOfClass:[BMKStartOrEndPointAnnotation class]]) {
		BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];

		if (!annotationView) {
			annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
		}

		annotationView.pinColor = BMKPinAnnotationColorPurple;
		return annotationView;
	}
	return nil;
}

#pragma mark -

- (void)addAnnotation:(BMKPointAnnotation *)annotation with:(BMKStartOrEndPolyline *)line {
	CLLocation *location = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
	[geocoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks, NSError *error) {
	    CLPlacemark *place = placemarks[0];
	    if (place.administrativeArea && place.locality && place && place.subLocality && place.thoroughfare) {
	        // 获取地理信息
		}
	    else {
	        // 获取地理信息失败
		}
	}];
	[self.mapView addAnnotation:annotation];
}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
}

@end
