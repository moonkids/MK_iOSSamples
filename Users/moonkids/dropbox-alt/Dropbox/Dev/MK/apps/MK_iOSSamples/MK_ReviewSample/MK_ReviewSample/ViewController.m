//
//  ViewController.m
//  MK_ReviewSample
//
//  Created by MurataKazuki on 2014/02/12.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [Appirater setAppId:@"552035781"];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:YES];
    [Appirater setDelegate:self];
    [Appirater appLaunched:YES];
}
-(void)appiraterDidDisplayAlert:(Appirater *)appirater{
    NSLog(@"appiraterDidDisplayAlert");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
