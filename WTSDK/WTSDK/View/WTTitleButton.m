//
//  WTTitleButton.m
//  wt微博
//
//  Created by 张威庭 on 15/3/15.
//  Copyright (c) 2015年 张威庭. All rights reserved.
//

#import "WTTitleButton.h"

#define WTMargin 5;

@implementation WTTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  设置按钮内部imageView的frame
 *
 *  @param contentRect 按钮的bounds
 *
 *  @return
 */
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//
//

//}
/**
 *  设置按钮内部title的frame
 *
 *  @param contentRect 按钮的bounds
 *
 *  @return
 */
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//

//
//}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame {
    frame.size.width += WTMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可

    // 1.计算titleLabel的frame
    //    self.titleLabel.x = self.imageView.x;

    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + WTMargin;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];

    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];

    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

@end
