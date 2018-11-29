//
//  CardFlowLayout.m
//  卡片式一
//
//  Created by ZILIANG HA on 2018/11/15.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import "CardFlowLayout.h"
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;
@implementation CardFlowLayout

#pragma mark - 配置方法
//卡片宽度
-(CGFloat)cellWidth
{
    return self.collectionView.bounds.size.width * CardWidthScale;
}
//卡片间距
-(CGFloat)cellMarign
{
    return (self.collectionView.bounds.size.width - [self cellWidth])/7;
}
//section的左右内边距
-(CGFloat)collectionInset
{
    return self.collectionView.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}

/**
 * 预布局方法，所有的布局应该写在这里面
 */
-(void)prepareLayout
{
    //必须写这句话
    [super prepareLayout];
    
    // 1、设置collectionView的滑动方向，水平滑动
    // 与cell的布局有关，cell是列布局
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 2、设置section的内边距
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
    // 3、设置cell的大小
    self.itemSize = CGSizeMake([self cellWidth], self.collectionView.bounds.size.height * CardHeightScale);
    // 4、设置cell之间的间距
    self.minimumLineSpacing = [self cellMarign];
}
/**
 * 此方法返回当前屏幕正在显示的视图(cell 头尾视图)的布局属性集合
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 1、扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    // 2、获取正在显示在扩大范围后的布局属性集合
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:bigRect];
    NSArray *arr = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    // 3、屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    // 4、刷新cell的缩放布局
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        // cell的中心位置和屏幕中心的距离
        CGFloat distance = fabs(attributes.center.x - centerX);
        // cell与屏幕中线的距离(移动的距离) 和 屏幕宽度的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        // 把卡片移动范围固定到[-π/4 π/4]这个范围
        CGFloat scale = fabs(cos(apartScale *M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}
//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}





@end
