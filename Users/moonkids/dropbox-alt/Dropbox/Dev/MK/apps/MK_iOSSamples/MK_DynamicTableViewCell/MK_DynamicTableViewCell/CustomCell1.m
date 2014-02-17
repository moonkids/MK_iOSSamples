//
//  CustomTableViewCell1.m
//  MK_DynamicTableViewCell
//
//  Created by MurataKazuki on 2013/11/19.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "CustomCell1.h"

@implementation CustomCell1
static CGFloat LABEL_WIDTH = 300;
static CGFloat LABEL_MARGIN = 10;
static CGFloat LABEL_FONT_SIZE = 14;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //このセルのラベルを作成
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, LABEL_WIDTH, 0)];
        self.myLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.myLabel.numberOfLines = 0;
        self.myLabel.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        [self.contentView addSubview:self.myLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor yellowColor];
    self.myLabel.backgroundColor = [UIColor whiteColor];
    
    //このセルのラベルの縦幅を計算
    CGRect newRect = self.myLabel.frame;
    newRect.size = CGSizeMake(LABEL_WIDTH, 0);
    self.myLabel.frame = newRect;
    
    //このセルのラベルサイズは自動調整
    [self.myLabel sizeToFit];
}

//セル固有の計算をするためのクラスメソッド
+(CGFloat) heightForText:(NSString *)text{
    CGFloat resultHeight = 0;
    
    //ラベルの計算に必要な情報
    UIFont *labelFont = [UIFont systemFontOfSize:LABEL_FONT_SIZE];  //フォントのサイズと種類
    CGSize constraint = CGSizeMake(LABEL_WIDTH, CGFLOAT_MAX);       //ラベルの横幅（固定値）と縦幅（大きな値）
    
    CGSize newSize;
    //iOS7の新メソッドが使えるかをチェック
    if ([text respondsToSelector:@selector(sizeWithAttributes:)]) {

//iOS7の新メソッドが使える場合
NSLog(@"respond");
//対象の文字列を表示するのにどれだけの領域が必要かを調べるメソッド
CGRect totalRect = [text boundingRectWithSize:constraint
                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                   attributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]
                                      context:nil];
newSize = totalRect.size;
    } else {
        
        //iOS7の新メソッドが使えない場合
        NSLog(@"not respond");
        //フォントを基準に、対象の文字列を表示するのにどれだけの領域が必要かを調べるメソッド（iOS7 deprecated）
        newSize = [text sizeWithFont:labelFont constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    //ラベルの下に余白を作るために、マージン値を調整
    resultHeight = newSize.height + LABEL_MARGIN;
    return resultHeight;
}

@end
