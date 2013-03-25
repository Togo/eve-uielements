//
//  UIElementUtilities.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "UIElementUtilities.h"
#import "UIElementUtilities_org.h"
#import "UIElement.h"
#import "NullUIElement.h"
#import "Application.h"

@implementation UIElementUtilities

+ (NSString*) readkAXAttributeString:(AXUIElementRef)element :(CFStringRef) kAXAttribute {
  CFStringRef stringRef;

  if (AXUIElementCopyAttributeValue( element, (CFStringRef) kAXAttribute, (CFTypeRef*) &stringRef ) == kAXErrorSuccess) {
    NSString *returnValue = (__bridge NSString *) stringRef;
    CFRelease(stringRef);
    return returnValue;
  } else {
    return @"";
  }
}

+ (AXUIElementRef) secondParent :(AXUIElementRef) elementRef {
  AXUIElementRef parentRef = elementRef;
  if (parentRef) {
    parentRef = [UIElementUtilities_org parentOfUIElement:parentRef];
    if (parentRef) {
      parentRef = [UIElementUtilities_org parentOfUIElement:parentRef];
    }
  }
  return parentRef;
}

+ (NSString*) cleanString :(id) string {
  // Check if this is a number
  if([string isKindOfClass:NSString.class])  {
    NSMutableString *cleanedTitle = [NSMutableString stringWithString:string];

    // remove Text between „”
    NSCharacterSet *rangeFileNameSet = [NSCharacterSet characterSetWithCharactersInString:@"„”“"];
    NSRange startIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:0];
    NSRange endIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:NSBackwardsSearch];
    if (startIndex.length != NSNotFound
        && startIndex.location != endIndex.location) {
      NSRange rangeToRemove = NSMakeRange((startIndex.location), (endIndex.location - startIndex.location) + 1);

      [cleanedTitle deleteCharactersInRange:rangeToRemove];
    }

    // remove Text between ()
    rangeFileNameSet = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    startIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:0];
    endIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:NSBackwardsSearch];
    if (startIndex.length != NSNotFound
        && startIndex.location != endIndex.location) {
      NSRange rangeToRemove = NSMakeRange((startIndex.location), (endIndex.location - startIndex.location) + 1);

      [cleanedTitle deleteCharactersInRange:rangeToRemove];
    }


    NSCharacterSet *engCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"„…&”“."];
    return [[cleanedTitle componentsSeparatedByCharactersInSet: engCharacterSet] componentsJoinedByString: @""];
  } else {
    return string;
  }
}

+ (AXUIElementRef) getAppRefFromBundleIdentifier :bundleIdentifier {
  NSArray *runningApplications =    [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleIdentifier];

  if ([runningApplications count] > 0)
    return (AXUIElementCreateApplication( [[runningApplications objectAtIndex:0] processIdentifier] ));
  else
    return nil;
}

+ (AXUIElementRef) getUIElementUnderMousePointer :(NSString*) bundleIdentifier {
  AXUIElementRef appRef = [self getAppRefFromBundleIdentifier:bundleIdentifier];
  NSPoint cocoaPoint = [NSEvent mouseLocation];
  CGPoint pointAsCGPoint = [UIElementUtilities_org carbonScreenPointFromCocoaScreenPoint:cocoaPoint];

  AXUIElementRef newElement = NULL;

  AXUIElementCopyElementAtPosition( appRef, pointAsCGPoint.x, pointAsCGPoint.y, &newElement );

  return newElement;
}

+ (NSImage *) captureUIElement : (AXUIElementRef) ref {
  AXValueRef value;
  NSRect rect;	// dock rect

  if (ref) {

  // get size
  AXUIElementCopyAttributeValue(ref, kAXSizeAttribute, (CFTypeRef *) &value);
  AXValueGetValue(value, kAXValueCGSizeType, (void *) &rect.size);

  // get position
  AXUIElementCopyAttributeValue(ref, kAXPositionAttribute, (CFTypeRef *) &value);
  AXValueGetValue(value, kAXValueCGPointType, (void *) &rect.origin);

  // get the whole image
  CGDirectDisplayID displayID = CGMainDisplayID();

  CGImageRef image = CGDisplayCreateImageForRect(displayID, rect);
  NSImage *im = [[NSImage alloc] init];
  if (image != NULL) {
    NSBitmapImageRep *temp = [[NSBitmapImageRep alloc] initWithCGImage :image];

    [im addRepresentation:temp];
  }
  if (value) {
      CFRelease(value);
  }
  if (image) {
      CGImageRelease(image);
  }
    return im;
  }
  return nil;
}

