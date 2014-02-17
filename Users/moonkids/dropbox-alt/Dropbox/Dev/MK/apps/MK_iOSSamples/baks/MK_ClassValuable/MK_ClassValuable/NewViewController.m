//
//  NewViewController.m
//  MK_ClassValuable
//
//  Created by MurataKazuki on 2014/01/30.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

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
    self.tabBarController.tabBar.frame
  = CGRectMake(0, -50, self.view.frame.size.width, self.tabBarController.tabBar.frame.size.height);
//    self.tabBarController.view.frame
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
