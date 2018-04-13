//
//  CustomAlertView.h
//  ChuXing
//
//  Created by dingyi on 2017/10/9.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertResult)(NSInteger index);
typedef void(^AlertResult2)(NSString* date);
typedef void(^AlertResult3)(NSString* str);
@interface CustomAlertView : UIView
@property (nonatomic,copy) AlertResult resultIndex;
@property (nonatomic,copy) AlertResult2 resultDate;
@property (nonatomic,copy) AlertResult3 resultStr;
@property (nonatomic,strong)UIImageView* img;
@property (nonatomic,strong)NSMutableString* textInput;
@property (nonatomic,strong)NSArray* emojiAry;

- (instancetype)initWithDateBlock:(void (^)(NSString* date))completion;
- (instancetype)initWithEmoji:(NSArray*)emojiAry;
- (instancetype)initWithVedio:(NSURL*)url;
- (instancetype)initWithImages:(NSArray*)ary Index:(NSInteger)tag;
- (instancetype)initWithAry:(NSArray*)ary;
- (instancetype)initWithTitle:(NSString*)title Text:(NSString*)text AndType:(NSInteger)type;
- (void)showAlertView;
@end
