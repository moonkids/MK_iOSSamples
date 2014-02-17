//
//  TableViewCellProfileCell.m
//  MK_TableHeightSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "TableViewCellFriendCell.h"

@implementation TableViewCellFriendCell

static float CELL_HEIGHT = 66;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //セルのサイズ
        self.frame = CGRectMake(0, 0, self.window.frame.size.width, CELL_HEIGHT);

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGRect bounds;
    bounds = self.contentView.bounds;
    
    //名言ラベルのレイアウト
    self.nameLabel.frame = CGRectMake(10, 28, bounds.size.width - 15, 0);
    self.nameLabel.lineBreakMode  = NSLineBreakByCharWrapping;
    self.nameLabel.numberOfLines = 1;
    [self.nameLabel sizeToFit];
}

-(CGFloat)heightForCell{
    float cellHeight = 0;
    
//    cellHeight = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}].height;
    
    return cellHeight;
}

@end
