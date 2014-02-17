//
//  ViewController.m
//  MK_TableHeightSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCellProfileCell.h"
#import "TableViewCellFriendCell.h"

@interface ViewController (){
    NSArray *data;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    data = @[
             @[@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",@"いいいいいいいいい",@"ううううううううううう"]
             ,@[@"かざま",@"かしき"]
             ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier[] = {@"ProfileCell",@"FriendCell"};
    UITableViewCell *cell = nil;
    if (cell == nil) {
        switch (indexPath.section) {
            case 0:
                cell = [[TableViewCellProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier[0]];
                break;
            case 1:
                cell = [[TableViewCellFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier[1]];
                break;
        }
        
    }
    
    switch (indexPath.section) {
        case 0:
            ((TableViewCellProfileCell *)cell).nameLabel.text = data[indexPath.section][indexPath.row];
            break;
        case 1:
            ((TableViewCellFriendCell *)cell).nameLabel.text = data[indexPath.section][indexPath.row];
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //最後にリターンするセルの高さ
    float cellHeight = 0;
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
//            NSLog(@"%@",((TableViewCellProfileCell *)cell).nameLabel.text);
            cellHeight = [((TableViewCellProfileCell *)cell) heightForCell];
            
            break;
        case 1:
            cellHeight = [((TableViewCellFriendCell *)cell) heightForCell];
            break;
    }

    return cellHeight;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor yellowColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor greenColor];
            break;
        default:
            cell.backgroundColor = [UIColor blueColor];
            break;
    }
}
@end
