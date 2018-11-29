//
//  CardView.m
//  卡片式一
//
//  Created by ZILIANG HA on 2018/11/20.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import "CardView.h"
#import "CardFlowLayout.h"
#import "CardCell.h"
@interface CardView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign)  CGFloat dragEndX;
@end
@implementation CardView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    [self addCollectionView];
}

- (void)addCollectionView
{
    //避免UINavigation对UIScrollView产生的便宜问题
    [self addSubview:[UIView new]];
    
    CardFlowLayout *flowLayout = [[CardFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[CardCell class] forCellWithReuseIdentifier:@"CardCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor orangeColor];
}
#pragma mark CollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CardCell";
    CardCell *card = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    card.item = _items[indexPath.row];
    card.backgroundColor = [UIColor yellowColor];
    return card;
}

@end
