//
//  WTUtility.h
//  WTSDK
//
//  Created by 张威庭 on 15/9/27.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WTConst.h"
@interface WTUtility : NSObject

+ (void)saveUserInfoDic:(NSMutableDictionary *)dic;

+ (void)saveLastUserName:(NSString *)userName password:(NSString *)password;

+ (NSDictionary *)getUserNameAndPasswordInfoDic;

+ (void)removeUserInfoDic;

+(void)removeUserNameAndPasswordInfoDic;

+ (NSMutableDictionary *)getUserInfoDic;



+(BOOL)isASCII:(NSString*)character;

+(BOOL)isSpecialCharacter:(NSString*)character;


// 验证是否是数字
+(BOOL)isNumber:(NSString*)character;

/**
 *  震动效果
 */
+(CAKeyframeAnimation *)shakeAnimation;

//纯颜色图片
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  代码执行时间0为很多次
 */
void code_RunTime (int times,void(^block)(void));
/**
 *  发通知
 */
void post_Notification (NSString *notification);
/**
 *  收通知
 */
void add_Notification(id Obs,SEL Sel,NSString *notification,id Obj);

/**
 *  延迟执行
 */
void after_Run (float time,void (^block)(void));



/**
 *   是否连接到网络
 */
+(BOOL)connectedToNetwork;

/**
 *  导航栏目的返回键
 */
//+(WTButton*)CreateNavBackBtn;

/**
 *   分割 钱字符串
 */
+(NSMutableString *)sepearteMoneyByString:(NSMutableString *)money;

/**
 *   显示警告框  该方法显示 不会显示多个
 */
+ (void)showAlertViewWithTitleText:(NSString *)title andMessage:(NSString *)message;

+(void)hideAlertView;

/**
 *   显示警告框 内部回调
 */
+ (void)showAlertViewWithTitle:(NSString *)title andMsg:(NSString *)message completionBlock:(void(^)(int index))completionBlock canceltitle:(NSString*)canceltitle  otherBtn:(NSString *)otherbtn, ...;

/**
 *  按钮点击事件
 */
+(void)btnSuddenlyTouch:(UIButton *)senderBtn;

/**
 *  计算label的高度
 */
+(CGFloat)getrowheight:(NSString *)text andFont:(NSInteger )font andWidth:(CGFloat)width;

+(CGFloat)getrowwidth:(NSString *)text andFont:(NSInteger )font andHeight:(CGFloat)height;


/**
 *  随机
 */
+(NSString *)randomStr;

@end




#pragma mark - WTHandleCommon  AlertView

@interface WTHandleCommon : NSObject
+(instancetype)shareCommonHandleClass;


@property(nonatomic,strong)UIAlertView *  alertWT;

/**
 *  显示警告框  用这方法显示的 不会显示多个
 */
-(void)showAlertView:(NSString *)title showMessage:(NSString*)message;


/**
 *  显示警告框 内部回调
 */
-(void)showAlertView:(NSString *)title showMessage:(NSString *)message cancleBtn:(NSString *)cancletitle otherBtn:(NSMutableArray*)arr completionBlock:(void (^)())completionBlock;

-(void)hideAlertView;



#pragma mark - 图片相关

@property (nonatomic,weak) UIViewController *superVC;
typedef void(^PickImgBlock)(UIImage *fixedImg,UIImagePickerController *picker);
@property (nonatomic,strong) PickImgBlock pickImgBlock;
@property (nonatomic,assign) BOOL roundImg;/**< 剪裁圆形图片 */
@property (nonatomic,assign) BOOL allowsEdit;/**< 可编辑否 */

/**
 *  搞张图片 默认 @"拍照",@"从相册中选择" 返回修改过大小的图片 title 标题而已 vc    self 是否圆形选择图片？
 */
+(void)cameraPick_Img:(NSString*)title vc:(UIViewController*)vc roundImg:(BOOL)round pick:(PickImgBlock)block;

/**
 *  搞张图片 直接使用相机或相册
 */
+(void)cameraPickImg_Type:(UIImagePickerControllerSourceType)type  vc:(UIViewController*)vc roundImg:(BOOL)round edit:(BOOL)edit pick:(PickImgBlock)block;

/**
 *  能否使用相机 不能用就alertview提示下
 */
+(BOOL)canUseCamera;






@end

