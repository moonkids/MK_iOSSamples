//
//  RootViewController.h
//  MK_Locations
//
//  Created by MurataKazuki on 2013/12/13.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UITableViewController<CLLocationManagerDelegate>
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@end
