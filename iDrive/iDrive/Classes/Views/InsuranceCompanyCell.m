//
//  InsuranceCompanyCell.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "InsuranceCompanyCell.h"

@interface InsuranceCompanyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *singleSelect;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;

@end

@implementation InsuranceCompanyCell

- (void)setCompanyInfo:(NSDictionary *)companyInfo {
	_companyInfo = companyInfo;

	self.companyName.text = companyInfo[@"name"];
	self.phoneNum.text = companyInfo[@"phone"];
}

- (void)setIsCurrentCompany:(BOOL)isCurrentCompany {
	_isCurrentCompany = isCurrentCompany;

	UIImage *image;
	if (isCurrentCompany) {
		image = [UIImage imageNamed:@"单选一"];
	}
	else {
		image = [UIImage imageNamed:@"单选二"];
	}
	self.singleSelect.image = image;
}

- (IBAction)call:(id)sender {
	NSString *telUrl = [NSString stringWithFormat:@"tel://%@", _companyInfo[@"phone"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];

	NSLog(@"%@", telUrl);
}

@end
