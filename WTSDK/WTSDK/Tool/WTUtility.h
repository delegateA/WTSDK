//
//  WTUtility.h
//  WTSDK
//
//  Created by 张威庭 on 15/9/27.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "WTConst.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WTUtility : NSObject

/** 计算两个经纬的距离 */
+ (double)calculateDistanceWithLatitude:(NSString *)latitudeOne andLongitude:(NSString *)longitudeOne twoDistanceWithLatitude:(NSString *)latitudeTwo andLongitude:(NSString *)longitudeTwo;

+ (void)saveUserInfoDic:(NSMutableDictionary *)dic;

+ (void)saveLastUserName:(NSString *)userName password:(NSString *)password;

+ (NSDictionary *)getUserNameAndPasswordInfoDic;

+ (void)removeUserInfoDic;

+ (void)removeUserNameAndPasswordInfoDic;

+ (NSMutableDictionary *)getUserInfoDic;

+ (BOOL)isASCII:(NSString *)character;

+ (BOOL)isSpecialCharacter:(NSString *)character;

// 验证是否是数字
+ (BOOL)isNumber:(NSString *)character;

/**
 *  震动效果
 */
+ (CAKeyframeAnimation *)shakeAnimation;

//纯颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  代码执行时间0为很多次
 */
void code_RunTime(int times, void (^block)(void));

/**
 *  延迟执行
 */
void after_Run(float time, void (^block)(void));

/**
 *   是否连接到网络
 */
+ (BOOL)connectedToNetwork;

/**
 *  导航栏目的返回键
 */
//+(WTButton*)CreateNavBackBtn;

/**
 *   分割 钱字符串
 */
+ (NSMutableString *)sepearteMoneyByString:(NSMutableString *)money;

/**
 *   显示警告框  该方法显示 不会显示多个
 */
+ (void)showAlertViewWithTitleText:(NSString *)title andMessage:(NSString *)message;

+ (void)hideAlertView;

/**
 *   显示警告框 内部回调
 */
+ (void)showAlertViewWithTitle:(NSString *)title andMsg:(NSString *)message completionBlock:(void (^)(int index))completionBlock canceltitle:(NSString *)canceltitle otherBtn:(NSString *)otherbtn, ...;

/**
 *  按钮点击事件
 */
+ (void)btnSuddenlyTouch:(UIButton *)senderBtn;

/**
 *  计算label的高度
 */
+ (CGFloat)getrowheight:(NSString *)text andFont:(NSInteger)font andWidth:(CGFloat)width;

+ (CGFloat)getrowwidth:(NSString *)text andFont:(NSInteger)font andHeight:(CGFloat)height;

/**
 *  随机
 */
+ (NSString *)randomStr;

/**
 *  能否使用相机 不能用就alertview提示下
 */
+ (BOOL)canUseCamera;

@end
