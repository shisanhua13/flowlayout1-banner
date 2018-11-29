//
//  ViewController.m
//  卡片式一
//
//  Created by ZILIANG HA on 2018/11/15.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import "ViewController.h"
#import "CardCell.h"
#import "CardView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据源
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        XLCardItem *item = [[XLCardItem alloc] init];
        [item setValuesForKeysWithDictionary:dic];
        [items addObject:item];
    }
    
    //设置卡片浏览器
    CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 200)];
    cardView.items = items;
    [self.view addSubview:cardView];
    cardView.backgroundColor = [UIColor redColor];
    
}


@end
