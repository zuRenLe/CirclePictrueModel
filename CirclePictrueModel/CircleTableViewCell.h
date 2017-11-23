//
//  CircleTableViewCell.h
//  ChuXing
//
//  Created by dingyi on 2017/10/9.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"

@interface CircleTableViewCell : UITableViewCell
@property (nonatomic,strong)CircleImageView* imgv;
-(void)initCellWithDic:(NSMutableDictionary*)dic;

@end
