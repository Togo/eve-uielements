//
//  NotificationObserver.h
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NotificationObserver <NSObject>

- (void) update (id object);
- (void) suscribeToNotificiation(NSString *notificationName);
- (void) unsuscribeNotificiation(NSString *notificationName);

@end
