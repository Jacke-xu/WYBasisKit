//
//  UIView+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UIView+Extension.h"
#include <objc/runtime.h>

#import "MacroDefinition.h"
#import "UIFont+Extension.h"
#import "UIColor+Extension.h"

@interface UIView ()

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, assign) CGRect mainViewFrame;

@end

@implementation UIView (Extension)

- (CGFloat)width {return self.frame.size.width;}
- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {return self.frame.size.height;}
- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)left {return self.frame.origin.x;}
- (void)setLeft:(CGFloat)left {
    
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top {return self.frame.origin.y;}
- (void)setTop:(CGFloat)top {
    
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right {return self.frame.origin.x+self.frame.size.width;}
- (void)setRight:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {return self.frame.origin.y+self.frame.size.height;};
- (void)setBottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerx {return self.center.x;}
- (void)setCenterx:(CGFloat)centerx {
    
    self.center = CGPointMake(centerx, self.center.y);
}

- (CGFloat)centery {return self.center.y;}
- (void)setCentery:(CGFloat)centery {
    
    self.center = CGPointMake(self.center.x, centery);
}

- (CGPoint)origin {return self.frame.origin;}
- (void)setOrigin:(CGPoint)origin {
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {return self.frame.size;}
- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIViewController *)belongsViewController {
    
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (UIView *)createViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor  = color;
    
    return view;
}

+ (UIView *)createNavWithTitle:(NSString *)title {
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, navViewHeight)];
    navView.backgroundColor = RGB(24, 223, 140);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2-100, statusBarHeight, 200, navBarHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont adjustFont:pxFont(34)];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    if(titleLabel.frame.size.width > 200) {
        
        titleLabel.frame = CGRectMake(screenWidth/2-100, statusBarHeight, 200, navBarHeight);
        
    }else {
        
        titleLabel.frame = CGRectMake((screenWidth-titleLabel.frame.size.width)/2, statusBarHeight, titleLabel.frame.size.width, navBarHeight);
    }
    [navView.layer addSublayer:[self drawLawyerWithFrame:CGRectMake(0, navViewHeight-1, screenWidth, 0.5)]];
    [navView addSubview:titleLabel];
    
    return navView;
}

+ (UIView *)createNavWithTitle:(NSString *)title lableAction:(void (^)(UILabel *))action {
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, navViewHeight)];
    navView.backgroundColor = RGB(24, 223, 140);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2-100, statusBarHeight, 200, navBarHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];;
    titleLabel.font = [UIFont adjustFont:pxFont(34)];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    if(titleLabel.frame.size.width > 200) {
        
        titleLabel.frame = CGRectMake(screenWidth/2-100, statusBarHeight, 200, navBarHeight);
        
    }else {
        
        titleLabel.frame = CGRectMake((screenWidth-titleLabel.frame.size.width)/2, statusBarHeight, titleLabel.frame.size.width, navBarHeight);
    }
    //[navView.layer addSublayer:[self drawLawyerWithFrame:CGRectMake(0, navViewHeight-1, screenWidth, 0.5)]];
    [navView addSubview:titleLabel];
    
    
    if(action) {
        
        action(titleLabel);
    }
    
    return navView;
}

+ (UIView *)createBackNavWithTitle:(NSString *)title target:(id)target selector:(SEL)selector {
    
    UIView *navView = [self createNavWithTitle:title];
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(0, statusBarHeight, 40, navBarHeight);
    [navBtn setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateNormal];
    [navBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:navBtn];
    
    return navView;
}

+ (UIView *)createBackNavWithTitle:(NSString *)title lableAction:(void (^)(UILabel *))action target:(id)target selector:(SEL)selector {
    
    UIView *navView = [self createNavWithTitle:title lableAction:action];
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(0, statusBarHeight, 40, navBarHeight);
    [navBtn setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateNormal];
    [navBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:navBtn];
    
    return navView;
}

+ (CALayer *)drawLawyerWithFrame:(CGRect)frame {
    
    CALayer *calawyer = [[CALayer alloc]init];
    calawyer.frame = frame;
    calawyer.backgroundColor = hexColor(@"cccccc").CGColor;
    
    return calawyer;
}

- (void)addGestureAction:(id)target selector:(SEL)selector {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)automaticFollowKeyboard:(UIView *)mainView {
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    self.mainView = mainView;
    self.mainViewFrame = mainView.frame;
}

- (void)setMainView:(UIView *)mainView {
    
    objc_setAssociatedObject(self, &@selector(mainView), mainView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)mainView {
    
    id obj = objc_getAssociatedObject(self, &@selector(mainView));
    return obj;
}

- (void)setMainViewFrame:(CGRect)mainViewFrame {
    
    objc_setAssociatedObject(self, &@selector(mainViewFrame), [NSValue valueWithCGRect:mainViewFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)mainViewFrame {
    
    id obj = objc_getAssociatedObject(self, &@selector(mainViewFrame));
    return [obj CGRectValue];
}

- (void)showKeyboard:(NSNotification *)noti {
    
    if(self.isFirstResponder == YES) {
        
        //键盘出现后的位置
        CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        //键盘弹起时的动画效果
        UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
        //键盘动画时长
        NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        
        CGFloat bottom = [self.superview convertPoint:self.frame.origin toView:self.mainView].y+self.frame.size.height;
        
        if(bottom > keyboardFrame.origin.y) {
            
            __weak typeof(self) textFieldSelf = self;
            [UIView animateWithDuration:duration delay:0 options:option animations:^{
                
                textFieldSelf.mainView.frame = CGRectMake(textFieldSelf.mainView.frame.origin.x, -(bottom-keyboardFrame.origin.y), textFieldSelf.mainView.frame.size.width, textFieldSelf.mainView.frame.size.height);
                
            } completion:nil];
            
            [self layoutIfNeeded];
        }
    }
}

- (void)hideKeyboard:(NSNotification *)noti {
    
    UIViewAnimationOptions option= [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    __weak typeof(self) textFieldSelf = self;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        textFieldSelf.mainView.frame = textFieldSelf.mainViewFrame;
        
    } completion:nil];
    //为了显示动画
    [self layoutIfNeeded];
}

- (void)gestureHidingkeyboard {
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    tableViewGesture.numberOfTapsRequired = 1;
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tableViewGesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tableViewGesture];
}

- (void)keyboardHide {
    
    [self endEditing:YES];
}

- (void)releaseKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
