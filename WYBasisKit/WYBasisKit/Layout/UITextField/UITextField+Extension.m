//
//  UITextField+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UITextField+Extension.h"

@interface UITextField ()

@property (nonatomic, assign) BOOL addNoti;

@end

@implementation UITextField (Extension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor {
    
    return self.placeholderColor;
}

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, @selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setMaximumLimit:(NSInteger)maximumLimit {
    
    objc_setAssociatedObject(self, @selector(maximumLimit), @(maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    
    [self addTextChangeNoti];
}

- (NSInteger)maximumLimit {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    [self characterTruncation];
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (NSString *)characterTruncation {
    
    //字符截取
    if((self.text.length > self.maximumLimit) && (self.maximumLimit)) {
        
        const char *res = [self.text substringToIndex:self.maximumLimit].UTF8String;
        if (res == NULL) {
            self.text = [self.text substringToIndex:self.maximumLimit - 1];
        }else{
            self.text = [self.text substringToIndex:self.maximumLimit];
        }
    }
    return self.text;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}

@end
