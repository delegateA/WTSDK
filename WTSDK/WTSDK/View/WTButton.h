//
//  WTButton.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTButton : UIButton


/**
 *  四角变圆
 */
@property(nonatomic,assign) CGFloat rad;

/**
 *  边框啊 传空默认颜色或hex   宽默认1
 */
@property(nonatomic,copy) NSString *bor_c;


/**
 *  项目默认的 颜色 img UIControlState Normal = 0 Highlighted = 1 Selected = 4
 */
@property (nonatomic,assign) NSInteger  status;



@property (nonatomic,copy)   NSString  *bcimg_c;/**< 传空默认颜色或hex Normal  */

/** 记录info  或tag */
@property (nonatomic,assign) NSInteger row;


@property(nonatomic,strong) UIActivityIndicatorView *act;
@property (nonatomic,copy) NSString *normalStr;
@property (nonatomic,assign) BOOL normalEnable;

@property (assign,nonatomic) CGRect imgf;
@property (assign,nonatomic) CGRect titf;

-(void)loading;/**< 进度中。。 */
-(void)stopLing;/**< 停止进度 */

/**
 *  项目默认的 颜色 img UIControlState Normal = 0 Highlighted = 1 Selected = 4
 */
-(void)setBcimg:(NSInteger)status;

- (id)initWithFrame:(CGRect)frame imgF:(CGRect)imgf titF:(CGRect)titf;


- (CGRect)imageRectForContentRect:(CGRect)contentRect;/**< 图片在Btn里的位置 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect;/**< 文本在Btn里的位置 */





@end
