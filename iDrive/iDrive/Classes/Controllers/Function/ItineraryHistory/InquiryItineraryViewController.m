//
//  InquiryItineraryViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "InquiryItineraryViewController.h"
#import "ItineraryHistoryRequestParameter.h"
#import "RequestService.h"
#import "ItineraryHistoryViewController.h"
#import "RealTimeTrajectoryRequestParameter.h"
#import "ItineraryHistory.h"
#import "FliterCoordinateService.h"

const int Start = 1;
const int End = 2;

@interface InquiryItineraryViewController ()
{
	BOOL isShowDatePicker;
	int currDatePicker;
}

@property (weak, nonatomic) IBOutlet UIButton *startData;
@property (weak, nonatomic) IBOutlet UIButton *endData;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (strong, nonatomic) NSMutableArray *historyList;

@end

@implementation InquiryItineraryViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_historyList = [[NSMutableArray alloc] initWithCapacity:5];

	// 设置初始值
	[self.startData setTitle:[self getTheDate] forState:UIControlStateNormal];
	[self.endData setTitle:[self getTheDate] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.historyList removeAllObjects];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)actionChooseDatePicker:(UIButton *)b {
	currDatePicker = (int)b.tag;
	// 起始时间
	if (b.tag == Start) {
		self.dataPicker.minimumDate = nil;
		self.dataPicker.maximumDate = [NSDate date];
	}
	// 结束时间
	else {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"yyyy-MM-dd";
		self.dataPicker.minimumDate = [dateFormatter dateFromString:self.startData.titleLabel.text];
		NSDate *oneMouthLater = [self.dataPicker.minimumDate dateByAddingTimeInterval:2592000];
		self.dataPicker.maximumDate = [oneMouthLater earlierDate:[NSDate date]];
	}
	[self showDatePicker];
}

- (IBAction)actionDone:(id)sender {
	if (currDatePicker == Start) {
		[self.startData setTitle:[self getTheDate] forState:UIControlStateNormal];

		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"yyyy-MM-dd";
		NSDate *startDate = [dateFormatter dateFromString:self.startData.titleLabel.text];
		NSDate *endDate = [dateFormatter dateFromString:self.endData.titleLabel.text];

        // 结束时间超过1个月以上
		if ([endDate timeIntervalSinceDate:startDate] > 2592000) {
			endDate = [startDate dateByAddingTimeInterval:2592000];
			[self.endData setTitle:[dateFormatter stringFromDate:endDate] forState:UIControlStateNormal];
		}
        // 结束时间比开始时间早
		else if ([endDate timeIntervalSinceDate:startDate] < 0) {
			[self.endData setTitle:self.startData.titleLabel.text forState:UIControlStateNormal];
		}
	}
	else {
		[self.endData setTitle:[self getTheDate] forState:UIControlStateNormal];
	}
	[self hideDatePicker];
}

- (NSString *)getTheDate {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	return [dateFormatter stringFromDate:self.dataPicker.date];
}

- (void)showDatePicker {
	if (!isShowDatePicker) {
		isShowDatePicker = YES;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y - rect.size.height - 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (void)hideDatePicker {
	if (isShowDatePicker) {
		isShowDatePicker = NO;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y + rect.size.height + 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (IBAction)search:(id)sender {
	ItineraryHistoryRequestParameter *parameter = [[ItineraryHistoryRequestParameter alloc] init];
	parameter.startTime = self.startData.titleLabel.text;
	parameter.endTime = self.endData.titleLabel.text;
	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	if ([result isKindOfClass:[NSArray class]] && ![result containsObject:@"error"]) {
        if ([result containsObject:@"no message"]) {
            [self.view makeToast:@"未查询到相关历程数据"];
            return;
        }
        
        for (NSDictionary *record in result) {
            ItineraryHistory *_history = [[ItineraryHistory alloc] init];
            _history.avgOilCost = record[@"AvlOilConsumption"];
            _history.avgSpeed = record[@"AvlSpeed"];
            _history.fuelConsumption = record[@"CurrentOilConsumption"];
            _history.mileage = record[@"Mileage"];
            _history.startTime = record[@"startTime"];
            _history.endTime = record[@"endTime"];
            _history.coordinates = [FliterCoordinateService fliterCoordinates:record[@"gpsList"]];
            
            [self.historyList addObject:_history];
        }
		
		[self performSegueWithIdentifier:kHistoryList sender:nil];
	}
	else {
		[self.view makeToast:@"查询失败,请稍后重试"];
	}
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kHistoryList]) {
		ItineraryHistoryViewController *history = segue.destinationViewController;
		history.dataSource = self.historyList;
	}
}

@end
