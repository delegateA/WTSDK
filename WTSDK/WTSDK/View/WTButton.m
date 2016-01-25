//
//  WTButton.m
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "WTButton.h"
#import "UIView+WT.h"
#import "UIImage+WT.h"

@implementation WTButton
/**
 *  四角变圆
 */
-(void)setRad:(CGFloat)rad{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = rad;
}
/**
 *  边框啊 颜色 宽默认1
 */
-(void)setBor_c:(NSString *)bor_c{
//    if ([bor_c isEqualToString:@"EVGO_Color"] || bor_c.length == 0) {
//        [self border:[UIColor lightGrayColor] width:1];
//        return;
//    }
//    if (![bor_c hasPrefix:@"0x"]) {
//        bor_c = [NSString stringWithFormat:@"0x%@",bor_c];
//    }
//    unsigned long red = strtoul([bor_c UTF8String],0,16);
//    [self border:[UIColor lightGrayColor] width:1];
}

/**
 *  项目默认的 颜色 img UIControlState Normal = 0 Highlighted = 1 Selected = 4
 */
-(void)setBcimg:(NSInteger)status {
    [self setBackgroundImage:[UIImage coloreImage:[UIColor lightGrayColor]] forState:status];
   
}


/**< 默认颜色或hex Normal */
-(void)setBcimg_c:(NSString *)bcimg_c{
    if ([bcimg_c isEqualToString:@"EVGO_Color"] || bcimg_c.length == 0) {
        [self setBackgroundImage:[UIImage coloreImage:[UIColor lightGrayColor]] forState:UIControlStateNormal];
        return;
    }
    
    if (![bcimg_c hasPrefix:@"0x"]) {
        bcimg_c = [NSString stringWithFormat:@"0x%@",bcimg_c];
    }
//    unsigned long red = strtoul([bcimg_c UTF8String],0,16);
    [self setBackgroundImage:[UIImage coloreImage:[UIColor lightGrayColor]] forState:UIControlStateNormal];
}

-(UIActivityIndicatorView *)act{
    if (_act == nil) {
        UIActivityIndicatorView *_ = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _.origin = CGPointMake((self.width - 20)/2, (self.height - 20)/2);
        //        _.color = EVGO_Color;
        [self addSubview:_act = _];
    }
    return _act;
}

-(void)loading{
    if (self.currentTitle) {
        _normalStr = self.currentTitle;
    }
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.act startAnimating];
    _normalEnable = self.enabled;
    self.enabled = NO;
}
-(void)stopLing{
    [self setTitle:_normalStr forState:UIControlStateNormal];
    [_act stopAnimating];
    self.enabled = _normalEnable;
}


- (id)initWithFrame:(CGRect)frame imgF:(CGRect)imgf titF:(CGRect)titf{
    self = [super initWithFrame:frame];
    if (self) {
        _imgf = imgf;
        _titf = titf;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

/** 覆盖父类在highlighted时的所有操作 */
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
}

/** 调整内部ImageView的frame */
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imgf;
}

/** 调整内部UILabel的frame */
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectEqualToRect(_titf, CGRectZero)){
        return _titf;
    }
    return contentRect;
}





@end
