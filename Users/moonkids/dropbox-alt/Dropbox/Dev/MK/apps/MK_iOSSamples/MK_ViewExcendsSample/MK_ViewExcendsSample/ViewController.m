//
//  ViewController.m
//  MK_ViewExcendsSample
//
//  Created by MurataKazuki on 2013/11/12.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "SuperModalViewController.h"
#import "SubModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dispSuperModalView:(id)sender {
    SuperModalViewController *superVC = [[SuperModalViewController alloc] init];
    [self presentViewController:superVC animated:YES completion:^{}];
    
}
- (IBAction)dispSubModalView:(id)sender {
    SubModalViewController *subVC = [[SubModalViewController alloc] init];
    [self presentViewController:subVC animated:YES completion:^{}];
}

@end
