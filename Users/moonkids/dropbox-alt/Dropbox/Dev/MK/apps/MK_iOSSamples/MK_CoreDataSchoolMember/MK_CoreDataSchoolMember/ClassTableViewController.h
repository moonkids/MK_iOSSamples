//
//  ClassTableViewController.h
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/15.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTableViewController : UITableViewController

//***** CoreData用プロパティ *****
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
