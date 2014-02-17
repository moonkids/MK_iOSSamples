//
//  StudentInputModal.h
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StudentInputModalDelegate
-(void) modalInputFinished:(NSDictionary *)inputData;
@end

@interface StudentInputModal : UIViewController<UITextFieldDelegate>
@property (assign,nonatomic) id<StudentInputModalDelegate> delegate;
@end
