//
//  UILabel+WT.m
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "UILabel+WT.h"
#import "WTConst.h"

@implementation UILabel (WT)

+ (UILabel *)newSingleFrame:(CGRect)frame title:(NSString *)title fontS:(CGFloat)fonts color:(UIColor *)color {
    UILabel *_ = [[UILabel alloc] initWithFrame:frame];
    _.font = [UIFont systemFontOfSize:fonts];
    if (color) {
        _.textColor = color;
    }
    _.text = title;
    _.numberOfLines = 0;
    return _;
}

/** 有删除线的 */
- (void)delLineStr:(NSString *)string {
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attri];
}

/** 有下划线的 */
- (void)underlineStr:(NSString *)string {
    if (WTStrIsEmpty(string)) return;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attri];
}
@end
