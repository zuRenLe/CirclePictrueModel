//
//  CircleTableViewCell.m
//  ChuXing
//
//  Created by dingyi on 2017/10/9.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import "CircleTableViewCell.h"
#import "EBUtility.h"
#import "View+MASAdditions.h"
@implementation CircleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initCellWithDic:(NSMutableDictionary*)dic{
    for (UIView* i in self.viewForLastBaselineLayout.subviews){
        
        [i removeFromSuperview];
        
    }
    UIImageView* photo = [EBUtility imgfrome:CGRectZero andImg:[UIImage imageNamed:@"ico_head_defualt"] andView:self.viewForLastBaselineLayout];
    photo.layer.masksToBounds = YES;
    photo.layer.cornerRadius = 20;

    
    UIButton* name = [EBUtility btnfrome:CGRectZero andText:@"Name" andColor:[UIColor blueColor] andimg:nil andView:self.viewForLastBaselineLayout];
    name.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    UILabel* date = [EBUtility labfrome:CGRectZero andText:@"2017-11-10" andColor:[UIColor colorWithWhite:0.85 alpha:1] andView:self.viewForLastBaselineLayout];
    date.font = [UIFont systemFontOfSize:13];
    [date sizeToFit];
    
    UILabel* content = [EBUtility labfrome:CGRectZero andText:@"内容" andColor:[UIColor blackColor] andView:self.viewForLastBaselineLayout];
    [content sizeToFit];
    content.textAlignment = 0;
    content.numberOfLines = 0;
    
    CircleImageView* imgView = [[CircleImageView alloc] initWithImgAry:dic[@"bigpic"] Thumbpic:dic[@"thumbpic"] Type:0 AndSize:CGSizeMake(270, 200)];
    self.imgv = imgView;
//    if ([[NSString stringWithFormat:@"%@",dic[@"typeid"]] isEqualToString: @"1"]){
//        imgView = [[CircleImageView alloc] initWithImgAry:dic[@"bigpic"] Thumbpic:dic[@"thumbpic"] Type:1 AndSize:CGSizeMake(270, 200)];
//        imgView.videoURL = dic[@"video"];
//    }

    [self.viewForLastBaselineLayout addSubview:imgView];
    

    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewForLastBaselineLayout.mas_left).offset(20);
        make.top.equalTo(self.viewForLastBaselineLayout.mas_top).offset(25);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];

    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photo.mas_right).offset(10);
        make.top.equalTo(photo.mas_top);
        make.height.equalTo(@30);
    }];
    
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photo.mas_right).offset(10);
        make.top.equalTo(name.mas_bottom).offset(0);
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photo.mas_right).offset(10);
        make.top.equalTo(date.mas_bottom).offset(10);
        make.right.equalTo(self.viewForLastBaselineLayout.mas_right).offset(-20);
    }];
    NSArray* bigpic = dic[@"bigpic"];
    if (bigpic.count == 1) {
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photo.mas_right).offset(10);
            make.top.equalTo(content.mas_bottom).offset(10);
            make.height.equalTo(imgView.imgV.mas_height);
            make.width.equalTo(imgView.imgV.mas_width);
            make.bottom.equalTo(self.viewForLastBaselineLayout.mas_bottom).offset(-20);
        }];
    }else{
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photo.mas_right).offset(10);
            make.top.equalTo(content.mas_bottom).offset(10);
            make.height.equalTo(@(75 *((bigpic.count - 1) /3 + 1)));
            make.width.equalTo(@225);
            make.bottom.equalTo(self.viewForLastBaselineLayout.mas_bottom).offset(-20);
        }];
    }
    
}


@end



