//
//  ItineraryDetailCell.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "ItineraryDetailCell.h"
#import "ItineraryHistory.h"

@interface ItineraryDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *time; // 时长
@property (weak, nonatomic) IBOutlet UILabel *mileage; // 里程
@property (weak, nonatomic) IBOutlet UILabel *fuelConsumption; // 油耗

@end

@implementation ItineraryDetailCell

- (void)setHistory:(ItineraryHistory *)history {
	_history = history;

	self.time.text = [self formateTimeWithStart:history.startTime end:history.endTime];
	self.mileage.text = [NSString stringWithFormat:@"%@KM", history.mileage];
	self.fuelConsumption.text = [NSString stringWithFormat:@"%@L", history.fuelConsumption];
}

- (NSString *)formateTimeWithStart:(NSString *)startTime end:(NSString *)endTime {
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setTimeZone:[NSTimeZone systemTimeZone]];
	[dateformatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
	[dateformatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	[dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

	NSDate *start = [dateformatter dateFromString:startTime];
	NSDate *end = [dateformatter dateFromString:endTime];

	long interval = [end timeIntervalSinceDate:start];
	return [NSString stringWithFormat:@"%lih%lim", interval / 3600, (interval % 3600) / 60];
}

@end
