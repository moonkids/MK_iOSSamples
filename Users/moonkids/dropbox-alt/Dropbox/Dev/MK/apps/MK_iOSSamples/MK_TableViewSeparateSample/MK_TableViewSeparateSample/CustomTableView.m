//
//  CustomTableView.m
//  MK_TableViewSeparateSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}



-(void)shuffle{
    //配列の中身をシャッフルする処理
    NSMutableArray *array = [self.data mutableCopy];
    int count = (int)[array count];
    for (int i = count - 1; i > 0; i--) {
        int randomNum = arc4random() % i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:randomNum];
    }
    self.data = array;
    //データ再読み込み
    [self reloadData];
}
@end
