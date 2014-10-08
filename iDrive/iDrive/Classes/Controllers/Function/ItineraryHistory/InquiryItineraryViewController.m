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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	_historyList = [[NSMutableArray alloc] initWithCapacity:5];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)actionChooseDatePicker:(UIButton *)b {
	currDatePicker = (int)b.tag;
	if (b.tag == 1) { // 起始时间
		self.dataPicker.minimumDate = nil;
		self.dataPicker.maximumDate = [NSDate date];
	}
	else { // 结束时间
		if ([self.startData.titleLabel.text isEqualToString:@"选择日期"]) {
			[self.view makeToast:@"请先选择开始日期"];
			return;
		}
		else {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			dateFormatter.dateFormat = @"yyyy-MM-dd";
			self.dataPicker.minimumDate = [dateFormatter dateFromString:self.startData.titleLabel.text];
			self.dataPicker.maximumDate = [self.dataPicker.minimumDate dateByAddingTimeInterval:60 * 60 * 24 * 30];
		}
	}
	[self showDatePicker];
}

- (IBAction)actionDone:(id)sender {
	if (currDatePicker == 1) {
		[self.startData setTitle:[self getTheDate] forState:UIControlStateNormal];
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
	parameter.equipmentSNnum = @"6334128330095";
	[self sendRequestTo:[[RequestService alloc] init] with:parameter];
}

- (void)handleResult:(id)result of:(RequestService *)service {
	NSLog(@"%@", result);
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kHistoryList]) {
		ItineraryHistoryViewController *history = segue.destinationViewController;
		history.dataSource = self.historyList;
	}
}

@end
