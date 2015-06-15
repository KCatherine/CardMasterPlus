//
//  ViewController.h
//  Card Master Plus
//
//  Created by yj on 15/6/15.
//  Copyright (c) 2015年 Yang Jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableString *capturedCharacters;
@property (nonatomic) BOOL inItemElement;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSMutableData *responseData;

-(IBAction)buttonTapped:(id)sender;

-(void) parseXML;

@end
