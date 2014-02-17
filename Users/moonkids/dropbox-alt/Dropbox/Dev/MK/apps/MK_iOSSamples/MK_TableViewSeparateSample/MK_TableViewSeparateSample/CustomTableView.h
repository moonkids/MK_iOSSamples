//
//  CustomTableView.h
//  MK_TableViewSeparateSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UITableView<UITableViewDataSource>

@property(nonatomic,strong) NSArray *data;
-(void)shuffle;
@end
