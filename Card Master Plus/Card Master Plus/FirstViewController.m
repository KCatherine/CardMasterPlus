//
//  FirstViewController.m
//  Card Master Plus
//
//  Created by yj on 15/3/30.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize cardName;
@synthesize ATK;
@synthesize DEF;
@synthesize Race;
@synthesize Pro;
@synthesize Kind;
@synthesize SNR;

@synthesize cardResults;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"toResults"]) {
        DBAccess *dbAccess = [[DBAccess alloc] init];
        self.cardResults = [dbAccess getCards:cardName.text];
        [dbAccess closeDatabase];
        [[segue destinationViewController] setcards:self.cardResults];
    }
    if([[segue identifier] isEqualToString:@"toLikes"]){
        DBAccess *dbAccess = [[DBAccess alloc] init];
        self.cardResults = [dbAccess getFavoriteCards];
        [dbAccess closeDatabase];
        [[segue destinationViewController] setcards:self.cardResults];
    }
}

@end
