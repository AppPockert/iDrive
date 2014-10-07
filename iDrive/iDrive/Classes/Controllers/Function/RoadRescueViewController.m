//
//  RoadRescueViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-24.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RoadRescueViewController.h"
#import "PlistFilePathManager.h"
#import "InsuranceCompanyCell.h"

#define FileName     @"InsuranceCompany.plist"

@interface RoadRescueViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
	int maxpages;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *lastPage;
@property (weak, nonatomic) IBOutlet UIButton *nextPage;

@property (assign, nonatomic) int currPage;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation RoadRescueViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	maxpages = 5;

	NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];

	_dataSource = [NSArray arrayWithContentsOfFile:path];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	CGFloat width = self.scrollView.frame.size.width;
	self.scrollView.contentSize = CGSizeMake(width * maxpages, 0);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)actionNextPage:(id)sender {
	if (self.currPage < 4) {
		CGFloat width = self.scrollView.frame.size.width;
		[self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + width, 0) animated:YES];
	}
}

- (IBAction)actionLastPage:(id)sender {
	if (self.currPage > 0) {
		CGFloat width = self.scrollView.frame.size.width;
		[self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - width, 0) animated:YES];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat width = self.scrollView.frame.size.width;
	int page = scrollView.contentOffset.x / width;
	if (page != self.currPage) {
		self.lastPage.hidden = (page <= 0);
		self.nextPage.hidden = (page >= 4);
		self.currPage = page;
	}
}

- (void)call:(int)phoneNum {
	NSString *telUrl = [NSString stringWithFormat:@"tel://%i", phoneNum];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];

	NSLog(@"%@", telUrl);
}

- (IBAction)call110:(id)sender {
	[self call:110];
}

- (IBAction)call120:(id)sender {
	[self call:120];
}

#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	InsuranceCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:kInsuranceCompany forIndexPath:indexPath];

	cell.companyInfo = self.dataSource[indexPath.row];

	return cell;
}

@end
