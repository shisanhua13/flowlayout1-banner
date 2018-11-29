//
//  CardCell.h
//  卡片式一
//
//  Created by ZILIANG HA on 2018/11/20.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLCardItem;
@interface CardCell : UICollectionViewCell
@property (nonatomic, strong) XLCardItem *item;
@end



@interface XLCardItem : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@end
