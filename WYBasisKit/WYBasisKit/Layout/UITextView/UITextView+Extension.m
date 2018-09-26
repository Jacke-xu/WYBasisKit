//
//  UITextView+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UITextView+Extension.h"
#include <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

@end

@implementation UITextView (Extension)

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, &@selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(addNoti)) boolValue];
    return obj;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr {
    
    objc_setAssociatedObject(self, &@selector(placeholderStr), placeholderStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (NSString *)placeholderStr {
    
    NSString *obj = objc_getAssociatedObject(self, &@selector(placeholderStr));
    return obj;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    objc_setAssociatedObject(self, &@selector(placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    
    objc_setAssociatedObject(self, &@selector(placeholderFont), placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)placeholderFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(placeholderFont));
    return obj;
}

- (UIColor *)placeholderColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(placeholderColor));
    return obj;
}

- (void)setMaximumLimit:(NSInteger)maximumLimit {
    
    objc_setAssociatedObject(self, &@selector(maximumLimit), [NSNumber numberWithInteger:maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (NSInteger)maximumLimit {
    
    id obj = objc_getAssociatedObject(self, &@selector(maximumLimit));
    return [obj integerValue];
}

- (void)setCharacterLengthPrompt:(BOOL)characterLengthPrompt {
    
    objc_setAssociatedObject(self, &@selector(characterLengthPrompt), [NSNumber numberWithBool:characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (BOOL)characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, &@selector(characterLengthPrompt));
    return [obj boolValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, &@selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    id handle = objc_getAssociatedObject(self, &@selector(textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    
    return [NSString emptyStr:objc_getAssociatedObject(self, _cmd)];
}

- (void)textDidChange:(void (^)(NSString *))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

- (void)fixMessyDisplay {
    
    if(self.maximumLimit <= 0) {self.maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    //重绘
    [self characterTruncation];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //设置文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.placeholderFont ? self.placeholderFont : self.font;
    attributes[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width -2 * x;
    
    //画最大字符文本,添加文本显示边界
    if((self.maximumLimit > 0) && (self.characterLengthPrompt == YES)) {
        
        [self setContentInset:UIEdgeInsetsMake(0, 0, 25, 0)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentRight;
        
        NSMutableDictionary *maximumLimitAttributes = [attributes mutableCopy];
        maximumLimitAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
        
        NSString *limitStr = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length > (long)self.maximumLimit ? (long)self.maximumLimit : (unsigned long)self.text.length ,(long)self.maximumLimit];
        
        [limitStr drawInRect:CGRectMake(x, rect.size.height-20+self.contentOffset.y, width, 20) withAttributes:maximumLimitAttributes];
    }
    //如果不需要显示最大字符限制文本，则把边界置为默认
    else {
        
        [self setContentInset:UIEdgeInsetsZero];
    }
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    //画文字
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    [self.placeholderStr drawInRect:placeholderRect withAttributes:attributes];
}

- (void)characterTruncation {
    
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
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}

@end
