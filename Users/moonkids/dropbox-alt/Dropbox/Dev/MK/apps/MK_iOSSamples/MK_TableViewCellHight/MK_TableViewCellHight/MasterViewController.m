//
//  MasterViewController.m
//  MK_TableViewCellHight
//
//  Created by MurataKazuki on 2013/11/18.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () {
    NSArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}
static float defaultHeight = 0;
static float defaultMargin = 0;
static UITableViewCell *defaultCell = nil;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _objects = @[
      @[@"1234567890123456789012345678901234567890",@"12345678901234567890123456789012345678901234567890123456789012345678901234567890",@"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"]
      ,@[@"かざま",@"かしき"]
      ];

    defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    defaultHeight = defaultCell.frame.size.height;
    defaultMargin = fabs(defaultHeight - defaultCell.textLabel.frame.size.height);
    NSLog(@"%f,%f",defaultCell.textLabel.frame.size.height,defaultMargin);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objects[0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = _objects[0][indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellHeight = 0;
    NSString *text = _objects[0][indexPath.row];
    cellHeight = [text sizeWithFont:defaultCell.textLabel.font constrainedToSize:CGSizeMake(200, 10000) lineBreakMode:NSLineBreakByCharWrapping].height;
    NSLog(@"%@,%f,%f",text,cellHeight,defaultMargin);
    
    return cellHeight + defaultMargin;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
