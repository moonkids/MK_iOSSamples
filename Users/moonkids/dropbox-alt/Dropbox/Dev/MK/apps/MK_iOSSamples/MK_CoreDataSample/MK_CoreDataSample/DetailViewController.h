//
//  DetailViewController.h
//  MK_CoreDataSample
//
//  Created by MurataKazuki on 2013/12/09.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
