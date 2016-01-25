//
//  WTUtility.m
//  WTSDK
//
//  Created by 张威庭 on 15/9/27.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "WTUtility.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

#import "SystemConfiguration/SystemConfiguration.h"
#include <netdb.h>
#import <mach/mach_time.h>

#import <AVFoundation/AVFoundation.h>

#define ORIGINAL_MAX_WIDTH 640.0f
#import "UIImage+WT.h"
#import "RSKImageCropViewController.h"
#import "IBActionSheet.h"
@implementation WTUtility

+ (void)saveLastUserName:(NSString *)userName password:(NSString *)password {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{ @"userName" : userName,
                           @"password" : password };
    [userDefaults setObject:dic forKey:@"UserNameAndPasswordDic"];
}

+ (NSDictionary *)getUserNameAndPasswordInfoDic {
    return [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserNameAndPasswordDic"]];
}
+ (void)saveUserInfoDic:(NSMutableDictionary *)dic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:@"UserModelDic"];
    [userDefaults synchronize];
}

+ (void)removeUserInfoDic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"UserModelDic"];
}

+ (void)removeUserNameAndPasswordInfoDic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"UserNameAndPasswordDic"];
}
+ (NSMutableDictionary *)getUserInfoDic {
    return [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserModelDic"]];
}

// 纯颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//验证是否ASCII码
+ (BOOL)isASCII:(NSString *)Character {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
                                                             ""];
    NSRange specialrang = [Character rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}
//验证是含本方法定义的 “特殊字符”
+ (BOOL)isSpecialCharacter:(NSString *)Character {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
                                                                              ""];
    NSRange specialrang = [Character rangeOfCharacterFromSet:set];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证是否是数字
+ (BOOL)isNumber:(NSString *)Character {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [Character rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}
//震动效果
+ (CAKeyframeAnimation *)shakeAnimation {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[ [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)] ];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    return shake;
    //[Btn.layer addAnimation:shake forKey:nil];
}

/**
 *  代码执行时间
 */
void WTUseTime(void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return;
    uint64_t start = mach_absolute_time();
    block();
    uint64_t end = mach_absolute_time();
    uint64_t elapsed = end - start;
    uint64_t nanos = elapsed * info.numer / info.denom;
    NSLog(@"⏰ %f", (CGFloat) nanos / NSEC_PER_SEC);
}
/**
 *  代码执行时间(循环XXXXX次)
 */
void Code_RunTime(int times, void (^block)(void)) {
    int TureTime = times ? times : 10000;
    WTUseTime(^{
        for (int i = 0; i < TureTime; i++) {
            block();
        }
    });
}
/**
 *  发通知
 */
void post_Notification(NSString *notification) {
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}
/**
 *  收通知
 */
void add_Notification(id Obs, SEL Sel, NSString *notification, id Obj) {
    [[NSNotificationCenter defaultCenter] addObserver:Obs selector:Sel name:notification object:Obj];
}

/**
 *  延迟执行
 */
void after_Run(float time, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

+ (BOOL)connectedToNetwork {
    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress; //sockaddr_in是与sockaddr等价的数据结构
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET; //sin_family是地址家族，一般都是“AF_xxx”的形式。通常大多用的是都是AF_INET,代表TCP/IP协议族

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *) &zeroAddress); //创建测试连接的引用：
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags) {
        printf("Error. Could not recover network reachability flagsn");
        return NO;
    }

    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);

    //    NSLog(@"------%d",isReachable);
    //    NSLog(@"------%d",needsConnection);
    //return (isReachable && !needsConnection) ? NO : YES;//反向测试
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSMutableString *)sepearteMoneyByString:(NSMutableString *)money {
    NSInteger three = 0;
    NSInteger slong = money.length;
    while (slong--) {
        three++;
        if (three == 3) {
            three = 0;
            [money insertString:@" " atIndex:slong];
        }
    }
    return money;
}

