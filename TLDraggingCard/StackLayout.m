//
//  StackLayout.m
//  TLDraggingCard
//
//  Created by pacino on 16/2/26.
//  Copyright © 2016年 pacino. All rights reserved.
//

#import "StackLayout.h"

@implementation StackLayout
-(void)prepareLayout {
    _attributesArray = [NSMutableArray array];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
        UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y + 32 - i * 40);
        attributes.size = CGSizeMake(300,400);
        _minScale = 0.65;
        CGFloat scale = _minScale +  (i * ((1 - _minScale))/([self.collectionView numberOfItemsInSection:0] - 1));
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DScale(t, scale ,scale,1);
        t.m34 = -1/50;
        attributes.transform3D = t;
        [_attributesArray addObject:attributes];
    }
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _attributesArray[indexPath.row];
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesArray;
}
-(CGSize)collectionViewContentSize  {
    return self.collectionView.frame.size;
}
@end
