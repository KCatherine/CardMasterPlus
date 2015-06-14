//
//  SecondViewController.m
//  Card Master Plus
//
//  Created by yj on 15/3/30.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITextView *eff;

@end

@implementation SecondViewController

-(void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功"
                                                                   message:@"现在可以搜索到了"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");}];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)add:(id)sender {
    [self showAlert];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.eff.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.eff.layer.borderWidth = 1.0;
    self.eff.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
