//
//  CarBrandViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-7.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "CarBrandViewController.h"
#import "PlistFilePathManager.h"

#define FileName    @"CarBrand.plist"
#define Idintifier  @"CarBrandCell"

@interface CarBrandViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

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

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
	[self.bgView addGestureRecognizer:tap];

	self.identifer = kCarBrand;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Idintifier forIndexPath:indexPath];
	cell.textLabel.text = self.searchResults[indexPath.row];
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

#pragma mark - UITextFieldDelegate

- (void)textDidChange:(id)sender {
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

@end
