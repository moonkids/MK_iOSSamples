//
//  ViewController.m
//  MK_GestureSample1
//
//  Created by MurataKazuki on 2013/11/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *_data;
    NSInteger currentPage;
    __weak IBOutlet UILabel *label;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];

    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    _data = @[@"aa",@"bb",@"cc"];
    currentPage = 0;
    [self dataRefresh];
}
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    // 右スワイプされた時にログに表示
    NSLog(@"Notice Right Gesture");
    currentPage--;
    if (currentPage < 0) {
        currentPage = _data.count -1;
    }
    [self dataRefresh];
}

- (void)selSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    // 右スワイプされた時にログに表示
    NSLog(@"Notice Left Gesture");
    
    currentPage++;
    if (currentPage == _data.count) {
        currentPage = 0;
    }
    [self dataRefresh];
}
-(void)dataRefresh{
    label.text = _data[currentPage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
