// TGUIELE_MarqueeRectIndexing.h
//
// Created by Togo on 3/20/13.
//
//  Copyright (c) 2013 Togo. All rights reserved.
//


#import "TGUIELE_MarqueeRectIndexing.h"
#import "UIElement.h"


@implementation TGUIELE_MarqueeRectIndexing

+ (id)marqueeIndexing {
	return [[self alloc] init];
}

- (NSArray *)startIndexing:(NSArray *)windowUIElements selectedMarqueeRect:(NSRect)selectedRect {
	self.windowUIElements = [NSArray arrayWithArray:windowUIElements];
	self->_marqueeRect = selectedRect;

	return [self searchInSelectedRect];
}

- (NSArray*) searchInSelectedRect {
	NSMutableArray *foundUIElements = [NSMutableArray array];

	for ( UIElement *element in _windowUIElements ) {
		if( [self isElementInSelectedRect:[element centralPointOfElementOnScreen]] ) {
			[foundUIElements addObject:element];
		}
	}

	return foundUIElements;
}

- (bool) isElementInSelectedRect :(CGPoint) origin {
//	NSLog(@"rect: %@ >>> %@", NSStringFromRect(_marqueeRect), NSStringFromPoint(origin));
	return CGRectContainsPoint(_marqueeRect, origin);
}

@end