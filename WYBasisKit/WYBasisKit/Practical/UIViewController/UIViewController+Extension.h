//
//  UIViewController+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerHandlerProtocol <NSObject>

@optional

/** 重写下面的方法以拦截导航栏pop事件，返回 YES 则 pop，NO 则不 pop  默认返回上一页 */
- (BOOL)navigationBarWillReturn;

@end

@interface UIViewController (Extension)<ViewControllerHandlerProtocol>

/** 从导航控制器栈中查找ViewController，没有时返回nil */
- (UIViewController *)findViewController:(NSString *)className;

/** 删除指定的视图控制器 */
- (void)deleteViewController:(NSString *)className complete:(void(^)(void))complete;

/** 跳转到指定的视图控制器 */
- (void)pushViewController:(NSString *)className animated:(BOOL)animated;

/** 跳转到指定的视图控制器，此方法可防止循环跳转 */
- (void)preventCirculationPushViewController:(NSString *)className animated:(BOOL)animated;

/** 返回到指定的视图控制器 */
- (void)popViewController:(NSString *)className animated:(BOOL)animated;


@end
