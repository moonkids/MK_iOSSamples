//
//  UICategoryViewControler.m
//  MK_ContentViewSample
//
//  Created by MurataKazuki on 2013/11/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CategoryViewController

//ボタンを押された時の処理
- (IBAction)pushed:(id)sender {
    self.label.text = @"Pushed!!";
}
@end
