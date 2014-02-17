//
//  QuizViewController.m
//  MK_QuizApp
//
//  Created by MurataKazuki on 2013/12/18.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "QuizViewController.h"
#import "ResultViewController.h"

@interface QuizViewController (){
    NSInteger _currentNumber; //現在の名言番号
    NSMutableArray *userAnswerData;
    __weak IBOutlet UILabel *questionLabel;
    IBOutletCollection(UIButton) NSArray *choiceButton;
    
}

@end

@implementation QuizViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    userAnswerData = [@[] mutableCopy];
    
    [self _reflectDataInView];
}
- (void)_reflectDataInView
{
    NSDictionary *quizRecord = self.dataArray[_currentNumber];
    [questionLabel setText:quizRecord[@"question"]];
    self.title = [NSString stringWithFormat:@"%d / %d", (_currentNumber + 1), [self.dataArray count]];
    for (int i = 0; i < [quizRecord[@"choices"] count]; i++) {
        [choiceButton[i] setTitle:quizRecord[@"choices"][i][@"choice"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)quizAnswered:(id)sender {
    NSDictionary *quizRecord = self.dataArray[_currentNumber];
    [userAnswerData addObject:quizRecord[@"choices"][[sender tag]]];

    NSLog(@"%@",userAnswerData);
    [self showNextView:nil];
}

-(void)showResultViewController{
    ResultViewController *resultViewController
        = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ResultViewController"];
    resultViewController.userAnswerData = userAnswerData;
    [self.navigationController pushViewController:resultViewController animated:YES];
}
- (IBAction)showNextView:(UISwipeGestureRecognizer*)sender
{
    _currentNumber = _currentNumber + 1;
    if ([self.dataArray count] <= _currentNumber) {
        _currentNumber = 0;
        [self showResultViewController];
        return;
    }
    [self refleshViewWithTransitionSubtype:kCATransitionFromRight];
}

- (IBAction)showPreviousView:(UISwipeGestureRecognizer*)sender
{
    _currentNumber = _currentNumber - 1;
    if (_currentNumber < 0) {
        return;
        _currentNumber = [self.dataArray count]-1;
    }
    [self refleshViewWithTransitionSubtype:kCATransitionFromLeft];
}

- (void)refleshViewWithTransitionSubtype:(NSString*)subtype
{
    CATransition *animation = [CATransition animation];
    // アニメーションのタイプ
    [animation setType:kCATransitionPush];
    [animation setSubtype:subtype];
    // アニメーションの長さ
    [animation setDuration:0.7];
    // アニメーションのタイミング
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    // 終了時のイベントを受け取る
    //[animation setDelegate:self];
    
    // アニメーションを登録する。forKeyはアニメの識別子
    [[self.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];
    
    //ビューのデータを更新する
    [self _reflectDataInView];
//
//    [UIView transitionWithView:self.view
//                      duration:1.0
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{
//                    }
//                    completion:^(BOOL finished){
//                        //ビューのデータを更新する
//                        [self _reflectDataInView];
//                    }];
    
}


@end
