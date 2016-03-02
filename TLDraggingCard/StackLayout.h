//
//  StackLayout.h
//  TLDraggingCard
//
//  Created by pacino on 16/2/26.
//  Copyright © 2016年 pacino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackLayout : UICollectionViewLayout
@property (nonatomic, strong)NSMutableArray *attributesArray;
//最底下一张卡片的Scale
@property (nonatomic, assign)CGFloat minScale;

@end
