//
//  UITextField+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UITextField+Extension.h"
#include <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

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
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setMaximumLimit:(NSInteger)maximumLimit {
    
    objc_setAssociatedObject(self, @selector(maximumLimit), @(maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    
    [self addTextChangeNoti];
}

- (NSInteger)maximumLimit {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, @selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    return objc_getAssociatedObject(self, @selector(textHandle));
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    
    return [NSString emptyStr:objc_getAssociatedObject(self, _cmd)];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    [self characterTruncation];
}

- (void)textDidChange:(void (^)(NSString *))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

- (void)fixMessyDisplay {
    
    if(self.maximumLimit <= 0) {self.maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
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
    if(self.maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.maximumLimit];
            }
        }
    }
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
    
    return self.text;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}

@end
