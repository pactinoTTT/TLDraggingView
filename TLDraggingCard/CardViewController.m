//
//  CardViewController.m
//  TLDraggingCard
//
//  Created by pacino on 16/2/26.
//  Copyright © 2016年 pacino. All rights reserved.
//

#import "CardViewController.h"
#import "CardCell.h"
#import "StackLayout.h"
#import "CollectionViewBackGroundView.h"
//获取两点间距离
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};
@interface CardViewController()
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, assign)CGPoint orginPoint;
@property (nonatomic, strong)CardCell *currentCell;
@property (nonatomic, strong)UIPanGestureRecognizer *press;
@property (nonatomic, weak)CollectionViewBackGroundView *backGroundView;
@end
@implementation CardViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    _data = [NSMutableArray array];
    for (int i = 0; i < 4;  i ++) {
        [_data addObject:[NSString stringWithFormat:@"sa%li.jpg",(long)i]];
    }
    _press = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panPress:)];
    [self.collectionView addGestureRecognizer:_press];
    CollectionViewBackGroundView *backGroundView = [[CollectionViewBackGroundView alloc]initWithFrame:self.collectionView.frame];
    self.collectionView.backgroundView = backGroundView;
    _backGroundView = backGroundView;
    backGroundView.imageName = _data.lastObject;
}
-(void)panPress:(UIPanGestureRecognizer *)press {

    switch (press.state) {
        case UIGestureRecognizerStateBegan: {
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            _currentCell.center = CGPointMake([press locationInView:self.collectionView].x, [press locationInView:self.collectionView].y);
            _currentCell.transform = CGAffineTransformMakeRotation(M_PI_2 * ([press locationInView:press.view].x - self.collectionView.center.x)/self.collectionView.frame.size.width * 2);
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (distanceBetweenPoints(_orginPoint, [press locationInView:press.view])/_currentCell.frame.size.width >= 0.2) {
                [self.collectionView sendSubviewToBack:_currentCell];
                [self.collectionView performBatchUpdates:^{
                [_data exchangeObjectAtIndex:_data.count - 1 withObjectAtIndex:0];
                [self.collectionView moveItemAtIndexPath:[self.collectionView indexPathForCell:_currentCell] toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
                } completion:^(BOOL finished) {
                }];
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_data.count - 1 inSection:0];
                CardCell *cell = (CardCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                _currentCell = cell;
                _backGroundView.imageName = _data[indexPath.row];
            }else {
                [UIView animateWithDuration:0.1 animations:^{
                    _currentCell.transform = CGAffineTransformIdentity;
                    _currentCell.center = _orginPoint;
                } completion:^(BOOL finished) {
                    
                }];
            }
            break;
        default:
            break;
    }

    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_data[indexPath.row]];
    if (indexPath.row == _data.count - 1) {
        _orginPoint = cell.center;
        _currentCell = cell;
    }
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[StackLayout alloc]init] animated:YES];
        [self.collectionView addGestureRecognizer:_press];
    }else {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
        [self.collectionView removeGestureRecognizer:_press];
    }

}

@end
