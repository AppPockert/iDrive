//
//  ItineraryHistory.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-20.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ItineraryHistory.h"

@implementation ItineraryHistory

@end

@implementation Coordinate

- (CLLocationCoordinate2D)toCoordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = [self.lat doubleValue];
	coordinate.longitude = [self.lng doubleValue];
	return coordinate;
}

@end
