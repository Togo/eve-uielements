// TGUIELE_MarqueeRectIndexing.h
//
// Created by Togo on 3/20/13.
//
//  Copyright (c) 2013 Togo. All rights reserved.
//


#import <Foundation/Foundation.h>

@class UIElement;

@interface TGUIELE_MarqueeRectIndexing : NSObject {
@public
	NSRect _marqueeRect;
}

@property(nonatomic, strong) NSArray *windowUIElements;

+ (id)marqueeIndexing;

- (NSArray *)startIndexing:(NSArray *)windowUIElements selectedMarqueeRect:(NSRect)selectedRect;

- (NSArray *)searchInSelectedRect;
- (bool)isElementInSelectedRect :(CGPoint) origin;
//- (UIElement *)scanInPoint:(CGFloat)p1 andPoint:(CGFloat)p2;
@end