//
//  LeftMouseButtonClickedObservableSubject.h
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObservableSubject.h"

@interface ClickOnUIElementSubject : NSObject <ObservableSubject> {
  AXUIElementRef          currentUIElement;
  AXUIElementRef			    systemWideElement;
  
  NSPoint                 lastMousePoint;
  
  NSEvent                 *globalMouseListener;
  
  BOOL                    currentlyInteracting;
}

@property (unsafe_unretained) AXUIElementRef currentUIElement;
@property (unsafe_unretained) AXUIElementRef systemWideElement;

@property (unsafe_unretained) NSPoint        lastMousePoint;

@property (strong, nonatomic) NSEvent        *globalMouseListener;

@property (unsafe_unretained) BOOL           currentlyInteracting;;


- (void)     notifyObserver;
- (NSEvent*) registerListener;
- (void)     uiElementChanged;
- (void)     updateCurrentUIElement;

@end
