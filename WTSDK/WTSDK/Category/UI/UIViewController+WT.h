//
//  UIViewController+WT.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol BackButtonHandlerProtocol <NSObject>

@optional
/**
 *  self.navigationController
 */
@property(nonatomic,weak) UINavigationController *Nav;

/**
 *  self.Nav 默认动画 pushViewController:vc animated:YES
 */
-(void)pushVc:(UIViewController*)vc;
-(void)pushVcStr:(NSString*)vcstr;
/** 取得对应的Vc */
-(UIViewController*)vcWithClassStr:(NSString*)classStr;

/**
 *  处理返回键 按钮事件 返回NO 先🈲立刻返回咯
 */
-(BOOL)WT_Nav_BackBtnClick;

/**
 * 构建 rightBarButtonItem title
 */
-(void)rightBarBtn:(NSString*)title act:(SEL)selector;
/** 构建 rightBarButtonItem ImageName */
-(void)rightBarBtnImgN:(NSString*)imageN act:(SEL)selector;

/** 打个电话 */
-(void)callTelephone:(NSString*)link;

/** 打开个网页 */
-(void)openHttpUrl:(NSString*)link;

/**
 *  push vc 带其他动画 具体效果自己看
 */
-(void)pushVc:(UIViewController *)vc animateType:(NSInteger)row;

@end


@interface UIViewController (WT)<BackButtonHandlerProtocol>
- (MBProgressHUD *)HUD;
-(void)showHUD;
/**
 * 显示 是否可以点击
 */
-(void)showHUDTouch:(BOOL)touch;
/**
 * 显示文本     延迟消失 0 为默认值
 */
-(void)showHUD:(NSString*)text de:(CGFloat)delay;
/**
 * 显示文本    img -1 不显示图片 1成功 0失败  延迟消失
 */
-(void)showHUD:(NSString*)text img:(NSInteger)img de:(CGFloat)delay;
/**
 *  转 和 文字
 */
-(void)showHUDLabelText:(NSString*)text de:(CGFloat)delay;

- (void)hideHud;
@end
