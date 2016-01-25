//
//  NSObject+WT.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WT)
-(NSDictionary *)propertyDictionary;

+ (NSArray *)classPropertyList;
@end
