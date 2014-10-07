//
//  InsuranceCompanyViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "InsuranceCompanyViewController.h"
#import "InsuranceCompanyCell.h"
#import "PlistFilePathManager.h"

#define FileName     @"InsuranceCompany.plist"

@interface InsuranceCompanyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation InsuranceCompanyViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];

	_dataSource = [NSArray arrayWithContentsOfFile:path];

	self.identifer = kInsuranceCompany;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	InsuranceCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:kInsuranceCompany forIndexPath:indexPath];

	cell.companyInfo = self.dataSource[indexPath.row];
	cell.isCurrentCompany = [self.selectedItem isEqualToString:cell.companyInfo[@"name"]];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectObject:with:)]) {
		NSDictionary *dict = self.dataSource[indexPath.row];
		[self.delegate didSelectObject:dict[@"name"] with:self.identifer];

		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
