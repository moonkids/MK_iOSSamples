//
//  TableViewCellProfileCell.m
//  MK_TableHeightSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "TableViewCellProfileCell.h"

@implementation TableViewCellProfileCell

static float CELL_HEIGHT = 200;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //セルのサイズ
        self.frame = CGRectMake(0, 0, self.window.frame.size.width, CELL_HEIGHT);
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        self.nameLabel.numberOfLines = 0;
        [self.contentView addSubview:self.nameLabel];

        //名言ラベルのレイアウト
        self.nameLabel.frame = CGRectMake(10, 10, 200, 100);
    }
    return self;
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    self.contentView.backgroundColor = [UIColor redColor];
    
    self.nameLabel.backgroundColor = [UIColor whiteColor];
}

-(CGFloat)heightForCell{
    NSString *text = self.nameLabel.text;
//    [self.nameLabel sizeToFit];
    NSLog(@"self.frame=(%f,%f)",self.frame.size.width,self.frame.size.height);
    NSLog(@"namelabel.frame=(%f,%f)",self.nameLabel.frame.size.width,self.nameLabel.frame.size.height);
    
    UIFont *nameLabelFont = self.nameLabel.font;
    
//    CGRect newLabelRect = [text boundingRectWithSize:CGSizeMake(200, 1000)
//                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                       attributes:[NSDictionary dictionaryWithObject:nameLabelFont forKey:NSFontAttributeName]
//                                          context:nil];
    
    CGRect newLabelRect = self.nameLabel.frame;
    newLabelRect.size = [text sizeWithFont:nameLabelFont constrainedToSize:CGSizeMake(200, 1000)];
    self.nameLabel.frame = newLabelRect;
    NSLog(@"namelabel.frame=(%f,%f)",self.nameLabel.frame.size.width,self.nameLabel.frame.size.height);
    return newLabelRect.size.height+ 10;
//    
//    //    [self.nameLabel sizeToFit];
//    NSLog(@"*********%@",self.nameLabel);
//    float cellHeight = self.nameLabel.frame.origin.y * 2;
//    float nameHeight = self.nameLabel.frame.size.height;
////    float nameHeight = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName: self.nameLabel.font}].height;
//    NSLog(@"*********%f/%f",self.nameLabel.frame.size.height,cellHeight + nameHeight);
//    return cellHeight + nameHeight + 10;
}

@end
