//
//  UIView+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UIView+WY_Extension.h"
#include <objc/runtime.h>

#import "MacroDefinition.h"
#import "UIFont+WY_Extension.h"
#import "UIColor+WY_Extension.h"

#import "UITextView+WY_Extension.h"

@interface UIView ()

@property (nonatomic, weak) UIView *wy_mainView;

@property (nonatomic, assign) CGRect wy_mainViewFrame;

@end

@implementation UIView (WY_Extension)

- (CGFloat)wy_width {return self.frame.size.width;}
- (void)setWy_width:(CGFloat)wy_width {
    
    CGRect frame = self.frame;
    frame.size.width = wy_width;
    self.frame = frame;
}

- (CGFloat)wy_height {return self.frame.size.height;}
- (void)setWy_height:(CGFloat)wy_height {
    
    CGRect frame = self.frame;
    frame.size.height = wy_height;
    self.frame = frame;
}

- (CGFloat)wy_left {return self.frame.origin.x;}
- (void)setWy_left:(CGFloat)wy_left {
    
    CGRect frame = self.frame;
    frame.origin.x = wy_left;
    self.frame = frame;
}

- (CGFloat)wy_top {return self.frame.origin.y;}
- (void)setWy_top:(CGFloat)wy_top {
    
    CGRect frame = self.frame;
    frame.origin.y = wy_top;
    self.frame = frame;
}

- (CGFloat)wy_right {return self.frame.origin.x+self.frame.size.width;}
- (void)setWy_right:(CGFloat)wy_right {
    
    CGRect frame = self.frame;
    frame.origin.x = wy_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)wy_bottom {return self.frame.origin.y+self.frame.size.height;};
- (void)setWy_bottom:(CGFloat)wy_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = wy_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)wy_centerx {return self.center.x;}
- (void)setWy_centerx:(CGFloat)wy_centerx {
    
    self.center = CGPointMake(wy_centerx, self.center.y);
}

- (CGFloat)wy_centery {return self.center.y;}
- (void)setWy_centery:(CGFloat)wy_centery {
    
    self.center = CGPointMake(self.center.x, wy_centery);
}

- (CGPoint)wy_origin {return self.frame.origin;}
- (void)setWy_origin:(CGPoint)wy_origin {
    
    CGRect frame = self.frame;
    frame.origin = wy_origin;
    self.frame = frame;
}

- (CGSize)wy_size {return self.frame.size;}
- (void)setWy_size:(CGSize)wy_size {
    
    CGRect frame = self.frame;
    frame.size = wy_size;
    self.frame = frame;
}

- (UIViewController *)wy_belongsViewController {
    
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)wy_currentViewController {
    
    return [self wy_getCurrentViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
}

//递归查找
- (UIViewController *)wy_getCurrentViewController:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *nav = ((UITabBarController *)controller).selectedViewController;
        return [nav.viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        
        return [((UINavigationController *)controller).viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UIViewController class]]) {
        
        return controller;
    }
    else {
        
        return nil;
    }
}

+ (UIView *)wy_createViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor  = color;
    
    return view;
}

- (void)wy_addGestureAction:(id)target selector:(SEL)selector {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)wy_automaticFollowKeyboard:(UIView *)mainView {
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wy_showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wy_hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    self.wy_mainView = mainView;
    self.wy_mainViewFrame = mainView.frame;
}

- (void)setWy_mainView:(UIView *)wy_mainView {
    
    objc_setAssociatedObject(self, &@selector(wy_mainView), wy_mainView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)wy_mainView {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_mainView));
    return obj;
}

- (void)setWy_mainViewFrame:(CGRect)wy_mainViewFrame {
    
    objc_setAssociatedObject(self, &@selector(wy_mainViewFrame), [NSValue valueWithCGRect:wy_mainViewFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)wy_mainViewFrame {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_mainViewFrame));
    return [obj CGRectValue];
}

- (void)wy_showKeyboard:(NSNotification *)noti {
    
    if(self.isFirstResponder == YES) {
        
        //键盘出现后的位置
        CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        //键盘弹起时的动画效果
        UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
        //键盘动画时长
        NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        
        CGFloat bottom = [self.superview convertPoint:self.frame.origin toView:self.wy_mainView].y+self.frame.size.height;
        
        ///如果self是UITextView，则需判断是否显示了右下角提示文本，如显示，则需要加上提示文本的高度25
        if([self isKindOfClass:[UITextView class]]) {
            
            UITextView *textView = (UITextView *)self;
            if(textView.wy_characterLengthPrompt == YES) {
                
                bottom = bottom+25;
            }
        }
        CGFloat extraHeight = [self wy_hasSystemNavigationBarExtraHeight];
        
        __weak typeof(self) textFieldSelf = self;
        if((bottom+extraHeight) > keyboardFrame.origin.y) {
            
            [UIView animateWithDuration:duration delay:0 options:option animations:^{
                
                textFieldSelf.wy_mainView.wy_top = -(bottom-keyboardFrame.origin.y);
                
            } completion:^(BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //为了显示动画
                    [textFieldSelf layoutIfNeeded];
                });
            }];
        }
    }
}

- (void)wy_hideKeyboard:(NSNotification *)noti {
    
    UIViewAnimationOptions option= [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    __weak typeof(self) textFieldSelf = self;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        CGFloat extraHeight = [textFieldSelf wy_hasSystemNavigationBarExtraHeight];
        textFieldSelf.wy_mainView.wy_top = textFieldSelf.wy_mainViewFrame.origin.y+extraHeight;
        
    } completion:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //为了显示动画
            [textFieldSelf layoutIfNeeded];
        });
    }];
}

//计算键盘弹出时的额外高度
- (CGFloat)wy_hasSystemNavigationBarExtraHeight {
    
    //相对于导航栏高度开始的 如果设置了导航栏的translucent = YES这时在添加子视图的坐标原点相对屏幕坐标是(0,0).如果设置了translucent = NO这时添加子视图的坐标原点相对屏幕坐标就是(0, navViewHeight)
    if(([self wy_belongsViewController].navigationController != nil) && ([self wy_belongsViewController].navigationController.navigationBar.hidden == NO) && ([self wy_belongsViewController].navigationController.navigationBar.translucent == NO)) {
        
        //判断是否隐藏的电池条
        if([UIApplication sharedApplication].statusBarHidden == NO) {
            
            return [[UIApplication sharedApplication] statusBarFrame].size.height+[self wy_belongsViewController].navigationController.navigationBar.frame.size.height;
            
        }else {
            
            return [self wy_belongsViewController].navigationController.navigationBar.frame.size.height;
        }
    }
    //相对于零点开始的
    return 0.0;
}

- (void)wy_gestureHidingkeyboard {
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wy_keyboardHide)];
    gesture.numberOfTapsRequired = 1;
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
}

- (void)wy_keyboardHide {
    
    [self endEditing:YES];
}

- (void)wy_releaseKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
