//
//  ViewController.m
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "MainViewController.h"
#import "UITableView+HeightCache.h"
#import "TestTableViewCell.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.dataSource addObjectsFromArray:@[@"喜欢鹿小姐的是杰先生，杰先生是鹿小姐隔壁班的同学，两个人学的同一个专业。遗憾的是，有时候他们一起上大班课，但大学三年的同窗生涯里，他们彼此没有说过一句话。鹿小姐对杰先生最深的印象就是，无论选修课还是必修课，反正老师都会喊到杰先生逃课的名字。",@"从2016年的7月7号开始，鹿小姐将要度过属于自己最珍贵的一个暑假了，也许是她人生里最后一次学生时代的暑假。鹿小姐想让自己最后的一个暑假过的有意义，看着自己的好闺蜜，一个去上海找男朋友风花雪夜了，另一个去到青海做志愿者了。诗和远方都在召唤着她，鹿小姐终于按耐不住了，她决定要走一遭一直心念神往的川藏线。",@"带着仅有的4000块钱，不顾身边亲朋好友的阻挠，提前在网上约了旅友，大家商量好一起从成都出发，开始途搭川藏线。",@"鹿小姐在做攻略的时候看到报道关于一些旅友因为高原反应，导致年轻的生命永远的留在了西藏。鹿小姐既期待自己的旅行，又害怕自己会出现意外，毕竟这是自己第一次去高原上，突然就想到了杰先生，杰",@"鹿小姐一个人从岳阳坐了17个小时的硬座到了成都，然后和自己的旅友会合，这期间一直断断续续的和杰先生保持联系着。在鹿小姐刚开始走到5000多米高的海拔上时，她觉得自己犯恶心头剧痛，而且耳鸣很严重，她心里特别惶恐，她知道这是个不好的预兆。",@"历经十多天的跋山涉水，鹿小姐终于从成都平安到达了拉萨。那天，拉萨的阳光格外的明媚，蔚蓝的天空好像伸手就可以触碰到，空气中弥漫的都是自由的味道。"]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView LLQ_CalculateCellWithIdentifer:@"cell" indexPath:indexPath configuration:^(TestTableViewCell *cell) {
        cell.label.text = self.dataSource[indexPath.row];
        if ((indexPath.row%2) == 0) {
            cell.image.image = [UIImage imageNamed:@"doge@2x.png"];
        }else{
            cell.image.image = [UIImage imageNamed:@"phil.png"];
        }
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.label.text = self.dataSource[indexPath.row];
    if ((indexPath.row%2)==0) {
        cell.image.image = [UIImage imageNamed:@"doge@2x.png"];
    }else{
        cell.image.image = [UIImage imageNamed:@"phil.png"];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
