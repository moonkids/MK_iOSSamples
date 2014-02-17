//
//  ResultViewController.h
//  MK_QuizApp
//
//  Created by MurataKazuki on 2013/12/18.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController<UINavigationControllerDelegate>
@property(strong,nonatomic) NSMutableArray *userAnswerData;

@end
