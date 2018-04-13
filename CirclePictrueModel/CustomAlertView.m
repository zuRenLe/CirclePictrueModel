//
//  CustomAlertView.m
//  ChuXing
//
//  Created by dingyi on 2017/10/9.
//  Copyright © 2017年 Dingyi. All rights reserved.
//

#import "CustomAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import "EmTextAttachment.h"
#import "EBUtility.h"
#import "View+MASAdditions.h"
#import "NSAttributedString+NSAttributedString_Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Extension.h"
#import "UIView+EXtension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface CustomAlertView()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,retain) UIView *alertView;
@property (nonatomic,strong) UIDatePicker *picker;
@property (nonatomic,strong) AVPlayer* player;
@property (nonatomic,strong) UITextView* tv;
@property (nonatomic,strong) UIScrollView* scroll;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSArray* dataAry;
@end

@implementation CustomAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithEmoji:(NSArray*)emojiAry{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        self.emojiAry = emojiAry;
        UIButton* alphaBtn = [EBUtility btnfrome:[UIScreen mainScreen].bounds andText:@"" andColor:[UIColor clearColor] andimg:nil andView:self];
        [alphaBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.alertView];
        
        self.alertView.layer.cornerRadius = 10;
        self.alertView.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 300 - 180, [UIScreen mainScreen].bounds.size.width - 40, 180);
        UITextView* tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, self.alertView.frame.size.width - 40, self.alertView.frame.size.height - 70)];
        tv.layer.borderWidth = 1;
        tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tv.delegate = self;
        self.tv = tv;
        [self.alertView addSubview:tv];
        [tv becomeFirstResponder];
        UIButton* commmit = [EBUtility btnfrome:CGRectMake(tv.frame.size.width - 60, tv.frame.size.height - 40, 50, 30) andText:@"提 交" andColor:[UIColor blackColor] andimg:nil andView:tv];
        commmit.tag = 106;
        [commmit addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        for (int i = 0; i < emojiAry.count; i ++){
            UIButton* biaoqing = [[UIButton alloc]initWithFrame:CGRectMake(35 + i * (self.alertView.frame.size.width - 40)/emojiAry.count, 10, 30, 30)];
            [biaoqing setImage:[UIImage imageNamed:emojiAry[i]] forState:UIControlStateNormal];
            biaoqing.tag = i;
            [biaoqing addTarget:self action:@selector(addBiaoQing:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:biaoqing];
        }
    }
     return self;
}
- (instancetype)initWithTitle:(NSString*)title Text:(NSString*)text AndType:(NSInteger)type{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        
        UIButton* alphaBtn = [EBUtility btnfrome:[UIScreen mainScreen].bounds andText:@"" andColor:[UIColor clearColor] andimg:nil andView:self];
        [alphaBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.alertView];
        self.alertView.frame = CGRectMake(0, 0, 250, 150);
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.center = self.center;
        self.alertView.layer.masksToBounds = 1;
        self.alertView.layer.cornerRadius = 10;
        
        UILabel* t = [EBUtility labfrome:CGRectMake(0, 20, 80, 20) andText:title andColor:[UIColor cyanColor] andView:self.alertView];
        t.centerX = self.alertView.width/2;
        t.font = [UIFont systemFontOfSize:20];
        [t sizeToFit];
        UILabel* c = [EBUtility labfrome:CGRectMake(0, 55, self.alertView.width - 40, 20) andText:text andColor:[UIColor blackColor] andView:self.alertView];
        c.numberOfLines = 0;
        c.font = [UIFont systemFontOfSize:14];
        [c sizeToFit];
        c.centerX = self.alertView.width/2;
        
        if (type == 0){
            
            UIButton* b = [EBUtility btnfrome:CGRectMake(0, 110, 80, 25) andText:@"确定" andColor:[UIColor whiteColor] andimg:nil andView:self.alertView];
            b.backgroundColor = [UIColor cyanColor];
            b.layer.cornerRadius = 12;
            b.layer.masksToBounds = YES;
            b.titleLabel.font = [UIFont systemFontOfSize:14];
            [b addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            b.centerX = self.alertView.width/2;
        }else if (type == 1){
            UIButton* b1 = [EBUtility btnfrome:CGRectMake(0, 110, 70, 25) andText:@"确定" andColor:[UIColor whiteColor] andimg:nil andView:self.alertView];
            b1.backgroundColor = [UIColor cyanColor];
            b1.layer.cornerRadius = 12;
            b1.layer.masksToBounds = YES;
            b1.titleLabel.font = [UIFont systemFontOfSize:14];
            [b1 addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            b1.centerX = self.alertView.width/2 - 50;
            UIButton* b2 = [EBUtility btnfrome:CGRectMake(0, 110, 70, 25) andText:@"取消" andColor:[UIColor whiteColor] andimg:nil andView:self.alertView];
            b2.backgroundColor = [UIColor lightGrayColor];
            b2.layer.cornerRadius = 12;
            b2.layer.masksToBounds = YES;
            b2.titleLabel.font = [UIFont systemFontOfSize:14];
            b2.tag = 1;
            [b2 addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
            b2.centerX = self.alertView.width/2 + 50;
        }
    }
    return self;
}

- (instancetype)initWithDateBlock:(void (^)(NSString* date))completion{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        self.resultDate = completion;
        
        UIButton* alphaBtn = [EBUtility btnfrome:[UIScreen mainScreen].bounds andText:@"" andColor:[UIColor clearColor] andimg:nil andView:self];
        [alphaBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.alertView];
        
        self.alertView.frame = CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300);
        self.alertView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIButton* s = [EBUtility btnfrome:CGRectZero andText:@"完成" andColor:[UIColor blackColor] andimg:nil andView:self.alertView];
        [s addTarget:self action:@selector(datepick:) forControlEvents:UIControlEventTouchUpInside];
        UIDatePicker* picker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.picker = picker;
        [self.alertView addSubview:picker];
        
        [s mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.alertView.mas_right);
            make.top.equalTo(self.alertView.mas_top);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.alertView.mas_right);
            make.top.equalTo(s.mas_bottom);
            make.bottom.equalTo(self.alertView.mas_bottom);
            make.left.equalTo(self.alertView.mas_left);
        }];

        
    }
    return self;
}
//播放视频
- (instancetype)initWithVedio:(NSURL*)url{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIButton* alphaBtn = [EBUtility btnfrome:[UIScreen mainScreen].bounds andText:@"" andColor:[UIColor clearColor] andimg:nil andView:self];
        [alphaBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];

        AVPlayer* player = [AVPlayer playerWithURL:url];
        self.player = player;
        AVPlayerLayer* playLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playLayer.frame = self.frame;
        self.alertView = [EBUtility viewfrome:self.frame andColor:nil andView:self];
        
        [self.alertView.layer addSublayer:playLayer];

        [player play];
        [self bringSubviewToFront:alphaBtn];
    }
    return self;
}
//点击图片
- (instancetype)initWithImages:(NSArray*)ary Index:(NSInteger)tag{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        for (int i = 0; i < ary.count; i++){
            UIImageView* iv = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i + 2, 0, SCREEN_WIDTH - 2, SCREEN_HEIGHT)];
            iv.tag = i;
            iv.contentMode = UIViewContentModeScaleAspectFit;
            [iv sd_setImageWithURL:[NSURL URLWithString:ary[i]]];
            [self.scroll addSubview:iv];
        }
        self.scroll.backgroundColor = [UIColor blackColor];
        self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH * ary.count, 0);
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.pagingEnabled = YES;
        self.scroll.contentOffset = CGPointMake(SCREEN_WIDTH * tag, 0);
        self.scroll.delegate = self;
        [self addSubview:self.scroll];
        
        UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
        PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
        
        [self addGestureRecognizer:PrivateLetterTap];
        
        UIPinchGestureRecognizer * enlarge =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImg:)];
        
        [self.scroll addGestureRecognizer:enlarge];
    }
    return self;
}

