//
//  ClickOnUIElementSubject.m
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "ClickOnUIElementSubject.h"
#import "UIElementUtilities_org.h"

@implementation ClickOnUIElementSubject

@synthesize  currentUIElement;
@synthesize	 systemWideElement = _systemWideElement;

@synthesize  lastMousePoint = _lastMousePoint;

@synthesize  globalMouseListener;

@synthesize  currentlyInteracting = _currentlyInteracting;

- (id) init {
  self = [super init];
  
  self.globalMouseListener = [self registerListener];
  self.systemWideElement = AXUIElementCreateSystemWide();
  
  return self;
}

- (void) notifyObserver {
    [[NSNotificationCenter defaultCenter] postNotificationName:ClickOnUIElementNotification object:self];
}

- (void) uiElementChanged {
  [self updateCurrentUIElement];
  [self notifyObserver];
}

- (NSEvent*) registerListener {
  return [NSEvent addGlobalMonitorForEventsMatchingMask:(NSLeftMouseUp)
                                                                handler:^(NSEvent *incomingEvent) {
                                                                  [self uiElementChanged];
                                                                }];
}

// -------------------------------------------------------------------------------
//	updateCurrentUIElement:
// -------------------------------------------------------------------------------
- (void) updateCurrentUIElement
{
//  NSLog(@"ClickOnUIElementSubject -> updateCurrentUIElement() :: get called");
  // The current mouse position with origin at top right.
  NSPoint cocoaPoint = [NSEvent mouseLocation];
  
  // Only ask for the UIElement under the mouse if has moved since the last check.
  if (!NSEqualPoints(cocoaPoint, _lastMousePoint)) {
//  NSLog(@"ClickOnUIElementSubject -> updateCurrentUIElement() :: new mouse Position");
    CGPoint pointAsCGPoint = [UIElementUtilities_org carbonScreenPointFromCocoaScreenPoint:cocoaPoint];
    
    AXUIElementRef newElement = NULL;
    
    /* If the interaction window is not visible, but we still think we are interacting, change that */
    if (_currentlyInteracting) {
      _currentlyInteracting = ! _currentlyInteracting;
    }
    
    // Ask Accessibility API for UI Element under the mouse
    // And update the display if a different UIElement
    AXError error = AXUIElementCopyElementAtPosition( _systemWideElement, pointAsCGPoint.x, pointAsCGPoint.y, &newElement );
//    NSLog(@"ClickOnUIElementSubject -> updateCurrentUIElement() :: error by AXUIElementCopyElementAtPosition? => :%i:", error);
    if ( error == kAXErrorSuccess
        && newElement
        && ([self currentUIElement] == NULL || !CFEqual( [self currentUIElement], newElement ))) {
      
//      NSLog(@"ClickOnUIElementSubject -> updateCurrentUIElement() :: set new Element. old -> :%@: <--> new :%@: ", [self currentUIElement], newElement);
        [self setCurrentUIElement:newElement];
    }
    _lastMousePoint = cocoaPoint;
  }
}

@end
