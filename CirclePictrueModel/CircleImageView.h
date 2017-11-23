//
//  CircleImageView.h
//  ChuXing
//
//  Created by dingyi on 2017/10/12.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CircleImageViewDelegate <NSObject>

@optional
- (void)finishLoadImg;
@end
@interface CircleImageView : UIView
@property (nonatomic,strong)NSString* videoURL;
@property (nonatomic,weak)id<CircleImageViewDelegate> delegate;
@property (nonatomic,strong)UIImageView* imgV;

- (instancetype)initWithImgAry:(NSArray*)ary Thumbpic:(NSArray*)ary Type:(NSInteger)type AndSize:(CGSize)frame;
 
@end
