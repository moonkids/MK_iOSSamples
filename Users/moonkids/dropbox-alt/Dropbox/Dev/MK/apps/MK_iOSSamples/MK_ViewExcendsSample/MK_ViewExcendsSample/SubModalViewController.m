//
//  SubModalViewController.m
//  MK_ViewExcendsSample
//
//  Created by MurataKazuki on 2013/11/12.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "SubModalViewController.h"

@interface SubModalViewController ()

@end

@implementation SubModalViewController

- (void)viewDidLoad
{
    //先に親クラス（SuperModalViewController）のviewDidLoadを呼び出すので、
    //ここでsetHeaderView,setBodyView,setFooterViewの順で呼び出される
    [super viewDidLoad];

    // Subクラスの背景色（＝青色）
    self.view.backgroundColor = [UIColor blueColor];
}

//*******************************************
//このメソッドで親クラスのメソッドをオーバーライドする
//*******************************************
-(void)setBodyView{
    
    //もし親クラスのsetContentViewの内容を実行させた上で、
    //処理を追加するのであれば、先にsuperの呼び出しを実行しておく
//    [super setBodyView];
    
    //親クラスのメソッドsetContentViewをオーバーライドすることで、処理内容を上書きできる
    self.bodyView = [[UIView alloc] init];
    self.bodyView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.bodyView];
    
    //子クラスでは、BodyViewの高さを倍にしている
    self.bodyView.frame = CGRectMake(10, self.headerView.frame.origin.y + self.headerView.frame.size.height, 300, 200);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"SubクラスのBodyView";
    [self.bodyView addSubview:label];
}


@end
