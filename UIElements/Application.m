//
//  Application.m
//  UIElements
//
//  Created by Tobias Sommer on 10/23/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "Application.h"

@implementation Application

@synthesize bundleIdentifier;
@synthesize appName;
@synthesize runningApplication;
@synthesize guiSupport;

- (id) initWithBundleIdentifier :(NSString*) bundle {
  self = [super init];
  
  self.bundleIdentifier = bundle;
  self.appName = [self createApplicationName];
  self.runningApplication = [self getOSXRunningApplicationObject];
  self.guiSupport = NO;
  
  return self;
}

- (id) initWithProcessId :(pid_t*) pid {
  return [self initWithBundleIdentifier:[[NSRunningApplication runningApplicationWithProcessIdentifier:*pid] bundleIdentifier]];
}

- (id) initWithElementReference :(AXUIElementRef) ref {
  pid_t               theAppPID = 0;
  
  if (AXUIElementGetPid( (AXUIElementRef)ref, &theAppPID ) == kAXErrorSuccess) {
   return [[Application alloc] initWithProcessId:&theAppPID];
  }
  
  return nil;
}

- (NSRunningApplication*) getOSXRunningApplicationObject {
  NSArray *runningApplications = [[NSWorkspace sharedWorkspace] runningApplications];
  
  for (id aApp in runningApplications) {
    if ([[aApp bundleIdentifier] isEqualToString:bundleIdentifier]) {
      return aApp;
      break;
    }
  }
  
  return nil;
}

- (NSString*) createApplicationName {
  NSString *name;
  NSString *bundlePath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:bundleIdentifier];
	NSBundle *appBundle = [NSBundle bundleWithPath:bundlePath];
	name = [appBundle objectForInfoDictionaryKey:(id)kCFBundleNameKey];
  if (name)
     return name;
  else
    return @"";
}

- (AXUIElementRef) getAppRef {
  AXUIElementRef appRef = AXUIElementCreateApplication( [[self getOSXRunningApplicationObject] processIdentifier] );
  return appRef;
}

@end
