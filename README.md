# WYBasisKit

## Installation
Directly clone "WYBasisKit" to the project, and introduce "GlobalHeader.pch" in the place where it is used (add pod support later)

## What does "WYBasisKit" do?

"WYBasisKit" includes not only AFNetworking, MJRefresh and SDWebImage, but also method encapsulation based on these network frameworks and some common methods encapsulation and expansion based on system frameworks. With it, you can build engineering frameworks quickly. .

## If you think it's cool,Please give me a little star. (如果你也觉得很酷😎，就点一下Star吧(●ˇ∀ˇ●))

### "WYBasisKit" Introduction to tools

![image](https://github.com/Jacke-xu/WYBasisKit/blob/master/GitResource/directory.jpg)

### NSMutableAttributedString+Extension  && UILabel+RichText
```
NSMutableAttributedString+Extension
1.可以快速创建富文本属性，已有的直接就直接返回；
2.可以通过属性快速设置标签不同位置处文本的颜色和字号大小；
3.可以快速设置标签的行间距、字间距、添加下划线等等。

UILabel+RichText
1.可以通过代理或block设置标签的点击事件
2.可以设置要点击字符串的点击效果和点击效果颜色
```
```
使用方式(NSMutableAttributedString+Extension)
//快速创建富文本属性
NSMutableAttributedString *attribute = [NSMutableAttributedString attributeWithStr:lab.text];
//设置行间距
[attribute setLineSpacing:5 string:lab.text];
//设置字间距
[attribute setWordsSpacing:20 string:@"然后中和之化应"];
//通过传入要设置的文本设置文本颜色
NSArray *colorsOfRanges = @[@{[UIColor orangeColor]:@"治性之道"},@{[UIColor greenColor]:@"盖聪明疏通者戒于太察"}];
[attribute colorsOfRanges:colorsOfRanges];
//通过传入要设置的文本和传入要设置文本的下标位置综合设置文本字号
NSArray *fontsOfRanges = @[@{[UIFont systemFontOfSize:18]:@"广心浩大者戒于遗忘"},@{[UIFont boldSystemFontOfSize:30]:@[@"1",@"2"]}];
[attribute fontsOfRanges:fontsOfRanges];
//设置标签的富文本为自定义的富文本属性
lab.attributedText = attribute;

使用方式(UILabel+RichText)
//通过代理设置要点击的字符串
[label clickRichTextWithStrings:@[@"点我",@"点我"] delegate:self];
//通过block设置要点击的字符串
[label clickRichTextWithStrings:@[@"https://github.com/Jacke-xu/WYBasisKit",@"记得给star哦"] clickAction:^(NSString *string, NSRange range, NSInteger index) {
NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
NSLog(@"messge = %@",message);
}];
```
![image](https://github.com/Jacke-xu/WYBasisKit/blob/master/GitResource/UILable.gif)


### UITextView+Extension  && UITextField+Extension
```
1.可以快速设置占位文本及占位文本颜色
2.可以添加文字输入限制，省去自己写代理截取字符串的麻烦
3.处理系统输入法导致的乱码
```
```
//快速创建富文本属性
textView.placeholderStr = @"在这里设置textView的占位文本";
//让弹窗自动跟随键盘移动😎
[textView automaticFollowKeyboard:self.view];
//设置最大输入文本限制,就是这么简单
textView.maximumLimit = 10;
```
![image](https://github.com/Jacke-xu/WYBasisKit/blob/master/GitResource/UITextField.gif) ![image](https://github.com/Jacke-xu/WYBasisKit/blob/master/GitResource/UITextView.gif)


详细README后续补全



如您在使用过程中发现BUG,或有好的意见或建议，可发邮件至mobileAppDvlp@icloud.com
