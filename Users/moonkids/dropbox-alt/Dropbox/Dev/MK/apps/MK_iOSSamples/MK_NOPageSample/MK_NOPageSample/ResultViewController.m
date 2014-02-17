//
//  ResultViewController.m
//  MK_NOPageSample
//
//  Created by MurataKazuki on 2013/09/30.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
//StoryBoardで作成された画面上の部品を参照
@property (weak, nonatomic) IBOutlet UILabel *quizResultLabel;
//ボタンのアクション
- (IBAction)top:(id)sender;

@end

@implementation ResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //正解数をカウント
    int correctAnswer = 0;
    
	//問題数の数だけ正解をチェック
    for (int i = 0; i < self.answers.count; i++) {
        //引き継いだ回答内容と、問題の正解の値をチェック
        if (self.answers[i] == self.quizData[i][@"answer"]) {
            //正解なら＋１
            correctAnswer++;
        }
    }
    //結果表示ラベルに正解数を表示
    self.quizResultLabel.text = [NSString stringWithFormat:@"正解数 %d/%d",correctAnswer,self.quizData.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ボタンのアクション
- (IBAction)top:(id)sender {
    //トップに戻る
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
