//
//  ViewController.m
//  图片轮播（slider）
//
//  Created by Zhang Xiangyu on 16/4/8.
//  Copyright © 2016年 Zhang Xiangyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    for (int i = 0;i < 5;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];

        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width , 0,self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_0%d",i+1]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(5 * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    
    //拖动分页
    self.scrollView.pagingEnabled = YES;
    
    
    //设置代理对象
    self.scrollView.delegate = self;
    
    
    
    //创建定时器，实现定时滚动
        //1.
 //  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //这个代表 默认添加到 main runloop中
    //默认使用 NSDefaultRunLoopMode
        //2.
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //需要手动添加到 runloop
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //可以设置为 NSDefaultRunLoopMode 和 NSRunLoopCommonModes，两者的区别在于：前者只能同时运行一个事件，而后者可以允许允许多个
    
    
}


- (void)nextPage
{
    // ---------------------(法一)---------------------------
    
//    if (self.pageControl.currentPage == 4) {
//        self.pageControl.currentPage = 0;
//        self.scrollView.contentOffset = CGPointMake(0.f, 0.f);
//    }
//    else
//    {
//        
//        CGPoint currentOffset = self.scrollView.contentOffset;
//        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width  + currentOffset.x, 0.f);
//        
//    }
//
//      //这个代码比下面的代码更好，因为下面的代码在运行时，如果手托住图片几秒不动，按照下面的代码，其 self.scrollView.contentOffset 还是在每秒不断的变化，因此当松手时图片可能会变化几页，解决方法是需要在 scrollViewWillBeginDragging 中暂时关闭定时器，在 scrollViewDidEndDragging 再开启定时器 比较麻烦。而上面的的代码 其 self.scrollView.contentOffset 是根据当前的self.scrollView.contentOffset 增加的，所以如果手托住图片几秒不动，图片就不会变化,
    
    
    //

    
    //self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * ((++self.pageControl.currentPage) % 5), 0.f);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * ((++self.pageControl.currentPage) % 5), 0.f) animated:YES];
    //或者
    //
    //[UIView animateWithDuration:0.3f animations:^{self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * ((++self.pageControl.currentPage) % 5), 0.f);}];
    
    //---------------------(法3:视频课程中的：)---------------------------
    /*
    int currentPage = self.pageControl.currentPage;
    currentPage ++;
    if (currentPage == 5) {
        currentPage = 0;
    }
    
    CGFloat width = self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(currentPage * width, 0.f);
    self.scrollView.contentOffset = offset;
     */
    
    
    
    
}




#pragma mark -- scrollViewDelegate 的实现方法
//当 scrollView 在滚动时，就一直执行   (通过代码 改变 self.scrollView.contentOffset 也会触发 )
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滚动位置偏移量
    CGFloat offsetX = self.scrollView.contentOffset.x;
    int pageNumber = (offsetX + 0.5* self.scrollView.frame.size.width) / self.scrollView.frame.size.width;
    NSLog(@"%d",pageNumber);
    self.pageControl.currentPage = pageNumber;
}




@end


