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
    [self no6_1];
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


#pragma mark 第四章 - 视觉效果
- (void)no4 {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(150, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CALayer *imageLayer = [CALayer layer];
    UIImage *zn = [UIImage imageNamed:@"block.png"];
    imageLayer.contents = (id)(zn.CGImage);
    imageLayer.frame = CGRectMake(150, 250, 100, 100);
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    imageLayer.contentsGravity = kCAGravityResizeAspect;
    [self.view.layer addSublayer:imageLayer];
    
    ///蒙版
    CALayer *maskLayer = [CALayer layer];
    UIImage *block1 = [UIImage imageNamed:@"setting.png"];
    maskLayer.contents = (id)(block1.CGImage);
    maskLayer.frame = imageLayer.bounds;
    maskLayer.contentsGravity = kCAGravityResizeAspect;
    imageLayer.mask = maskLayer;

    
    ///圆角
    ///只影响颜色，不影响背景，masksToBounds可以裁切超出父图层的区域
    layer.cornerRadius = 20;
    
    ///图层边框
    layer.borderWidth = 2;
    layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    ///阴影
    ///{0.0不可见 ~ 1.0不透明}
    layer.shadowOpacity = 0.7;
    ///阴影颜色
    layer.shadowColor = [UIColor blackColor].CGColor;
    ///方向、距离 默认（0,-3）,偏上
    layer.shadowOffset = CGSizeMake(3, 3);
    ///模糊度
    layer.shadowRadius = 4;
    ///阴影的计算继承自内容而不是外形
    imageLayer.shadowOpacity = 0.8;
    imageLayer.shadowOffset = CGSizeMake(0, 5);
    imageLayer.shadowRadius = 5;
    ///如果在阴影图层使用masksToBounds，图层会被剪切掉
    ///shadowPath使用绘制的图形充当阴影，在提前知道阴影形状的前提下能提高性能
    
    
    ///拉伸过滤
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 40, 40, 40);
    layer1.contents = (id)([UIImage imageNamed:@"block1.png"].CGImage);
    [self.view.layer addSublayer:layer1];
    //kCAFilterNearest kCAFilterLinear kCAFilterTrilinear
    layer1.minificationFilter = kCAFilterTrilinear;
//    layer1.magnificationFilter = kCAFilterNearest;
    
    
    ///组透明-光栅化（慎用，搭配Scala）
    UIButton *btn1 = [self customButton];
    [self.view addSubview:btn1];
    btn1.alpha = 0.5;
    btn1.layer.shouldRasterize = YES;
}

- (UIButton *)customButton {
    CGRect frame = CGRectMake(20, 120, 80, 80);
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor whiteColor];
    CGRect frame1 = CGRectMake(20, 20, 40, 40);
    UILabel *lab = [[UILabel alloc] initWithFrame:frame1];
    lab.text = @"wAnG";
    lab.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:lab];
    return btn;
    
}

#pragma mark 第五章 - 变换
///角度转弧度
#define RADIANS_TO_DEGREES(x) ((x)/M_PI * 180.0)
///仿射变换
- (void)no5_1 {
    //旋转-单位为弧度
    //CGAffineTransformMakeRotation(CGFloat angle)
    //缩放
    //CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
    //平移
    //CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
    //view.transform == layer.affineTransform
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(100, 100, 100, 100);
    UIImage *zn = [UIImage imageNamed:@"zn.png"];
    layer1.contents = (id)zn.CGImage;
    [self.view.layer addSublayer:layer1];

//    layer1.affineTransform = CGAffineTransformMakeRotation(M_PI_4);
//    layer1.affineTransform = CGAffineTransformMakeScale(0.5, 0.8);
//    layer1.affineTransform = CGAffineTransformMakeTranslation(100, 0);
    
    ///混合变换
    //CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
    //CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
    //CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
    //初始化生成一个什么都不做的变换
    //CGAffineTransformIdentity
    //混合两个已经存在的变换
    //CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2)
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformRotate(transform, RADIANS_TO_DEGREES(45));
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//    ///平移的效果会作用在之前旋转和缩放之上，所以顺序不同，结果也不同
//    transform = CGAffineTransformTranslate(transform, 100, 100);
//    layer1.affineTransform = transform;
}

///3D变换
- (void)no5_2 {
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(10, 100, 100, 100);
    UIImage *zn = [UIImage imageNamed:@"block.png"];
    layer1.contents = (id)zn.CGImage;
    [self.view.layer addSublayer:layer1];
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(200, 100, 100, 100);
    UIImage *zn1 = [UIImage imageNamed:@"block1.png"];
    layer2.contents = (id)zn1.CGImage;
    [self.view.layer addSublayer:layer2];
    
    //CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    //CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
    //CATransform3DMakeTranslation(CGFloat tx, CGFloat ty, CGFloat tz)
    CATransform3D perspective = CATransform3DIdentity;
    ///m34用来表示视角的距离，默认是0，则不能体现3D效果，使用-1除以(500 ~ 1000)可以获得效果
    perspective.m34 = -1.0 / 500.0;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI , 1, 0, 0);
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    //使整个图层的视图都具有相同的灭点
    self.view.layer.sublayerTransform  = perspective;
    ///layer1此时会显示为背面的镜像，doubleSided可以控制是否绘制背面
    layer1.doubleSided = YES;
    layer1.transform = transform1;
    layer2.transform = transform2;
    
    
   
    
//    CATransform3D transform2 = CATransform3DIdentity;
    ///m34用来表示视角的距离，默认是0，则不能体现3D效果，使用-1除以(500 ~ 1000)可以获得效果
//    transform2.m34 = -1.0 / 1.0;
//    transform2 = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    
}

#pragma mark - 专用图层
///CAShapeLayer
- (void)no6_1 {
    ///矢量图层
    ///使用UIBezierPath进行绘制，不必考虑内存释放的问题
    ///可以使用CAShapeLayer单独绘制某一个角的圆角
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth  = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:8 clockwise:YES];
    [path moveToPoint:CGPointMake(150, 100)];
    [path addLineToPoint:CGPointMake(150, 125)];
    
    shapeLayer.path  = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}
///CATextlayer
- (void)no6_2 {
    ///相比于UILabel提供更丰富的接口
}

@end
