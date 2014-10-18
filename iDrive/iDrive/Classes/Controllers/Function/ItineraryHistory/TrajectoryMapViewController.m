//
//  TrajectoryMapViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "TrajectoryMapViewController.h"
#import "BMapKit.h"
#import "BMKStartOrEndPointAnnotation.h"
#import "BMKStartOrEndPolyline.h"
#import "RequestService.h"
#import "RealTimeTrajectoryRequestParameter.h"

@interface TrajectoryMapViewController () <BMKMapViewDelegate>

@property (strong, nonatomic) BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeed;
@property (weak, nonatomic) IBOutlet UILabel *avgOilCost;

@end

@implementation TrajectoryMapViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenHeight - kNavBarHeight - KTabBarHeight)];
	_mapView.delegate = self;
	_mapView.showMapScaleBar = YES;
	_mapView.zoomLevel = 15.f;

	[self.backgroundView addSubview:_mapView];

	if (self.trajectoryType == TrajectoryTypeHistory) {
		self.titleLabel.text = @"行程管理";
		[self setLineInfo];
	}
	else {
		// 请求实时轨迹点
		[self inqueryRealTimeTrajectory];
	}
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

	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(inqueryRealTimeTrajectory) object:nil];
}

#pragma mark

// 设置轨迹
- (void)setLineInfo {
	self.avgSpeed.text = [NSString stringWithFormat:@"%@km/h", self.history.avgSpeed];
	self.avgOilCost.text = [NSString stringWithFormat:@"%@L/km", self.history.avgOilCost];
	[self createLine:self.history.coordinates];
}

// 生成百度地图的轨迹的线
- (void)createLine:(NSArray *)points {
	//轨迹点
	CLLocationCoordinate2D *temppoints = malloc(sizeof(CLLocationCoordinate2D) * points.count);

	for (int i = 0; i < points.count; i++) {
		Coordinate *coord = points[i];
		temppoints[i] = [coord toCoordinate];
	}
	// 通过points构建BMKPolyline
	BMKStartOrEndPolyline *polyLine = (BMKStartOrEndPolyline *)[BMKStartOrEndPolyline polylineWithCoordinates:temppoints count:points.count];
	// 添加路线overlay
	[_mapView addOverlay:polyLine];
	[_mapView setCenterCoordinate:temppoints[0]];
}

// 请求实时轨迹信息
- (void)inqueryRealTimeTrajectory {
	RealTimeTrajectoryRequestParameter *parameter = [[RealTimeTrajectoryRequestParameter alloc] init];
//	parameter.equipmentSNnum = @"6334128330095";
	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
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
		startAnnotation.title = self.history.startTime;
		[mapView addAnnotation:startAnnotation];
//		[self addAnnotation:startAnnotation with:line];

		// 终点
		BMKStartOrEndPointAnnotation *endAnnotation = [[BMKStartOrEndPointAnnotation alloc]init];
		endAnnotation.coordinate = BMKCoordinateForMapPoint(endPoint);
		endAnnotation.type = PointTypeEnd;
		endAnnotation.title = self.history.endTime;
		[mapView addAnnotation:endAnnotation];
//		[self addAnnotation:endAnnotation with:line];
	}
	BMKPolylineView *path = [[BMKPolylineView alloc] initWithOverlay:overlay];
	path.lineWidth = 8.f;
	path.fillColor = [UIColor greenColor];
	path.strokeColor = [UIColor greenColor];
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

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
	[mapView setCenterCoordinate:[[view annotation] coordinate]];
}

#pragma mark -

//- (void)addAnnotation:(BMKPointAnnotation *)annotation with:(BMKStartOrEndPolyline *)line {
//	CLLocation *location = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
//	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//	[geocoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks, NSError *error) {
//	    CLPlacemark *place = placemarks[0];
//	    if (place.administrativeArea && place.locality && place && place.subLocality && place.thoroughfare) {
//	        // 获取地理信息
//		}
//	    else {
//	        // 获取地理信息失败
//		}
//	}];
//	[self.mapView addAnnotation:annotation];
//}

#pragma mark -

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSDictionary class]] && [[result allKeys] count] > 2) {
		_history = [[ItineraryHistory alloc] init];
		_history.avgOilCost = result[@"AvlOilConsumption"];
		_history.avgSpeed = result[@"AvlSpeed"];
		_history.fuelConsumption = result[@"CurrentOilConsumption"];
		_history.mileage = result[@"Mileage"];
		_history.startTime = result[@"startTime"];
		_history.endTime = result[@"endTime"];
		_history.coordinates = [self getCoordinates:result[@"gpsList"]];

		[self setLineInfo];

		[self performSelector:@selector(inqueryRealTimeTrajectory) withObject:nil afterDelay:120];
	}
	else {
		[self.view makeToast:@"获取实时轨迹失败,请稍后重试"];
	}
}

- (NSArray *)getCoordinates:(NSArray *)gpsList {
	NSMutableArray *coords = [[NSMutableArray alloc] initWithCapacity:5];
	NSString *temp = @"(";
	for (NSString *gps in gpsList) {
		NSRange foundObj = [gps rangeOfString:temp options:NSCaseInsensitiveSearch];
		if (!foundObj.length > 0 || gps.length < 5) {
			NSArray *gpsSp = [gps componentsSeparatedByString:@","];
			Coordinate *c = [[Coordinate alloc] init];
			c.lat = gpsSp[2];
			c.lng = gpsSp[1];
			[coords addObject:c];
		}
	}
	return coords;
}

@end