//+ (NSArray *)getUIElementUnderRect :(id) input :(NSString*) bundleIdentifier {
//	AXUIElementRef appRef = [self getAppRefFromBundleIdentifier:bundleIdentifier];
//	NSArray *foundGUIElements = [NSArray array];
//
//
//	if( !(strcmp([input objCType], (const char *)@encode(NSRect)) == 0) ) {
//		@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"I need a NSValue with a Rect struct as input! " userInfo:nil];
//	}
//
//	NSRect selectedRect = [input rectValue];
//
//	if( appRef ) {
//		foundGUIElements = [self indexElementsInRect:appRef selectedRect:selectedRect];
//	}
//
//
// return foundGUIElements;
//}

//+ (NSArray *)indexElementsInRect:(AXUIElementRef)appRef selectedRect:(NSRect)selectedRect {
//	AXUIElementRef newElement = NULL;
//	NSInteger sizePositionWidth = selectedRect.origin.x;
//	NSInteger sizePositionHeight = selectedRect.origin.y;
//	NSMutableArray *mutableArray = [NSMutableArray array];
//
//	while ( sizePositionWidth < (selectedRect.origin.x + selectedRect.size.width) ) {
//			while ( sizePositionHeight < (selectedRect.origin.y + selectedRect.size.height) ) {
//				AXUIElementCopyElementAtPosition( appRef, sizePositionWidth, sizePositionHeight, &newElement );
//
//				UIElement *element = [UIElement createUIElement :newElement];
//				if( ![element isKindOfClass:[NullUIElement class]] ) {
//					NSPoint centralPoint = [element centralPointOfElementOnScreen];
//					NSRect rect = [element elementDimension];
//
//					if( CGRectContainsPoint(selectedRect, centralPoint) ) {
//						NSLog(@"Mittelpunkt: x:%f y:%f", centralPoint.x, centralPoint.y);
//						NSLog(@"%@ Width: %f, Height: %f <<<>>>> PositionScreen: origin.x: %f, origin.y: %f", [element uiElementIdentifier], rect.size.width, rect.size.height, rect.origin.x, rect.origin.y);
//						[mutableArray addObject:element];
//					}
//
//					sizePositionWidth += rect.size.width;
//					break;
//				}
//
//				sizePositionHeight++;
//			}
//
//			sizePositionHeight = selectedRect.origin.y;
//			sizePositionWidth++;
//		}

// TODO untested
+ (UIElement *)copyElementAtPoint:(CGFloat)x andPoint:(CGFloat)y applicationReference:(AXUIElementRef)appRef rectToScan:(NSRect)selectedRect {
	AXUIElementRef newElement = NULL;

	NSLog(@"scan x:%f y:%f", x,y);
		if( AXUIElementCopyElementAtPosition( appRef, x, y, &newElement) == kAXErrorSuccess) {
			UIElement *element = [UIElement createUIElement :newElement];
			if( ![element isKindOfClass:[NullUIElement class]] ) {
				NSPoint centralPoint = [element centralPointOfElementOnScreen];

				NSLog(@"centralPoint: %@ rect:%@", NSStringFromPoint(centralPoint), NSStringFromRect(selectedRect));
				if( CGRectContainsPoint(selectedRect, centralPoint) ) {
					NSLog(@"Mittelpunkt: x:%f y:%f", centralPoint.x, centralPoint.y);
		//			NSLog(@"%@ Width: %f, Height: %f <<<>>>> PositionScreen: origin.x: %f, origin.y: %f", [element uiElementIdentifier], rect.size.width, rect.size.height, rect.origin.x, rect.origin.y);
					return element;
				}
			}

	return [[NullUIElement alloc] init];
	}
return [[NullUIElement alloc] init];
}

+ (NSRect)readElementDimension:(AXUIElementRef)ref {
	NSRect rect = NSMakeRect(0, 0, 0, 0);

	if( ref ) {
		AXValueRef value;

		AXUIElementCopyAttributeValue(ref, kAXSizeAttribute, (CFTypeRef *) &value);
		AXValueGetValue(value, kAXValueCGSizeType, (void *) &rect.size);

		AXUIElementCopyAttributeValue(ref, kAXPositionAttribute, (CFTypeRef *) &value);
		AXValueGetValue(value, kAXValueCGPointType, (void *) &rect.origin);
	}

	return rect;
}
@end
