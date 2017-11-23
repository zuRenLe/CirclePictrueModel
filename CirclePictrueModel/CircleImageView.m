//
//  CircleImageView.m
//  ChuXing
//a
//  Created by dingyi on 2017/10/12.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import "CircleImageView.h"
#import "CustomAlertView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Extension.h"
@implementation CircleImageView

-(instancetype)initWithImgAry:(NSArray*)ary Thumbpic:(NSArray*)thumb Type:(NSInteger)type AndSize:(CGSize)frame{
    if ([super initWithFrame:CGRectMake(0, 0, 270,200)]){
        self.userInteractionEnabled = YES;
        
        if (type == 0){
            self.userInteractionEnabled = YES;
            if (ary.count == 1){

                UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgW"]];

                [img sd_setImageWithURL:[NSURL URLWithString:thumb[0]] placeholderImage:[UIImage imageNamed:@"bgW"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                    if (img.image.size.width > 270 || img.image.size.height > 200){
                        if (img.image.size.width >= img.image.size.height){
                            img.image = [self imageCompressForWidth:img.image targetWidth:frame.width];
                            
                        }else{
                            img.image = [self imageCompressForWidth:img.image targetHeight:frame.height];
                            
                        }
                    }

                    img.frame = CGRectMake(0, 0, img.image.size.width, img.image.size.height);
                    self.frame = CGRectMake(0, 0, img.image.size.width, img.image.size.height);
                    if ([self.delegate respondsToSelector:@selector(finishLoadImg)]){
                        [self.delegate finishLoadImg];
                    }

                }];
                img.url = ary;
                img.tag = 0;
                img.contentMode = UIViewContentModeScaleAspectFit;

                self.imgV = img;
                
                [self addSubview:img];
            }else if (ary.count <= 3){
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.frame.origin.x, 70);
                for (int i = 0;i < ary.count; i++) {
                    
                    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(75 * i, 0, 70, 70)];
                    [img sd_setImageWithURL:[NSURL URLWithString:thumb[i]]];
                    img.url = ary;
                    img.tag = i;
                    img.contentMode = UIViewContentModeScaleAspectFill;
                    img.clipsToBounds = YES;

                    [self addSubview:img];
                }
            }else if (ary.count <= 6){
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.frame.origin.x, 70);
                for (int i = 0;i < 2; i++){
                    for (int j = 0;j < 3; j++) {
                        if (ary.count > 3 * i + j){
                            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(75 * j, 75 * i, 70, 70)];
                            [img sd_setImageWithURL:[NSURL URLWithString:thumb[3 * i + j]]];
                            img.url = ary;
//                            img.image = [UIImage imageNamed:ary[3 * i + j]];
                            img.tag = 3 * i + j;
                            img.contentMode = UIViewContentModeScaleAspectFill;
                            img.clipsToBounds = YES;

                            [self addSubview:img];
                        }
                    }
                }
            }else if (ary.count <= 9){
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.frame.origin.x, 70);
                for (int i = 0;i < 3; i++){
                    for (int j = 0;j < 3; j++) {
                        if (ary.count > 3 * i + j){
                            UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(75 * j, 75 * i, 70, 70)];
                            [img sd_setImageWithURL:[NSURL URLWithString:thumb[3 * i + j]]];
                            img.url = ary;
//                            img.image = [UIImage imageNamed:ary[3 * i + j]];
                            img.tag = 3 * i + j;
                            img.contentMode = UIViewContentModeScaleAspectFill;
                            img.clipsToBounds = YES;

                            [self addSubview:img];
                        }
                    }
                }
            }
            
        }else{
            UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgW"]];

            [img sd_setImageWithURL:[NSURL URLWithString:thumb[0]] placeholderImage:[UIImage imageNamed:@"bgW"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (img.image.size.width > 270 || img.image.size.height > 200){
                    if (img.image.size.width >= img.image.size.height){
                        img.image = [self imageCompressForWidth:img.image targetWidth:frame.width];
                        
                    }else{
                        img.image = [self imageCompressForWidth:img.image targetHeight:frame.height];
                        
                    }
                }
                self.frame = CGRectMake(0, 0, img.image.size.width, img.image.size.height);
                img.frame = CGRectMake(0, 0, img.image.size.width, img.image.size.height);
                if ([self.delegate respondsToSelector:@selector(finishLoadImg)]){
                    [self.delegate finishLoadImg];
                }

            }];
            img.tag = 0;
            img.contentMode = UIViewContentModeScaleAspectFit;

            self.imgV = img;
            [self addSubview:img];
            
            UIButton* play = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [play setImage:[UIImage imageNamed:@"icon_video"] forState:0];
            play.center = img.center;
            [play addTarget:self action:@selector(pushPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:play];
            
        }
    }
    return self;
}
- (void)pushPlayVideo:(UIButton*)sender{

    CustomAlertView* alert = [[CustomAlertView alloc] initWithVedio:[NSURL URLWithString:self.videoURL]];
    [alert showAlertView];
}


-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = width / ( height / defineHeight);
    CGFloat targetHeight = defineHeight;
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
