//
//  ResultViewController.m
//  MK_QuizSample
//
//  Created by MurataKazuki on 2013/09/29.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
- (IBAction)goTop:(id)sender;

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goTop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
