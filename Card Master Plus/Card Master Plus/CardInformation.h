//
//  CardInformation.h
//  Card Master Plus
//
//  Created by yj on 15/4/4.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInformation : NSObject

{
    NSString *ID;
    NSString *cardname;
    NSString *attack;
    NSString *defense;
    NSString *kind;
    NSString *race;
    NSString *property;
    NSString *starORrank;
    NSString *effect;
    
}

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *cardname;
@property (strong, nonatomic) NSString *attack;
@property (strong, nonatomic) NSString *defense;
@property (strong, nonatomic) NSString *kind;
@property (strong, nonatomic) NSString *race;
@property (strong, nonatomic) NSString *property;
@property (strong, nonatomic) NSString *starORrank;
@property (strong, nonatomic) NSString *effect;

@end
