//
//  Event.h
//  MK_Locations
//
//  Created by MurataKazuki on 2013/12/15.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * createDate;

@end
