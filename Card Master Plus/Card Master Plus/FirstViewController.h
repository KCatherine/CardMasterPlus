//
//  FirstViewController.h
//  Card Master Plus
//
//  Created by yj on 15/3/30.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "CardInformation.h"
#import "DBAccess.h"

@interface FirstViewController : UIViewController

{
    sqlite3 *GameCards;
    NSString *databasePath;
}

@property (strong, nonatomic) NSMutableArray *cardResults;

@property (strong, nonatomic) IBOutlet UITextField *cardName;
@property (strong, nonatomic) IBOutlet UITextField *ATK;
@property (strong, nonatomic) IBOutlet UITextField *DEF;
@property (strong, nonatomic) IBOutlet UITextField *Race;
@property (strong, nonatomic) IBOutlet UITextField *Pro;
@property (strong, nonatomic) IBOutlet UITextField *Kind;
@property (strong, nonatomic) IBOutlet UITextField *SNR;

@end