//table
- (instancetype)initWithAry:(NSArray*)ary{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;

        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        
        UIButton* alphaBtn = [EBUtility btnfrome:[UIScreen mainScreen].bounds andText:@"" andColor:[UIColor clearColor] andimg:nil andView:self];
        [alphaBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.alertView];
        
        self.alertView.layer.cornerRadius = 10;
        self.alertView.frame = CGRectMake(30, 60, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 110);
        self.alertView.layer.position = self.center;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 150) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor clearColor];
        self.tableView.tableFooterView = v;
        [self.alertView addSubview:self.tableView];
        
        self.dataAry = ary;
    }
    return self;
}
-(void)clickImageView:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
- (void)addBiaoQing:(UIButton*)sender{

    EmTextAttachment *emojiTextAttachment = [EmTextAttachment new];
    
    //保存表情标志
    emojiTextAttachment.textTag = [NSString stringWithFormat:@"[em_%ld]",sender.tag];
    emojiTextAttachment.bounds = CGRectMake(0, 0, 16, 16);
    //设置表情图片
    emojiTextAttachment.image = [UIImage imageNamed:self.emojiAry[sender.tag]];
    
    //插入表情
    [self.tv.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment] atIndex:self.tv.selectedRange.location];
    self.tv.selectedRange = NSMakeRange(self.tv.selectedRange.location + 1, self.tv.selectedRange.length);
}


- (void)datepick:(UIButton*)sender{
    if (self.resultDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.resultDate([dateFormatter stringFromDate:self.picker.date]);
    }
    [self removeFromSuperview];
}
- (void)touchBtn:(UIButton*)sender{
    if (sender.tag == 106){
        if (self.resultStr) {
            self.resultStr([self.tv.attributedText getPlainString]);
        }
    }else{
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
    }
    
    [self removeFromSuperview];
}

- (void)remove{
    if (self.player){
        [self.player pause];
    }
    [self removeFromSuperview];
}
- (void)showAlertView{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)enlargeImg:(UIPinchGestureRecognizer*)tap{
    CGFloat scale = tap.scale;
    UIImageView* img = self.scroll.subviews[(int)(self.scroll.contentOffset.x / SCREEN_WIDTH)];
    img.transform = CGAffineTransformScale(img.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    if (img.frame.size.width < SCREEN_WIDTH){
        [UIView animateWithDuration:0.1 animations:^{
            img.frame = CGRectMake(SCREEN_WIDTH * (int)(self.scroll.contentOffset.x / SCREEN_WIDTH) + 2, 0, SCREEN_WIDTH - 2, SCREEN_HEIGHT);
        }];
    }
    tap.scale = 1.0;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UIImageView* img = self.scroll.subviews[(int)(self.scroll.contentOffset.x / SCREEN_WIDTH)];
    [UIView animateWithDuration:0.1 animations:^{
        img.frame = CGRectMake(SCREEN_WIDTH * (int)(self.scroll.contentOffset.x / SCREEN_WIDTH) + 2, 0, SCREEN_WIDTH - 2, SCREEN_HEIGHT);
    }];
    
}

- (void)creatShowAnimation
{
//    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - tableViewDelegate/DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataAry[indexPath.row][@"logo"]]];
    cell.textLabel.text = self.dataAry[indexPath.row][@"title"];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.resultIndex) {
        self.resultIndex(indexPath.row);
    }
     [self removeFromSuperview];
}
@end