////导航栏目的返回键
//+(WTButton*)createNavBackBtn{
//    WTButton *Nav_Btn;
//    if (iPhone6Plus_Screen) {
//        Nav_Btn = [[WTButton alloc]initWithFrame:CGRectMake(0, 5, 100, 45) ImgF:CGRectMake(12, 6.0, 21, 21) TitF:CGRectMake(32, 9.0, 68, 15)];
//    }else{
//        Nav_Btn = [[WTButton alloc]initWithFrame:CGRectMake(0, 5, 100, 45) ImgF:CGRectMake(7.9, 5.8, 21, 21) TitF:CGRectMake(32, 8.8, 68, 15)];
//    }
//    [Nav_Btn setImage:[UIImage imageNamed:@"EVGONavBack"] forState:UIControlStateNormal];
//    [Nav_Btn setTitle:@"" forState:UIControlStateNormal];
//    Nav_Btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    Nav_Btn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [Nav_Btn setTitleColor:EVGO_Color_Title_Gray forState:UIControlStateNormal];
//    [Nav_Btn setTitleColor:EVGO_Color_Title forState:UIControlStateHighlighted];
//    return Nav_Btn;
//}

//提示框
+ (void)showAlertViewWithTitleText:(NSString *)title andMessage:(NSString *)message {
    [[WTHandleCommon shareCommonHandleClass] showAlertView:title showMessage:message]; //单例用于解决同时显示多个alterView
}

+ (void)showAlertViewWithTitle:(NSString *)title andMsg:(NSString *)message completionBlock:(void (^)(int index))completionBlock canceltitle:(NSString *)canceltitle otherBtn:(NSString *)otherbtn, ... {
    NSMutableArray *arr = [NSMutableArray array];
    if (otherbtn != nil) {
        [arr addObject:otherbtn];
    }

    va_list args;
    va_start(args, otherbtn);
    if (otherbtn) {
        NSObject *other;
        while ((other = va_arg(args, NSObject *) )) {
            //otherBtn最后面 要加 nil
            [arr addObject:(NSString *) other];
        }
    }
    va_end(args);
    [[WTHandleCommon shareCommonHandleClass] showAlertView:title showMessage:message cancleBtn:canceltitle otherBtn:arr completionBlock:completionBlock];
}

+ (void)hideAlertView {
    [[WTHandleCommon shareCommonHandleClass] hideAlertView];
}

//保证在scrollview上的Btn也有点击效果
+ (void)btnSuddenlyTouch:(UIButton *)senderBtn {
    senderBtn.selected = !senderBtn.isSelected;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        senderBtn.selected = !senderBtn.isSelected;
    });
}

//计算单元格高度
+ (CGFloat)getrowheight:(NSString *)text andFont:(NSInteger)font andWidth:(CGFloat)width {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 8888) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName] context:Nil];
    return rect.size.height;
}

//MAXFLOAT
+ (CGFloat)getrowwidth:(NSString *)text andFont:(NSInteger)font andHeight:(CGFloat)height {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(8888, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName] context:Nil];
    return rect.size.width;
}

//随机
+ (NSString *)randomStr {
    const int N = 5;
    NSString *sourceString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init];
    // srand((int)time(0));
    for (int i = 0; i < N; i++) {
        [result appendString:[sourceString substringWithRange:NSMakeRange(rand() % [sourceString length], 1)]];
    }
    return result;
}

@end

#pragma mark - WTHandleCommon  AlertView

typedef void (^indexBtnClickBlock)(int);

typedef NS_ENUM(NSInteger, AlertType) {
    AlertViewUseBlock = 1,
};

@interface WTHandleCommon () {
    BOOL _isShowAlterView;
    indexBtnClickBlock _indexBtnClickBlock;
}

@end
;
@implementation WTHandleCommon
static WTHandleCommon *instance;

+ (id)allocWithZone:(struct _NSZone *)zone {
    static WTHandleCommon *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });

    return instance;
}

+ (instancetype)shareCommonHandleClass {
    return [[self alloc] init];
}

- (void)showAlertView:(NSString *)title showMessage:(NSString *)message {
    if (!_isShowAlterView) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        _isShowAlterView = YES;
    }
}

- (void)showAlertView:(NSString *)title showMessage:(NSString *)message cancleBtn:(NSString *)cancletitle otherBtn:(NSMutableArray *)arr completionBlock:(void (^)())completionBlock {
    self.alertWT = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancletitle otherButtonTitles:nil];
    for (NSString *btntitle in arr) {
        [self.alertWT addButtonWithTitle:btntitle];
    }
    self.alertWT.tag = AlertViewUseBlock;
    [self.alertWT show];
    _indexBtnClickBlock = completionBlock;
}

