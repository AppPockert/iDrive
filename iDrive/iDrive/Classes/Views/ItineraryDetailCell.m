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

	self.time.text = history.time;
	self.mileage.text = history.mileage;
	self.fuelConsumption.text = history.fuelConsumption;
}

@end
