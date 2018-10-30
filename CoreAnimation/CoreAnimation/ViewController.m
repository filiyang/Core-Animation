//
//  ViewController.m
//  CoreAnimation
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 Filiyang. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self no3];
}


#pragma mark 第一章 - 图层树
/*
 UIView可以处理用户事件，而CALayer不能处理用户事件
 UIView是CALayer的高级包装
 每一个UIView都有一个CALayer实例的图层属性
 */
- (void)no1 {
    CALayer *layer = [CALayer layer];
    layer.delegate = self;
    layer.frame = CGRectMake(20, 320, 200, 200);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:layer];
}

#pragma mark 第二章 - 寄宿图
/*
 属性
 content
 contentGravity
 contentScale(Retina屏幕，Point概念)
 maskToBounds
 contentsRect
 contentCenter(拉伸区域){(0,0),(1,1)}
 */
- (void)no2 {
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(100, 100, 100, 100);
    layer1.backgroundColor = [UIColor whiteColor].CGColor;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(200, 100, 100, 100);
    layer2.backgroundColor = [UIColor whiteColor].CGColor;
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(100, 200, 100, 100);
    layer3.backgroundColor = [UIColor whiteColor].CGColor;
    
    CALayer *layer4 = [CALayer layer];
    layer4.frame = CGRectMake(200, 200, 100, 100);
    layer4.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    [self.view.layer addSublayer:layer4];
    
    UIImage *zn = [UIImage imageNamed:@"zn.png"];
    
    [self addSpriteImage:zn withContentRect:CGRectMake(0, 0, 0.5, 0.5) layer:layer1];
    
    [self addSpriteImage:zn withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) layer:layer2];
    
    [self addSpriteImage:zn withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) layer:layer3];
    
    [self addSpriteImage:zn withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) layer:layer4];
    
    CALayer *layer = [CALayer layer];
    layer.delegate = self;
    layer.frame = CGRectMake(20, 320, 200, 200);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    [layer display];
}
///拼合图片
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect layer:(CALayer *)layer {
    layer.contents = (id)(image.CGImage);
    layer.contentsGravity = kCAGravityResizeAspectFill;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.masksToBounds = YES;
    layer.contentsRect = rect;
}

///layer delegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

#pragma mark 第三章 - 图层几何学
/*
 UIView:frame bounds center
 CALayer:frame bounds position
 anchorPoint:锚点{(0,0),(1,1)}
 zPosition
 anchirPointZ
 */
- (void)no3 {
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(100, 100, 100, 100);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(100, 100, 100, 100);
    layer2.backgroundColor = [UIColor greenColor].CGColor;
    
    layer2.anchorPoint = CGPointMake(0, 0);
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    
    //NSLog(@"%@-%@",@(layer1.zPosition),@(layer2.zPosition));
    //layer1.zPosition += 1;
    //是否垂直翻转坐标
    //layer1.geometryFlipped = YES;
    ///判断point是否在layer1内
    BOOL isContains = [layer1 containsPoint:CGPointMake(100, 100)];
    if (isContains) {
        NSLog(@"is contains");
    }
    
    ///获取触摸到的layer1-包含子层
    CALayer *layer = [layer1 hitTest:CGPointMake(199, 199)];
    if (layer) {}
}

@end
