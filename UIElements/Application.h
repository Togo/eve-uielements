//
//  Application.h
//  UIElements
//
//  Created by Tobias Sommer on 10/23/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject {
  NSRunningApplication *runningApplication;
  NSString *appName;
  NSString *bundleIdentifier;
}

@property (copy) NSString *appName;
@property (copy) NSString *bundleIdentifier;
@property (unsafe_unretained) NSInteger appID;
@property (strong, nonatomic) NSRunningApplication *runningApplication;
@property (unsafe_unretained) Boolean guiSupport;

- (id) initWithBundleIdentifier :(NSString*) bundle;

- (NSRunningApplication*) getOSXRunningApplicationObject;
- (NSString*) createApplicationName;
- (AXUIElementRef) getAppRef;
- (id) initWithProcessId :(pid_t*) pid;
- (id) initWithElementReference :(AXUIElementRef) ref;

@end
