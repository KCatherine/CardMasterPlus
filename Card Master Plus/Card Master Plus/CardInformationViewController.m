//
//  CardInformationViewController.m
//  Card Master Plus
//
//  Created by yj on 15/3/31.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "CardInformationViewController.h"
#import "CardInformation.h"
#import "DBAccess.h"

@interface CardInformationViewController ()

-(void)configureView;
-(void)showAlert;

@end

@implementation CardInformationViewController

@synthesize detailCard;
@synthesize IDLabel;
@synthesize nameLabel;
@synthesize kindLabel;
@synthesize propertyLabel;
@synthesize raceLabel;
@synthesize sorLabel;
@synthesize atkLabel;
@synthesize defLabel;
@synthesize effectText;

-(void)configureView
{
    //Update UI for detail item
    if(self.detailCard)
    {
        CardInformation *theCard = (CardInformation *) self.detailCard;
        //set the text of the labels to the values passed in the CardInformation object
        [self.IDLabel setText:theCard.ID];
        [self.nameLabel setText:theCard.cardname];
        [self.kindLabel setText:theCard.kind];
        [self.propertyLabel setText:theCard.property];
        [self.raceLabel setText:theCard.race];
        [self.sorLabel setText:theCard.starORrank];
        [self.atkLabel setText:theCard.attack];
        [self.defLabel setText:theCard.defense];
        [self.effectText setText:theCard.effect];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:theCard.ID
                                                             ofType:@"jpg"
                                                        inDirectory:@"pic"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        self.pictureView.image = image;
    }
}

-(void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功"
                                                message:@"可以在收藏页中查看"
                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                            NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");}];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)setDetailCard:(id)newDetailCard
{
    if(detailCard != newDetailCard)
    {
        detailCard = newDetailCard;
        [self configureView];
    }
}

- (IBAction)collectCard:(id)sender {
    DBAccess *dbAccess = [[DBAccess alloc] init];
    [dbAccess addFavoriteCards:(CardInformation *)self.detailCard];
    [self showAlert];
    [dbAccess closeDatabase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
