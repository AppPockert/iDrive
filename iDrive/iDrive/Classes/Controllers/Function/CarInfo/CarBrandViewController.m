//
//  CarBrandViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarBrandViewController.h"
#import "PlistFilePathManager.h"
#import "CarBrandsTableViewCell.h"

#define FileName    @"CarBrand.plist"
#define Idintifier  @"CarBrandCell"

@interface CarBrandViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *searchField; // 搜索输入框
@property (weak, nonatomic) IBOutlet UITableView *searchResultTable; // 检索结果列表

@property (strong, nonatomic) NSArray *allCarBrands; // 所有的类型
@property (strong, nonatomic) NSMutableArray *searchResults; // 搜索的结果

@end

@implementation CarBrandViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *path = [PlistFilePathManager getFullPath:FileName options:FilePathOptionTypeUserDocument | FilePathOptionTypeCopyFromBundle];

	_allCarBrands = [NSArray arrayWithContentsOfFile:path];
	_searchResults = [[NSMutableArray alloc] initWithCapacity:5];

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
	[self.bgView addGestureRecognizer:tap];

	self.identifer = kCarBrand;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CarBrandsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Idintifier forIndexPath:indexPath];
	cell.carBrandName.text = self.searchResults[indexPath.row];
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectObject:with:)]) {
		[self.delegate didSelectObject:self.searchResults[indexPath.row] with:self.identifer];

		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self doSearch:nil];
	return YES;
}

- (IBAction)doSearch:(id)sender {
	[self.view endEditing:YES];
	if (self.searchField.text && ![self.searchField.text isEqualToString:@""]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", self.searchField.text];
		_searchResults = [NSMutableArray arrayWithArray:[_allCarBrands filteredArrayUsingPredicate:predicate]];
	}
	else {
		[self.searchResults removeAllObjects];
	}

	self.searchResultTable.hidden = ([self.searchResults count] == 0);
	[self.searchResultTable reloadData];
}

#pragma mark -

- (void)dismiss:(id)sender {
	[self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.view endEditing:YES];
}

@end
