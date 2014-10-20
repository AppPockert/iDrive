//
//  AutoInsuranceAndMaintenanceViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-10-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "AutoInsuranceAndMaintenanceViewController.h"
#import "MaintenanceDetailViewController.h"
#import "SelectableViewController.h"
#import "GetMaintenanceInfoRequestParameter.h"
#import "SaveMaintenanceInfoRequestParameter.h"
#import "RequestService.h"
#import "NSStringUtil.h"

@interface MaintenanceDetailViewController ()

- (void)saveDidCompleted;

@property (nonatomic) UILabel *insuranceCompanyLabel; // 保险公司
@property (nonatomic) UILabel *autoInsuranceLabel;    // 车险类型
@property (nonatomic) UILabel *insuranceExpire;       // 保险到期日
@property (nonatomic) UILabel *maintenanceDueDate;    // 保养到期日
@property (nonatomic) UITextField *maintenanceMaMi;   // 保养到期里程

@property (nonatomic) BOOL hasEngineOil;      // 机油
@property (nonatomic) BOOL hasAirConditioner; // 空调

@end

@interface AutoInsuranceAndMaintenanceViewController () <SelectableViewControllerDelegate>
{
	BOOL isShowDatePicker;
	int currDatePicker;
}

@property (strong, nonatomic) MaintenanceDetailViewController *detail;

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@end

const int GetInfo = 1;
const int SaveInfo = 2;

@implementation AutoInsuranceAndMaintenanceViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    RequestService *service = [[RequestService alloc] init];
    service.tag = GetInfo;
    GetMaintenanceInfoRequestParameter *parameter = [[GetMaintenanceInfoRequestParameter alloc] init];
    [self sendRequestTo:service with:parameter];
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// 车辆信息详情
	if ([segue.identifier isEqualToString:kMaintenance]) {
		self.detail = segue.destinationViewController;
	}
	// 车辆品牌/保险公司
	else if ([segue.identifier isEqualToString:kInsuranceCompany]
	         || [segue.identifier isEqualToString:kAutoInsurance]) {
		SelectableViewController *controller = segue.destinationViewController;
		controller.delegate = self;
		controller.selectedItem = [[self lableForItem:segue.identifier] text];
	}
}

- (UILabel *)lableForItem:(NSString *)identifer {
	// 保险公司
	if ([identifer isEqualToString:kInsuranceCompany]) {
		return self.detail.insuranceCompanyLabel;
	}
	// 车险信息
	else {
		return self.detail.autoInsuranceLabel;
	}
}

#pragma mark - SelectableViewControllerDelegate

- (void)didSelectObject:(id)object with:(NSString *)identifer {
	[[self lableForItem:identifer] setText:object];
}

#pragma mark

- (IBAction)actionDone:(id)sender {
	if (currDatePicker == 1) {
		[self.detail.insuranceExpire setText:[self getTheDate]];
	}
	else {
		[self.detail.maintenanceDueDate setText:[self getTheDate]];
	}
	[self hideDatePicker];
}

- (NSString *)getTheDate {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	return [dateFormatter stringFromDate:self.dataPicker.date];
}

- (void)showDatePicker:(int)datePickerTag {
	currDatePicker = datePickerTag;

	self.dataPicker.minimumDate = [NSDate date];
	self.dataPicker.maximumDate = nil;

	if (!isShowDatePicker) {
		isShowDatePicker = YES;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y - 253;
		    self.datePickerView.frame = rect;
		}];
	}
}

- (void)hideDatePicker {
	if (isShowDatePicker) {
		isShowDatePicker = NO;
		[UIView animateWithDuration:.25 animations: ^{
		    CGRect rect = self.datePickerView.frame;
		    rect.origin.y = rect.origin.y + 253;
		    self.datePickerView.frame = rect;
		}];
	}
}

#pragma mark - 保存

- (void)save {
    RequestService *service = [[RequestService alloc] init];
    service.tag = SaveInfo;
    
    SaveMaintenanceInfoRequestParameter *parameter = [[SaveMaintenanceInfoRequestParameter alloc] init];
    parameter.insuranceType = [self valueOfLabel:self.detail.autoInsuranceLabel];
    parameter.insuranceCompany = [self valueOfLabel:self.detail.insuranceCompanyLabel];
    parameter.ciiInsurancetimeLeft = [self valueOfLabel:self.detail.insuranceExpire];
    parameter.ciiMaintaintimeLeft = [self valueOfLabel:self.detail.maintenanceDueDate];
    parameter.ciiMaintaindistanceLeft = [self valueOfField:self.detail.maintenanceMaMi];
    
    [self sendRequestTo:service with:parameter];
}

#pragma mark 

- (void)handleResult:(id)result of:(RequestService *)service {
    if (service.tag == GetInfo) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            // 保险公司
            if ([NSStringUtil isValidate:result[@"IcName"]]) {
                self.detail.insuranceCompanyLabel.text = result[@"IcName"];
            }
            
            // 保险类型
            if (result[@"CiiInsuranceType"] && [NSStringUtil isValidate:[NSString stringWithFormat:@"%@", result[@"CiiInsuranceType"]]]) {
                self.detail.autoInsuranceLabel.text = [NSString stringWithFormat:@"%@", result[@"CiiInsuranceType"]];
            }
            
            // 保险到期日
            if ([NSStringUtil isValidate:result[@"CiiInsurancetimeLeft"]]) {
                self.detail.insuranceExpire.text = result[@"CiiInsurancetimeLeft"];
            }
            // 保养到期日
            if ([NSStringUtil isValidate:result[@"CiiMaintaintimeLeft"]]) {
                self.detail.maintenanceDueDate.text = result[@"CiiMaintaintimeLeft"];
            }
            // 保养到期里程
            if (result[@"CiiMaintaindistanceLeft"] && [NSStringUtil isValidate:[NSString stringWithFormat:@"%@", result[@"CiiMaintaindistanceLeft"]]]) {
                self.detail.maintenanceMaMi.text = [NSString stringWithFormat:@"%@", result[@"CiiMaintaindistanceLeft"]];
            }
        } else {
            [self.view makeToast:@"获取数据失败"];
        }
    } else {
        if ([result isKindOfClass:[NSArray class]] && [result containsObject:@"success"]) {
            [self.detail saveDidCompleted];
            [self.view makeToast:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.view makeToast:@"保存失败"];
        }
        
    }
}

- (NSString *)valueOfLabel:(UILabel *)label {
    if (label.text) {
        return label.text;
    }
    else {
        return @"";
    }
}

- (NSString *)valueOfField:(UITextField *)field {
    if (field.text) {
        return field.text;
    }
    else {
        return @"";
    }
}

@end
