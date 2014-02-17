//
//  CustomCell2.h
//  MK_DynamicTableViewCell
//
//  Created by MurataKazuki on 2013/11/19.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell2 : UITableViewCell
@property (nonatomic,strong) UILabel *myLabel;

+(CGFloat) heightForText:(NSString *)text;
@end
