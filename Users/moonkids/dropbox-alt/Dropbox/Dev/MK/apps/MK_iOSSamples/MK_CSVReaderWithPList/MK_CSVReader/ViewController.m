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
    
    AppDelegate *ad = [[UIApplication sharedApplication] delegate];
    _dataArray = [ad dataArray];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"city"],_dataArray[indexPath.row][@"town"]];
    cell.textLabel.text = _dataArray[indexPath.row][@"zip"];
    
    return cell;
}

@end
