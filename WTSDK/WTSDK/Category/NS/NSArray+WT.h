//
//  NSArray+WT.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WT)

/**
 *  在objAtindex
 */
-(id)jobjAt:(NSUInteger)index;

#pragma mark -
/**
 *  是否真是数组 [self isKindOfClass:[NSArray class]]
 */
@property (nonatomic,assign,readonly) BOOL isAClass;
/**
 *  数组 转为 JsonStr
 */
@property (nonatomic,copy,readonly) NSString *jsonStr;
/**
 *  合并成用，逗号隔开的字符创
 */
@property (nonatomic,copy,readonly) NSString *combinStr;
/**
 *  》》》请接收返回的数组《《《  按 字段 给数组排序
 */
-(NSArray*)sortbyKey:(NSString*)key asc:(BOOL)ascend;

/**
 *  数组比较
 */
-(BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;

/**
 *  数组计算交集
 */
-(NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/**
 *  数据计算差集
 */
-(NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end

@interface NSMutableArray(WT)

/**
 *  加addObj
 */
-(void)addObj:(id)obj;


@end
