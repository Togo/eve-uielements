//
//  NotificationObserver.h
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NotificationObserver <NSObject>

@property (strong, nonatomic)  NSMutableDictionary *subscribedNotifications;

- (void) update :(NSNotification *)notification;
- (void) subscribeToNotificiation :(NSString*) notificationName;
- (void) subscribeToGlobalNotificiation :(NSString*) notificationName;
- (void) unsuscribeNotificiation :(NSString*) notificationName;

@end