- (void)hideAlertView {
    [self.alertWT dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _isShowAlterView = NO;

    if (_indexBtnClickBlock != nil && alertView.tag == AlertViewUseBlock) {
        (_indexBtnClickBlock((int) buttonIndex));
        _indexBtnClickBlock = nil;
    }
}

#pragma mark - 相机获取图片相关
+ (WTHandleCommon *)readlyToPick_Vc:(UIViewController *)vc roundImg:(BOOL)round pick:(PickImgBlock)block {
    WTHandleCommon *Picker = [WTHandleCommon shareCommonHandleClass];
    Picker.superVC = vc;
    Picker.pickImgBlock = block;
    Picker.roundImg = round;
    return Picker;
}

//搞张图片 默认 @"拍照",@"从相册中选择" 返回修改过大小的图片 title 标题而已 vc    self 是否圆形选择图片？
+ (void)cameraPick_Img:(NSString *)title vc:(UIViewController *)vc roundImg:(BOOL)round pick:(PickImgBlock)block {
    [vc.view endEditing:YES];
    [WTHandleCommon readlyToPick_Vc:vc roundImg:round pick:block];
    IBActionSheet *Ibac = [[IBActionSheet alloc] initWithTitle:title
                                                      callback:^(IBActionSheet *actionSheet, NSInteger buttonIndex) {
                                                          if (buttonIndex == 0) {
                                                              [[WTHandleCommon shareCommonHandleClass] choosePhoto:UIImagePickerControllerSourceTypeCamera edit:YES];
                                                          } else if (buttonIndex == 1) {
                                                              [[WTHandleCommon shareCommonHandleClass] choosePhoto:UIImagePickerControllerSourceTypePhotoLibrary edit:YES];
                                                          }
                                                      }
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [Ibac showInView:vc.navigationController.view];
}
+ (void)cameraPickImg_Type:(UIImagePickerControllerSourceType)type vc:(UIViewController *)vc roundImg:(BOOL)round edit:(BOOL)edit pick:(PickImgBlock)block {
    [[WTHandleCommon readlyToPick_Vc:vc roundImg:round pick:block] choosePhoto:type edit:edit];
}

//@"拍照",@"从相册中选择"
- (void)choosePhoto:(UIImagePickerControllerSourceType)choosetype edit:(BOOL)edit {
    if (![UIImagePickerController isSourceTypeAvailable:choosetype]) {
        return;
    }
    //如果使用相机的 拍照
    if (choosetype == UIImagePickerControllerSourceTypeCamera) {
        //无可用相机 或 用户设置的权限阻拦
        if (![WTHandleCommon canUseCamera] || ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
    }

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = self.allowsEdit = self.roundImg ? NO : edit;
    picker.delegate = (id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) self;
    picker.sourceType = choosetype;
    [self.superVC presentViewController:picker
                               animated:YES
                             completion:^{
                                 //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//如果有必要 前后结束设置 系统状态栏文本的颜色
                             }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *fixImg = [self.allowsEdit ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage] allowMaxImg_thum:NO];
    if (self.roundImg) {
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:fixImg cropMode:RSKImageCropModeCircle];
        imageCropVC.delegate = (id<RSKImageCropViewControllerDelegate>) self;
        [picker pushViewController:imageCropVC animated:YES];

        return;
    }
    if (self.pickImgBlock) {
        self.pickImgBlock(fixImg, picker);
    }
    if (![NSStringFromClass([_superVC class]) isEqualToString:@"😛 写你想要的类 😛"]) {
        [picker dismissViewControllerAnimated:YES
                                   completion:^{
                                   }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//如果有必要 前后结束设置 系统状态栏文本的颜色
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                               }];
}
//RSKImageCropViewController 的 回调
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage {
    if (self.pickImgBlock) {
        self.pickImgBlock(croppedImage, nil);
    }
    [controller dismissViewControllerAnimated:YES
                                   completion:^{
                                   }];
}

/**
 *  能否使用相机
 */
+ (BOOL)canUseCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusRestricted) {
        NSLog(@"Restricted");
    } else if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在设备的设置-隐私-相机 中允许访问相机。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    } else if (authStatus == AVAuthorizationStatusAuthorized) { //允许访问
        return YES;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:mediaType
                                 completionHandler:^(BOOL granted) {
                                     if (granted) { //点击允许访问时调用
                                         //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                                         NSLog(@"Granted access to %@", mediaType);
                                     } else {
                                         NSLog(@"Not granted access to %@", mediaType);
                                     }
                                 }];
    } else {
        NSLog(@"Unknown authorization status");
    }

    return YES;
}

@end
