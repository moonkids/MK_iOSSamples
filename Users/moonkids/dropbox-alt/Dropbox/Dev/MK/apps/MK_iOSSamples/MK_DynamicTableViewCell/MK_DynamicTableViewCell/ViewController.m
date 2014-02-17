//
//  ViewController.m
//  MK_DynamicTableViewCell
//
//  Created by MurataKazuki on 2013/11/19.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell1.h"
#import "CustomCell2.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface ViewController (){
    NSArray *_data;
    UITableView *_tableView;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _data = @[@[
      @"ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ",
      @"いいいいいいいいいいいいいいいいいい",
      @"ううううううううううううううううううううううううううううううううううううううううううううううううううう"
    ],@[
      @"かかかかかかかかかかかかかかかかかか",
      @"きききききききききききききききききききききききききききききききききききききききき"
      ]];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //iOS6から、セルの作成方法が変わっています。こちらのやり方が推奨されているようです。
    //TableViewに対して、セルのクラスを登録し再利用可能にする（おそらくセルがなければ自動的にallocして作ってくれる）
    [_tableView registerClass:[CustomCell1 class] forCellReuseIdentifier:@"CustomCell1"];
    [_tableView registerClass:[CustomCell2 class] forCellReuseIdentifier:@"CustomCell2"];
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            //セルを取り出すときには、登録した名称で取り出す（無ければ制裁されているので、nilがreturnされない）
            cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell1" forIndexPath:indexPath];
            ((CustomCell1 *)cell).myLabel.text = _data[indexPath.section][indexPath.row];
            break;
            
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell2" forIndexPath:indexPath];
            ((CustomCell2 *)cell).myLabel.text = _data[indexPath.section][indexPath.row];
            break;
    }
    UITextView *textView ;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight =0;
    
    //高さを計るときには、それぞれのセルに用意されているクラスメソッドに、文字列を渡して計算させる
    //ポイントは、セル上に表示されている文字を使うのではなく、datasourceとしているNSArrayから文字列を渡す
    //（セルに文字が設定される前に、高さを計算しようとしてしまうので、こうしないと値がおかしくなります）
    switch (indexPath.section) {
        case 0:
            cellHeight = [CustomCell1 heightForText:_data[indexPath.section][indexPath.row]];
            break;
            
        case 1:
            cellHeight = [CustomCell2 heightForText:_data[indexPath.section][indexPath.row]];
            break;
    }
    
    return cellHeight;
}

@end
