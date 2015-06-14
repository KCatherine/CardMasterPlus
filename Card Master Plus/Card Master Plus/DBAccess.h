//
//  DBAccess.h
//  Card Master Plus
//
//  Created by yj on 15/4/4.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CardInformation.h"

@interface DBAccess : NSObject

-(NSMutableArray *) getAllCards;
-(NSMutableArray *) getCards:(NSString *)text;
-(NSMutableArray *) getFavoriteCards;
-(void) addFavoriteCards:(CardInformation *)thisCard;
-(void) closeDatabase;
-(void) initializeDatabase;

@end
