//
//  Classroom.h
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Classroom : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;
@end

@interface Classroom (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
