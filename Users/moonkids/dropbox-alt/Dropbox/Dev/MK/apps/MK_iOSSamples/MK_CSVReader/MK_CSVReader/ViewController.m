//
//  ViewController.m
//  MK_CSVReader
//
//  Created by MurataKazuki on 2013/11/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    NSArray *_dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //***************************************
    //ビューの起動時に、AppDelegateのCSVデータを参照（#importが必要）
    //***************************************
    AppDelegate *ad = [[UIApplication sharedApplication] delegate];

    //AppDelegateを参照できれば、AppDelegateクラスのメソッドやプロパティは自由に利用できる
    _dataArray = [ad dataArray];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //テーブルの件数は、読み込んだデータの件数
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //セルのtextLabel文字列は、「city」と「town」をつないだ文字列
    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"city"],_dataArray[indexPath.row][@"town"]];

    //セルのdetailTextLabel文字列は、「zip」の文字列
    cell.textLabel.text = _dataArray[indexPath.row][@"zip"];
    
    return cell;
}

@end
