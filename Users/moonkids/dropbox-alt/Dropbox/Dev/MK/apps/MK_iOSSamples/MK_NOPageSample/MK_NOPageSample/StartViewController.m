//
//  StartViewController.m
//  MK_NOPageSample
//
//  Created by MurataKazuki on 2013/09/30.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "StartViewController.h"
#import "ViewController.h"

@interface StartViewController (){
    //クイズデータの変数（固定値なのでNSArray）
    NSArray *quizData;
}
//ボタンのアクション
- (IBAction)start:(id)sender;
@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //クイズデータの作成
    quizData = @[@{@"quiz": @"ドライアイスは何が固まったもの？",@"ans1": @"窒素",@"ans2": @"酸素",@"ans3": @"二酸化炭素",@"answer":@3}
                 ,@{@"quiz": @"次の野菜のうち、キャベツの仲間はどれ？",@"ans1": @"ごぼう",@"ans2": @"だいこん",@"ans3": @"にんじん",@"answer":@2}
                 ,@{@"quiz": @"江戸時代末期に活躍した新撰組が旗印に用いていたという漢字一文字は何？",@"ans1": @"仁",@"ans2": @"信",@"ans3": @"誠",@"answer":@3}
                 ,@{@"quiz": @"サッカーのＷ杯は、前後半何分ハーフで行なわれる？",@"ans1": @"30分",@"ans2": @"45分",@"ans3": @"60分",@"answer":@2}
                 ,@{@"quiz": @"次の甘味料のうち、天然甘味料はどれ？",@"ans1": @"チクロ",@"ans2": @"ステビア",@"ans3": @"キシリトール",@"answer":@3}
  ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//ボタンのアクション
- (IBAction)start:(id)sender {
    //ビューの部品構成はStoryBoardで行っているので、StoryBoard上のIdentifierを使ってViewを特定
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];

    //作成したクイズデータを引き継ぎ
    vc.quizData = quizData;
    
    //画面遷移
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
