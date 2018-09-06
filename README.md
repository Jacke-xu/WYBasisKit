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
1.可以快速创建富文本属性，已有的直接就直接返回；
2.可以通过属性快速设置标签不同位置处文本的颜色和字号大小；
3.可以快速设置标签的行间距、字间距、添加下划线等等。
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
```


详细README后续补全



如您在使用过程中发现BUG,或有好的意见或建议，可发邮件至mobileAppDvlp@icloud.com
