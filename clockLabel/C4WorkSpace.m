//
//  C4WorkSpace.m
//  clockLabel
//
//  Created by Travis Kirton on 12-05-16.
//  Copyright (c) 2012 POSTFL. All rights reserved.
//

#import "C4WorkSpace.h"
#import "C4DateTime.h"

@interface C4WorkSpace ()
-(void)updateTime;
-(void)updateMillis;
@end

@implementation C4WorkSpace {
    NSDate *d;
    C4Label *timeLabel;
    C4Label *millisLabel;
}

-(void)setup {
    C4Font *font = [C4Font fontWithName:@"helvetica" size:90];
    timeLabel = [C4Label labelWithText:@"--:--:--" andFont:font];
    [timeLabel sizeToFit];
    timeLabel.center = CGPointMake(384,512);
    [self.canvas addLabel:timeLabel];
    
    millisLabel = [C4Label labelWithText:@"----" andFont:[font fontWithSize:20]];
    [millisLabel sizeToFit];
    CGPoint p = timeLabel.center;
    p.y += timeLabel.frame.size.height/2;
    millisLabel.center = CGPointMake(384, 512+timeLabel.frame.size.height);
    [self.canvas addLabel:millisLabel];

    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f 
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil 
                                            repeats:YES];
    [timer fire];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    timer = [NSTimer timerWithTimeInterval:1.0f/1000.0f 
                                    target:self
                                  selector:@selector(updateMillis)
                                  userInfo:nil 
                                   repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    timer = nil;
}

-(void)updateTime {
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",
                            [C4DateTime hourString],
                            [C4DateTime minuteString],
                            [C4DateTime secondString]];
    timeLabel.text = timeString;
    [timeLabel sizeToFit];
    timeLabel.center = CGPointMake(384,512);
}

-(void)updateMillis {
    millisLabel.text = [NSString stringWithFormat:@"%d",[C4DateTime millis]];
    millisLabel.center = CGPointMake(384, 512+timeLabel.frame.size.height/2);
    [millisLabel sizeToFit];
}

@end
