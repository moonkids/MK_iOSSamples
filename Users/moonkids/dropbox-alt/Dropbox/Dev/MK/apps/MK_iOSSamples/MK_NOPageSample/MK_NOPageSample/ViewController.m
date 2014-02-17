//
//  ViewController.m
//  MK_NOPageSample
//
//  Created by MurataKazuki on 2013/09/30.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController (){
    //現在の問題番号
    int quizIndex;
    //回答を記録する（回答を追加するのでNSMutableArray）
    NSMutableArray *answers;
}
//StoryBoardで作成された画面上の部品を参照
@property (weak, nonatomic) IBOutlet UILabel *quizContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *quizNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *answer1Label;
@property (weak, nonatomic) IBOutlet UILabel *answer2Label;
@property (weak, nonatomic) IBOutlet UILabel *answer3Label;
//ボタンのアクション
- (IBAction)answerPushed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //クイズの番号を初期化し
    quizIndex = 0;
    
    //最初の問題を作成（オリジナルのメソッド）
    [self createQuiz];
    
    //回答を切組するためのArrayを初期化（要素０で以後追記）
    answers = [NSMutableArray arrayWithCapacity:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ボタンのアクション（１〜３すべてのボタンが同じメソッドを呼び出す）
- (IBAction)answerPushed:(id)sender {
    
    //ボタンにTag（１〜３）を設定し（StoryBoardで設定）、押したボタンのTag＝回答番号とする
    int answer = ((UIButton *)sender).tag;

    //回答記録データに追加
    [answers addObject:[NSNumber numberWithInt:answer]];
    
    //問題番号を＋１
    quizIndex++;
    
    //最後の問題だった場合には、結果画面に遷移
    if (quizIndex == self.quizData.count) {

        //ビューの部品構成はStoryBoardで行っているので、StoryBoard上のIdentifierを使ってViewを特定
        ResultViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];

        //作成したクイズデータを引き継ぎ
        rvc.quizData = self.quizData;
        rvc.answers = answers;

        //画面遷移
        [self.navigationController pushViewController:rvc animated:YES];
    } else {
        //最後の問題でなければ、問題を描画
        [self createQuiz];
    }
}
- (void)createQuiz{
    //問題番号のラベル
    self.quizNumberLabel.text = [NSString stringWithFormat:@"問題%d", quizIndex + 1];
    //問題内容のラベル
    self.quizContentLabel.text = self.quizData[quizIndex][@"quiz"];
    //選択肢１
    self.answer1Label.text = self.quizData[quizIndex][@"ans1"];
    //選択肢２
    self.answer2Label.text = self.quizData[quizIndex][@"ans2"];
    //選択肢３
    self.answer3Label.text = self.quizData[quizIndex][@"ans3"];
}

@end
