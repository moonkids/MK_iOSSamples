//
//  Student.h
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageData;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) ImageData *imageData;

@end
