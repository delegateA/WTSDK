//
//  LBAnimationView.h
//  LBImageTag
//
//  Created by fhkj on 15/6/17.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSUInteger, LBAnimationType) {
    LBAnimationTypeTriplePulse,
};

@interface LBAnimationView : UIView

- (id)initWithType:(LBAnimationType)type;
- (id)initWithType:(LBAnimationType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(LBAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic) LBAnimationType type;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;

@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;

@end

@protocol LBAnimationDelegate <NSObject>

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end

@interface LBAnimation : NSObject <LBAnimationDelegate>

@end
