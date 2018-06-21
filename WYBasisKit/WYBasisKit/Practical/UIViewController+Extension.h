//
//  UIViewController+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol viewControllerHandlerProtocol <NSObject>

@optional

/** 重写下面的方法以拦截导航栏pop事件，返回 YES 则 pop，NO 则不 pop  默认返回上一页 */
- (BOOL)navigationBarWillReturn;

@end

@interface UIViewController (Extension)<viewControllerHandlerProtocol>

@end
