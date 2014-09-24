//
//  InquiryItineraryViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-8.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "InquiryItineraryViewController.h"

@interface InquiryItineraryViewController ()
{
	BOOL isShowDatePicker;
	int currDatePicker;
}

@property (weak, nonatomic) IBOutlet UIButton *startData;
@property (weak, nonatomic) IBOutlet UIButton *endData;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)actionChooseDatePicker:(UIButton *)b {
	currDatePicker = (int)b.tag;
	if (b.tag == 1) { //起始
		self.dataPicker.minimumDate = nil;
		self.dataPicker.maximumDate = [NSDate date];
	}
	else { //结束
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
		[UIView animateWithDuration:.5 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y - rect.size.height - 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (void)hideDatePicker {
	if (isShowDatePicker) {
		isShowDatePicker = NO;
		[UIView animateWithDuration:.5 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y + rect.size.height + 50;
		    self.datePickerView.frame = rect;
		}];
	}
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
   {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
