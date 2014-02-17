//
//  SuperModalViewController.m
//  MK_ViewExcendsSample
//
//  Created by MurataKazuki on 2013/11/12.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "SuperModalViewController.h"

@interface SuperModalViewController ()

@end

@implementation SuperModalViewController

- (void)viewDidLoad
{
    //先に親クラス（UIViewController）のviewDidLoadを呼び出す
    [super viewDidLoad];
    
    // Superクラスの背景色（＝黄色）
    self.view.backgroundColor = [UIColor yellowColor];
    
    //戻るボタン（SuperだけにあればSubでは不要）
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setTitle:@"戻る" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 100, 40);
    [self.view addSubview:backButton];
    
    //親子共通の処理として、3つのビューの描画を行う
    [self setHeaderView];
    [self setBodyView]; //SuperModalが表示される場合には、このクラス内のsetContentViewが、SubModalが表示される場合には、SubModalのsetContentViewが呼ばれる
    [self setFooterView];
}
//*******************************************
// HeaderViewの描画メソッド
//*******************************************
-(void)setHeaderView{
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.headerView];

    //headerViewの位置は、固定
    self.headerView.frame = CGRectMake(10, 50, 300, 100);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"HeaderView";
    [self.headerView addSubview:label];
}

//*******************************************
//このメソッドの内容を子クラスでオーバーライドする前提
//*******************************************
-(void)setBodyView{
    self.bodyView = [[UIView alloc] init];
    self.bodyView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bodyView];

    //contentViewの位置は、headerViewの位置 + headerViewの高さ
    self.bodyView.frame = CGRectMake(10, self.headerView.frame.origin.y + self.headerView.frame.size.height, 300, 100);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"SuperクラスのBodyView";
    [self.bodyView addSubview:label];
}

//*******************************************
// FooterViewの描画メソッド
//*******************************************
-(void)setFooterView{
    self.footerView = [[UIView alloc] init];
    self.footerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.footerView];
    
    //footerViewの位置は、headerViewの位置 + headerViewの高さ + contentViewの高さ
    self.footerView.frame = CGRectMake(10, self.headerView.frame.origin.y + self.headerView.frame.size.height + self.bodyView.frame.size.height, 300, 100);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"FooterView";
    [self.footerView addSubview:label];
}


//戻るボタン（SuperだけにあればSubでは不要）
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
