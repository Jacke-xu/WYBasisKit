//
//  UINavigationController+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UINavigationController+Extension.h"
#include <objc/runtime.h>

static NSString *const barReturnButtonDelegate = @"barReturnButtonDelegate";

@implementation UINavigationController (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(new_viewDidLoad);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)new_viewDidLoad
{
    [self new_viewDidLoad];
    
    objc_setAssociatedObject(self, [barReturnButtonDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)navigationBarTransparent {
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationBar.translucent = YES;
}

- (void)navigationBarOpaque {
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
}

- (UIColor *)titleColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(titleColor));
    
    return obj;
}
- (void)setTitleColor:(UIColor *)titleColor {
    
    objc_setAssociatedObject(self, &@selector(titleColor), titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : (titleColor ? titleColor : [UIColor blackColor]),
                                                 NSFontAttributeName : (self.titleFont ? self.titleFont : [UIFont fontWithName:@"Helvetica-Bold" size:17])}];
}

- (UIFont *)titleFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(titleFont));
    
    return obj;
}
- (void)setTitleFont:(UIFont *)titleFont {
    
    objc_setAssociatedObject(self, &@selector(titleFont), titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : (self.titleColor ? self.titleColor : [UIColor blackColor]),
                                                 NSFontAttributeName : (titleFont ? titleFont : [UIFont fontWithName:@"Helvetica-Bold" size:17])}];
}

- (UIColor *)barBackgroundColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(barBackgroundColor));
    
    return obj;
}
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    
    objc_setAssociatedObject(self, &@selector(barBackgroundColor), barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationBar setBackgroundImage:[UIImage createImage:barBackgroundColor] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)barBackgroundImage {
    
    UIImage *obj = objc_getAssociatedObject(self, &@selector(barBackgroundImage));
    
    return obj;
}

- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {

    objc_setAssociatedObject(self, &@selector(barBackgroundImage), barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)hidesNavigationBarsOnSwipe {
    
    self.hidesBarsOnSwipe = YES;
}

- (UIImage *)barReturnButtonImage {
    
    UIImage *obj = objc_getAssociatedObject(self, &@selector(barReturnButtonImage));
    
    return obj;
}

- (void)setBarReturnButtonImage:(UIImage *)barReturnButtonImage {
    
    objc_setAssociatedObject(self, &@selector(barReturnButtonImage), barReturnButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.navigationBar.backIndicatorTransitionMaskImage = barReturnButtonImage;
    self.navigationBar.backIndicatorImage = barReturnButtonImage;
}

- (UIColor *)barReturnButtonColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(barReturnButtonColor));
    
    return obj;
}

- (void)setBarReturnButtonColor:(UIColor *)barReturnButtonColor {
    
    objc_setAssociatedObject(self, &@selector(barReturnButtonColor), barReturnButtonColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationBar setTintColor:barReturnButtonColor];
}

- (void)barReturnButtonHide:(BOOL)hide navigationItem:(UINavigationItem *)navigationItem {
    
    navigationItem.hidesBackButton = hide;
}

- (void)pushControllerBarReturnButtonTitle:(NSString *)barReturnButtonTitle navigationItem:(UINavigationItem *)navigationItem {
    
    if(navigationItem.backBarButtonItem == nil) {
        
        navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:barReturnButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    }else {
        
        navigationItem.backBarButtonItem.title = barReturnButtonTitle;
    }
}

#pragma mark - 按钮
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationBarWillReturn)]) {
        shouldPop = [vc navigationBarWillReturn];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

#pragma mark - 手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if([vc respondsToSelector:@selector(navigationBarWillReturn)]) {
            return [vc navigationBarWillReturn];
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [barReturnButtonDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

@end
