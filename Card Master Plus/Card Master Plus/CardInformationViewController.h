//
//  CardInformationViewController.h
//  Card Master Plus
//
//  Created by yj on 15/3/31.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInformation.h"

@interface CardInformationViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) id detailCard;

@property (strong, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *kindLabel;
@property (strong, nonatomic) IBOutlet UILabel *propertyLabel;
@property (strong, nonatomic) IBOutlet UILabel *raceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sorLabel;
@property (strong, nonatomic) IBOutlet UILabel *atkLabel;
@property (strong, nonatomic) IBOutlet UILabel *defLabel;
@property (weak, nonatomic) IBOutlet UITextView *effectText;
@property (strong, nonatomic) IBOutlet UIImageView *pictureView;

@end
