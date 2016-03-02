//
//  CollectionViewBackGroundView.m
//  TLDraggingCard
//
//  Created by pacino on 16/3/2.
//  Copyright © 2016年 pacino. All rights reserved.
//

#import "CollectionViewBackGroundView.h"

@interface CollectionViewBackGroundView()
@property (nonatomic, weak)UIImageView *imageView;
@end

@implementation CollectionViewBackGroundView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        effectView.frame = self.bounds;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:imageView];
        [imageView addSubview:effectView];
        _imageView = imageView;
    }
    return self;
}
-(void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.duration = 0.3f;
    animation.fromValue = _imageView.layer.contents;
    animation.toValue = (__bridge id _Nullable)([UIImage imageNamed:_imageName].CGImage);
    _imageView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:_imageName].CGImage);
    [_imageView.layer addAnimation:animation forKey:@"contents"];
}
@end
