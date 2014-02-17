//
//  SuperModalViewController.h
//  MK_ViewExcendsSample
//
//  Created by MurataKazuki on 2013/11/12.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperModalViewController : UIViewController
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *bodyView;
@property (nonatomic,strong) UIView *footerView;

-(void)setBodyView;
@end
