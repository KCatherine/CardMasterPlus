//
//  TableViewController.h
//  Card Master Plus
//
//  Created by yj on 15/4/6.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInformation.h"
#import "DBAccess.h"

@interface TableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *cards;

-(void)setcards:(id)cardResults;

@end
