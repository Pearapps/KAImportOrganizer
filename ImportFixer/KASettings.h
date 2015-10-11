//
//  KASettings.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KASettings : NSObject

- (instancetype)initWithDirectories:(NSArray *)directories fileExtensions:(NSArray *)fileExtensions;

@property (nonatomic, readonly) NSArray *fileExtensions;
@property (nonatomic, readonly) NSArray *directories;

@end
