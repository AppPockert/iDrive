//
//  FliterCoordinateService.m
//  iDrive
//
//  Created by 钱宇杰 on 14/10/19.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "FliterCoordinateService.h"
#import "ItineraryHistory.h"

@implementation FliterCoordinateService

+ (NSArray *)fliterCoordinates:(NSArray *)gpsList {
    NSMutableArray *coords = [[NSMutableArray alloc] initWithCapacity:5];
    NSString *temp = @"(";
    for (NSString *gps in gpsList) {
        NSRange foundObj = [gps rangeOfString:temp options:NSCaseInsensitiveSearch];
        if (!foundObj.length > 0 || gps.length < 5) {
            NSArray *gpsSp = [gps componentsSeparatedByString:@","];
            if ([gpsSp[0] isEqualToString:@"2"]) {
                continue;
            }
            Coordinate *c = [[Coordinate alloc] init];
            c.lat = gpsSp[2];
            c.lng = gpsSp[1];
            [coords addObject:c];
        }
    }
    return coords;
}

@end
