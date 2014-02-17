//
//  StudentTableViewController.h
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/15.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classroom.h"
#import "StudentInputModal.h"

@interface StudentTableViewController : UITableViewController<StudentInputModalDelegate>

//***** CoreData用プロパティ *****
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) Classroom *classroom;

@end
