//
//  ViewController.m
//  MK_SMSSample
//
//  Created by MurataKazuki on 2014/01/24.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import <MessageUI/MessageUI.h> 
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)pushed:(id)sender {
  if ([MFMessageComposeViewController canSendText]) {
    MFMessageComposeViewController *messageComposer =
    [[MFMessageComposeViewController alloc] init];
    NSString *message = @"Your Message here";
    [messageComposer setBody:message];
    //    messageComposer.delegate = self;
    [self presentViewController:messageComposer animated:YES completion:nil];
  } else {
    NSLog(@"no");
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  NSMutableDictionary *dic = [@{
                                               @"notificationID" : @"",
                                               @"label" : @"お気に入り名言",
                                               @"daysLabel" : @"月 火 水 木 金 土 日",
                                               @"isSwitchOn" : @YES,
                                               @"time" : [NSDate date],
                                               @"days" : @[@"月", @"火", @"水", @"木", @"金", @"土", @"日"],
                                               @"registType" : @"bookmark",
                                               @"data" : @""
                                               } mutableCopy];

  if ([dic[@"isSwitchOn"] boolValue] == YES){
    NSLog(@"aa");
  } else {
    NSLog(@"no");
  }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
