//
//  ResultViewController.h
//  MK_NOPageSample
//
//  Created by MurataKazuki on 2013/09/30.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

//受け継ぐ問題内容と回答内容
@property (strong,nonatomic) NSArray *quizData;
@property (strong,nonatomic) NSMutableArray *answers;
@end
