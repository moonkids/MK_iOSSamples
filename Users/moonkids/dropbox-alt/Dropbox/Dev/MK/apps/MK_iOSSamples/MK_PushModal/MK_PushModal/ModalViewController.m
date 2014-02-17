//
//  ModalViewController.m
//  MK_PushModal
//
//  Created by MurataKazuki on 2014/02/13.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController
- (IBAction)closeModal:(id)sender {
    NSLog(@"ModalViewController：閉じるボタンの「touch up inside」が実行され、closeModalメソッドが呼び出されました");
    [self dismissViewControllerAnimated:YES completion:^{}];
}

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

@end
