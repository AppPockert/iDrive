//
//  DetailViewController.h
//  iDrive
//
//  Created by 钱宇杰 on 14-8-29.
//  Copyright (c) 2014年 autointelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
