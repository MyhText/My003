//
//  ViewController.m
//  WaterFallDemo
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 Lukas. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyLayout *layout=[[MyLayout alloc]init];
    
    // scrollDirection 滚动方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    // itemCount 项目数量
    layout.itemCount=100;
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

#pragma mark -- 实现代理方法

#pragma mark -- 返回有几个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark -- 返回每个区有几个项目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

#pragma mark -- 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:cell.bounds];
    imageView.image=[UIImage imageNamed:@"8.jpg"];
    
    [cell.contentView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 30)];
    label.text=[NSString stringWithFormat:@"这是第%ld个cell",indexPath.row];
    label.backgroundColor=[UIColor orangeColor];
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark-设置cell即将出现的方法  做3D动画出场
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.transform=CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [UIView animateWithDuration:0.6 animations:^{
        
        cell.layer.transform=CATransform3DMakeScale(1, 1, 1);
    }];
    
}


@end
