//
//  ViewController.m
//  MK_ContentViewSample
//
//  Created by MurataKazuki on 2013/11/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//StoryBoardで関係付けられたContainerView
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)valueChanged:(id)sender {
    int index = [((UISegmentedControl *)sender) selectedSegmentIndex];

    //画面切り替え時に、containerViewからsubViewを取り除く
    [self.containerView.subviews[0] removeFromSuperview];
    //画面切り替え時に、childViewControllerを取り除く
    [self.childViewControllers[0] removeFromParentViewController];
    
    //どちらもUIViewControllerなので、変数は共通として、移動先のViewControllerを生成
    UIViewController *tvc = nil;
    switch(index){
        case 0:
            //StoryBoardを使っているので書き方が違いますが、
            //StoryBoardなしなら、tvc = [[CategoryViewController alloc] init]でよい。
            tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryViewController"];
            break;
        case 1:
            tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"peopleTableViewController"];
            break;
    }
    //childViewControllerを追加
    [self addChildViewController:tvc];
    //追加するViewControllerのviewをsubViewとして追加
    [self.containerView addSubview:tvc.view];
    //追加終了のメソッド（必須：遷移アニメーションなどを付ける時のcompleteで使う）
    [self didMoveToParentViewController:tvc];
}

@end
