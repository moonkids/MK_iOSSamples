//
//  DetailViewController.m
//  LifeTimer
//
//  Created by Hayato on 13/09/30.
//  Copyright (c) 2013年 Crazyonez. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    
    if((self=[super init])){
        
        
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [self.view addSubview:label];
    label.text = self.userdata[@"name"];
    
    
	// Do any additional setup after loading the view.
    
    //++++++++++++以下を表示++++++++++++
    //その人の画像。またはデフォルトのアバター画像
    //その人の誕生日
    //その人が生まれてからの経過日数
    //今日からその人の推定寿命までの日数
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
