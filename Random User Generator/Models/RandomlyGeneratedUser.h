//
//  RandomlyGeneratedUser.h
//  Random User Generator
//
//  Created by Greg Barbosa on 1/30/14.
//  Copyright (c) 2014 PolaritySoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomlyGeneratedUser : NSObject

@property (nonatomic, strong) NSString *userFirstName;
@property (nonatomic, strong) NSString *userLastName;
@property (nonatomic, strong) NSString *userFullName;
@property (nonatomic, strong) NSString *userStreetAddress;
@property (nonatomic, strong) NSString *userImage;

- (NSURL *) userImageURL;

@end
