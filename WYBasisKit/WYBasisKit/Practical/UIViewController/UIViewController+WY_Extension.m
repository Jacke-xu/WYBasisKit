//
//  UIViewController+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UIViewController+WY_Extension.h"

@implementation UIViewController (WY_Extension)

- (UIViewController *)wy_findViewController:(NSString *)className {
    
    if([NSString wy_emptyStr:className].length <= 0) return nil;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return nil;
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if([controller isKindOfClass:class]) {
            
            return controller;
        }
    }
    return nil;
}

- (void)wy_deleteViewController:(NSString *)className complete:(void (^)(void))complete {
    
    if([NSString wy_emptyStr:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    __kindof NSMutableArray<UIViewController *> *controllers = [self.navigationController.viewControllers mutableCopy];
    
    for (UIViewController *vc in controllers) {
        
        if ([vc isKindOfClass:class]) {
            
            [controllers removeObject:vc];
            
            self.navigationController.viewControllers = [controllers copy];
            
            if(complete) {
                
                complete();
            }
            
            return;
        }
    }
}

- (void)wy_pushViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString wy_emptyStr:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    UIViewController *viewController = [[class alloc]init];
    
    if(viewController == nil) return;
    
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)wy_pushOnlyViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString wy_emptyStr:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    weakSelf(self);
    [self wy_deleteViewController:className complete:^{
        
        UIViewController *viewController = [[class alloc]init];
        
        if(viewController == nil) return;
        
        [weakself.navigationController pushViewController:viewController animated:animated];
    }];
}

- (void)wy_popViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString wy_emptyStr:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    __kindof NSArray<UIViewController *> *controllers = self.navigationController.viewControllers;
    
    for (UIViewController *vc in controllers) {
        
        if ([vc isKindOfClass:class]) {
            
            [self.navigationController popToViewController:vc animated:animated];
            
            return;
        }
    }
}

@end
