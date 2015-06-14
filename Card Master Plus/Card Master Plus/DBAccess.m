//
//  DBAccess.m
//  Card Master Plus
//
//  Created by yj on 15/4/4.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "DBAccess.h"

@implementation DBAccess

sqlite3 *database;

-(id)init
{
    if((self = [super init]))
    {
        //set reference to databse
        [self initializeDatabase];
    }
    return self;
}
-(void)initializeDatabase
{
    //Get database from app bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GameCards"
                                                     ofType:@"db"];
    //Open database
    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        NSLog(@"Opening Database");
    }
    else
    {
        //Call close to properly clean up
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database: '%s'.", sqlite3_errmsg(database));
    }
}
-(void)closeDatabase
{
    if(sqlite3_close(database) != SQLITE_OK)
    {
        NSAssert1(0, @"Error: failed to close database: '%s'.", sqlite3_errmsg(database));
    }
}
-(NSMutableArray *)getAllCards
{
    //array of cards that we will create
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    const char *sql = "SELECT Monster.ID,Monster.CARDNAME,\
    Monster.ATK,Monster.DEF,Kind.KIND,Monster.RACE,\
    Pro.PRO,Monster.SNR,Monster.EFF,Monster.PIC FROM Monster,Kind,Pro \
    WHERE Monster.KINDID=Kind.ID AND Monster.PROID=Pro.ID";
    sqlite3_stmt *statement;
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    if(sqlResult == SQLITE_OK)
    {
        //step through the results
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //allocate a card object to add to cards array
            CardInformation *card = [[CardInformation alloc] init];
            //second parameter is the column index (0 based)
            char *ID = (char *)sqlite3_column_text(statement, 0);
            char *cardname = (char *)sqlite3_column_text(statement, 1);
            char *attack = (char *)sqlite3_column_text(statement, 2);
            char *defense = (char *)sqlite3_column_text(statement, 3);
            char *kind = (char *)sqlite3_column_text(statement, 4);
            char *race = (char *)sqlite3_column_text(statement, 5);
            char *property = (char *)sqlite3_column_text(statement, 6);
            char *starORrank = (char *)sqlite3_column_text(statement, 7);
            char *effect = (char *)sqlite3_column_text(statement, 8);
            //set all sttributes of the card
            card.ID = (ID) ? [NSString stringWithUTF8String:ID] : @"";
            card.cardname = (cardname) ? [NSString stringWithUTF8String:cardname] : @"";
            card.attack = (attack) ? [NSString stringWithUTF8String:attack] : @"";
            card.defense = (defense) ? [NSString stringWithUTF8String:defense] : @"";
            card.kind = (kind) ? [NSString stringWithUTF8String:kind] : @"";
            card.race = (race) ? [NSString stringWithUTF8String:race] : @"";
            card.property = (property) ? [NSString stringWithUTF8String:property] : @"";
            card.starORrank = (starORrank) ? [NSString stringWithUTF8String:starORrank] : @"";
            card.effect = (effect) ? [NSString stringWithUTF8String:effect] : @"";
            //add card to cards array
            [cards addObject:card];
        }
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    return cards;
}

