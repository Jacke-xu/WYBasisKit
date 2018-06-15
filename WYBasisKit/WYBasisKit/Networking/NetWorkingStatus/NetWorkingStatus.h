//
//  NetWorkingStatus.h
//  WYBasisKit
//
//  Created by Jacke-xu on 16/11/30.
//  Copyright © 2016年 Jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    noNetwork = 0,//没有网络
    wifi,//wifi
    wwan//蜂窝网络
} networkStatus;

@interface NetWorkingStatus : NSObject

+ (networkStatus)internetStatus;

@end
