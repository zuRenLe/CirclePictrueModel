//
//  NSAttributedString+NSAttributedString_Extension.m
//  ChuXing
//
//  Created by dingyi on 2017/10/19.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import "NSAttributedString+NSAttributedString_Extension.h"

@implementation NSAttributedString (NSAttributedString_Extension)
- (NSString *)getPlainString {
    
    //最终纯文本
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    
    //替换下标的偏移量
    __block NSUInteger base = 0;
    
    //遍历
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      
                      //检查类型是否是自定义NSTextAttachment类
                      if (value && [value isKindOfClass:[EmTextAttachment class]]) {
                          //替换
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmTextAttachment *) value).textTag];
                          
                          //增加偏移量
                          base += ((EmTextAttachment *) value).textTag.length - 1;
                      }
                  }];
    
    return plainString;
}
@end