-(NSMutableArray *)getCards:(NSString *)text
{
    //array of cards that we will create
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    NSString *Ssql = [NSString stringWithFormat:
                      @"SELECT Monster.ID,Monster.CARDNAME,\
                      Monster.ATK,Monster.DEF,Kind.KIND,Monster.RACE,\
                      Pro.PRO,Monster.SNR,Monster.EFF FROM Monster,Kind,Pro \
                      WHERE Monster.KINDID=Kind.ID AND Monster.PROID=Pro.ID AND Monster.CARDNAME like '%%%@%%'\
                      ",text];
    sqlite3_stmt *statement;
    const char *S_stmt = [Ssql UTF8String];
    int sqlResult = sqlite3_prepare_v2(database, S_stmt, -1, &statement, NULL);
    if(sqlResult == SQLITE_OK)
    {
        //step through the results
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //allocate a card object to add to cards array
            CardInformation *card = [[CardInformation alloc] init];
            //second parameter is the column index (0 based)
            char *ID = (char *)sqlite3_column_text(statement, 0);
            char *cardname = (char *)sqlite3_column_text(statement, 1);
            char *attack = (char *)sqlite3_column_text(statement, 2);
            char *defense = (char *)sqlite3_column_text(statement, 3);
            char *kind = (char *)sqlite3_column_text(statement, 4);
            char *race = (char *)sqlite3_column_text(statement, 5);
            char *property = (char *)sqlite3_column_text(statement, 6);
            char *starORrank = (char *)sqlite3_column_text(statement, 7);
            char *effect = (char *)sqlite3_column_text(statement, 8);
            //set all sttributes of the card
            card.ID = (ID) ? [NSString stringWithUTF8String:ID] : @"";
            card.cardname = (cardname) ? [NSString stringWithUTF8String:cardname] : @"";
            card.attack = (attack) ? [NSString stringWithUTF8String:attack] : @"";
            card.defense = (defense) ? [NSString stringWithUTF8String:defense] : @"";
            card.kind = (kind) ? [NSString stringWithUTF8String:kind] : @"";
            card.race = (race) ? [NSString stringWithUTF8String:race] : @"";
            card.property = (property) ? [NSString stringWithUTF8String:property] : @"";
            card.starORrank = (starORrank) ? [NSString stringWithUTF8String:starORrank] : @"";
            card.effect = (effect) ? [NSString stringWithUTF8String:effect] : @"";
            //add card to cards array
            [cards addObject:card];
        }
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    return cards;
}

-(NSMutableArray *)getFavoriteCards
{
    //array of cards that we will create
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    NSString *SLsql = [NSString stringWithFormat:
                      @"SELECT Favorites.ID,Favorites.CARDNAME,\
                      Favorites.ATK,Favorites.DEF,Favorites.KIND,Favorites.RACE,\
                      Favorites.PRO,Favorites.SNR,Favorites.EFF FROM Favorites"];
    sqlite3_stmt *statement;
    const char *S_stmt = [SLsql UTF8String];
    int sqlResult = sqlite3_prepare_v2(database, S_stmt, -1, &statement, NULL);
    if(sqlResult == SQLITE_OK)
    {
        //step through the results
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //allocate a card object to add to cards array
            CardInformation *card = [[CardInformation alloc] init];
            //second parameter is the column index (0 based)
            char *ID = (char *)sqlite3_column_text(statement, 0);
            char *cardname = (char *)sqlite3_column_text(statement, 1);
            char *attack = (char *)sqlite3_column_text(statement, 2);
            char *defense = (char *)sqlite3_column_text(statement, 3);
            char *kind = (char *)sqlite3_column_text(statement, 4);
            char *race = (char *)sqlite3_column_text(statement, 5);
            char *property = (char *)sqlite3_column_text(statement, 6);
            char *starORrank = (char *)sqlite3_column_text(statement, 7);
            char *effect = (char *)sqlite3_column_text(statement, 8);
            //set all sttributes of the card
            card.ID = (ID) ? [NSString stringWithUTF8String:ID] : @"";
            card.cardname = (cardname) ? [NSString stringWithUTF8String:cardname] : @"";
            card.attack = (attack) ? [NSString stringWithUTF8String:attack] : @"";
            card.defense = (defense) ? [NSString stringWithUTF8String:defense] : @"";
            card.kind = (kind) ? [NSString stringWithUTF8String:kind] : @"";
            card.race = (race) ? [NSString stringWithUTF8String:race] : @"";
            card.property = (property) ? [NSString stringWithUTF8String:property] : @"";
            card.starORrank = (starORrank) ? [NSString stringWithUTF8String:starORrank] : @"";
            card.effect = (effect) ? [NSString stringWithUTF8String:effect] : @"";
            //add card to cards array
            [cards addObject:card];
        }
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    return cards;
}

-(void) addFavoriteCards:(CardInformation *)thisCard
{
    NSString *addFCsql = [NSString stringWithFormat:
                          @"INSERT INTO Favorites (ID,CARDNAME,ATK,DEF,KIND,RACE,PRO,SNR,EFF)\
                          VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@')",thisCard.ID,thisCard.cardname,thisCard.attack,thisCard.defense,thisCard.kind,thisCard.race,thisCard.property,thisCard.starORrank,thisCard.effect];
    char *errmsg = nil;
    if(sqlite3_exec(database, [addFCsql UTF8String], NULL, NULL, &errmsg) == SQLITE_OK)
        NSLog(@"OK");
    else
        NSLog(@"Fail");
}

@end
