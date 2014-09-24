//
//  RoadRescueViewController.m
//  iDrive
//
//  Created by 钱宇杰 on 14-9-24.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import "RoadRescueViewController.h"

@interface RoadRescueViewController ()<UIScrollViewDelegate>
{
    int maxpages;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *lastPage;
@property (weak, nonatomic) IBOutlet UIButton *nextPage;

@property (nonatomic) int currPage;

@end

@implementation RoadRescueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    maxpages = 5;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat width = self.scrollView.frame.size.width;
    self.scrollView.contentSize = CGSizeMake(width*maxpages, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionNextPage:(id)sender
{
    if (self.currPage < 4) {
        CGFloat width = self.scrollView.frame.size.width;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+width, 0) animated:YES];
    }
}

- (IBAction)actionLastPage:(id)sender
{
    if (self.currPage > 0) {
        CGFloat width = self.scrollView.frame.size.width;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x-width, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.scrollView.frame.size.width;
    int page = scrollView.contentOffset.x/width;
    if (page != self.currPage) {
        self.lastPage.hidden = (page <= 0);
        self.nextPage.hidden = (page >= 4);
        self.currPage = page;
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
