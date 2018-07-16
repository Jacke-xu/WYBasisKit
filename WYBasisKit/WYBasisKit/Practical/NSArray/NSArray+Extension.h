//
//  NSArray+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/** 按照字母排序 */
+ (NSArray *)sortFromArray:(NSArray *)array;

/** 数字按照升序排序 */
+ (NSArray *)sortAscendingNumFromArray:(NSArray *)array;

/** 数字按照降序排序 */
+ (NSArray *)sortDescendingNumFromArray:(NSArray *)array;

@end
