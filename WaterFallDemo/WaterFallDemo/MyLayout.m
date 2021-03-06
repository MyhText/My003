//
//  MyLayout.m
//  Practice001
//
//  Created by Mac on 16/6/21.
//  Copyright © 2016年 Lukas. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

{
        //这个数组就是我们自定义的布局配置数组
        NSMutableArray * _attributeAttay;
}


//数组的相关设置在这个方法中
//布局前的准备会调用这个方法
#pragma mark -- 重写准备布局(prepareLayout)这个方法
-(void)prepareLayout{
    // 让父类把该做的事情做完
    [super prepareLayout];
    
    // 初始化数组
    _attributeAttay = [[NSMutableArray alloc]init];
    
    // 在这里默认设置为静态的2列
    
    //计算每一个item的宽度
    // self.sectionInset.left  左间距
    // self.sectionInset.right 右间距
    // self.minimumInteritemSpacing 两列之间的间距
    float WIDTH = ([UIScreen mainScreen].bounds.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing)/2;
    
    //定义数组保存每一列的高度
    //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
    CGFloat colHight[2];
        //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
    for (int i=0; i<_itemCount; i++) {
        //设置每个item的位置等相关属性
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        //创建一个布局属性类，通过indexPath来创建
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
    
        //随机一个高度 在40——190之间
        CGFloat hight = arc4random()%220+100;
        
        //哪一列高度小 则放到那一列下面
        //标记最短的列
        int width=0;
        
        // 判断当前item的高度，把最新的永远放到最低的那一列
        colHight[0]<colHight[1] ? (colHight[0]=colHight[0]+hight+self.minimumLineSpacing,width=0) : (colHight[1] = colHight[1]+hight+self.minimumLineSpacing,width=1);
        
//        if (colHight[0]<colHight[1]) {
//                //将新的item高度加入到短的一列
//            colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
//            width=0;
//        }else{
//            
//            colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
//            width=1;
//        }
        
        //设置item的位置
        attris.frame = CGRectMake(self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*width, colHight[width]-hight-self.minimumLineSpacing, WIDTH, hight);
        
        // 把Layout的对象放到数组里面
        [_attributeAttay addObject:attris];
        
    }
    
    
    //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
    if (colHight[0]>colHight[1]) {
        
        self.itemSize = CGSizeMake(WIDTH, (colHight[0]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }else{
        
        self.itemSize = CGSizeMake(WIDTH, (colHight[1]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }
    
        
}


#pragma mark--这个方法中返回我们的布局数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return _attributeAttay;
}




@end
