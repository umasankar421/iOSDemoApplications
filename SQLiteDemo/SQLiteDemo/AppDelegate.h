//
//  AppDelegate.h
//  SQLiteDemo
//
//  Created by Vikas Mishra on 3/3/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

