//
//  ViewController.m
//  CirclePictrueModel
//
//  Created by y on 2017/11/9.
//  Copyright © 2017年 YHYsTool. All rights reserved.
//

#import "ViewController.h"
#import "CircleImageView.h"
#import "CircleTableViewCell.h"
#import "ScrollTitleView.h"

@interface ViewController ()<CircleImageViewDelegate,UITableViewDelegate,UITableViewDataSource,ScrollTitleViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger oneImgCellNumber;
@property (nonatomic,strong)NSMutableArray* dataAry;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ScrollTitleView* view = [[ScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    [view initCellWithTitles:@[@"标题一",@"标题二",@"标题三",@"标题四"] Tag:0 WithColor:[UIColor redColor]];
    
    view.delegate = self;
    [self.view addSubview:view];
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - 30) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.currentPage = 1;

    //example dataAry
    self.dataAry = [NSMutableArray array];
    for (int i = 1; i < 10; i++) {
        NSMutableArray * a = [NSMutableArray array];
        for (int j = 0; j < i; j++){
            [a addObject:@"http://www.191668.com/xiangui/images/background/1.png"];
        }
        NSMutableDictionary* d = [NSMutableDictionary dictionaryWithObjectsAndKeys:a,@"bigpic",a,@"thumbpic", nil];
        
        [self.dataAry addObject:d];
    }
    [self presentViewController:[[UIViewController alloc]init] animated:1 completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleTableViewCell"];
    if (!cell) {
        cell = [[CircleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CircleTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell initCellWithDic:self.dataAry[indexPath.row]];
    cell.imgv.delegate = self;
    return  cell;
}
-(void)finishLoadImg{
    //这个代理方法是用来通知一共有多少个单张图片cell完成下载图片，当所有图片下载完成时刷新tableview重新计算Cell大小,其实只有当前页面第一次加载时才需要到
    if (self.currentPage == 1){
        NSInteger num = 0;
        for (NSDictionary* i in self.dataAry){
            NSArray *j = i[@"thumbpic"];
            if (j.count == 1){
                num ++ ;
            }
        }
        self.oneImgCellNumber ++;
        if (self.oneImgCellNumber >= num){
            [self.tableView reloadData];

        }
    }
}
-(void)touchTitle:(NSInteger)tag{
    
}
@end
