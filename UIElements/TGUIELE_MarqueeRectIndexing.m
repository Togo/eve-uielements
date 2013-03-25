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
	self.windowUIElements = windowUIElements;
	self->_marqueeRect = selectedRect;

	return [self searchInSelectedRect];
}

- (NSArray*) searchInSelectedRect {
	NSMutableArray *foundUIElements = [NSMutableArray array];

	for ( UIElement *element in _windowUIElements ) {
		if( [self isElementInSelectedRect:[element centralPointOfElementOnScreen]] ) {
			[foundUIElements addObject:element];
			NSLog(@"Treffer: %@", [element uiElementIdentifier]);
		}
	}

	return foundUIElements;
}

- (bool) isElementInSelectedRect :(CGPoint) origin {
	return CGRectContainsPoint(_marqueeRect, origin);
}
//- (NSArray*) searchInSelectedRect {
//	NSMutableArray *foundUIElements = [NSMutableArray array];
//	CGFloat indexingPosition1;
//	CGFloat indexingPosition2;
//	CGFloat originFirstScanRange;
//	CGFloat originSecondScanRange;
//	CGFloat firstScanRange;
//	CGFloat secondScanRange;
//
//	NSLog(@"%li", [self isVerticallyScan] );
//	if( [self isVerticallyScan] ) {
//		indexingPosition1	 = _marqueeRect.origin.y;
//		indexingPosition2  = _marqueeRect.origin.x;
//		originFirstScanRange = _marqueeRect.origin.y;
//		originSecondScanRange = _marqueeRect.origin.x;
//		firstScanRange = _marqueeRect.size.height;
//		secondScanRange =  _marqueeRect.size.width;
//	} else {
//		indexingPosition1	 = _marqueeRect.origin.x;
//		indexingPosition2  = _marqueeRect.origin.y;
//		originFirstScanRange = _marqueeRect.origin.x;
//		originSecondScanRange = _marqueeRect.origin.y;
//		firstScanRange = _marqueeRect.size.width;
//		secondScanRange =  _marqueeRect.size.height;
//
//	}
//
//	while ( indexingPosition1 < (originFirstScanRange + firstScanRange) ) {
//		while ( indexingPosition2 < (originSecondScanRange + secondScanRange) ) {
//			UIElement *foundUIElement = [self scanInPoint:indexingPosition1 andPoint:indexingPosition2];
//			NSLog(@"%@", [foundUIElement uiElementIdentifier]);
//			if( foundUIElement != nil
//					&& ![foundUIElement isKindOfClass:[NullUIElement class]] ) {
//
//				[foundUIElements addObject:foundUIElement];
//
//
//				indexingPosition1 += [self getElementDimensionValueToAdd :foundUIElement];
//
//				break;
//			}
//
//			indexingPosition2++;
//		}
//
//		indexingPosition2 = originSecondScanRange;
//		indexingPosition1++;
//	}
//
//	return foundUIElements;
//}

//- (CGFloat)getElementDimensionValueToAdd:(UIElement*) foundUIElement {
//	NSRect elementDimension = [foundUIElement elementDimension];
//	if( [self isVerticallyScan] ) {
//			return elementDimension.size.height;
//	} else {
//			return elementDimension.size.width;
//	}
//}
//
//- (BOOL)isVerticallyScan {
//	return _marqueeRect.size.height > _marqueeRect.size.width;
//}
//
//- (UIElement *)scanInPoint:(CGFloat)p1 andPoint:(CGFloat)p2 {
//	if( [self isVerticallyScan] ) {
//		return [UIElementUtilities copyElementAtPoint:p2 andPoint:p1 applicationReference:_appRef rectToScan:_marqueeRect];
//	} else {
//		return [UIElementUtilities copyElementAtPoint:p1 andPoint:p2 applicationReference:_appRef rectToScan:_marqueeRect];
//	}
//
//}

@end