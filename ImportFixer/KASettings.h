//
//  KASettings.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KASettings : NSObject

- (instancetype)initWithFileExtensions:(NSArray *)fileExtensions directories:(NSArray *)directories insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes;

@property (nonatomic, readonly) NSArray *fileExtensions;
@property (nonatomic, readonly) NSArray *directories;
@property (nonatomic, readonly) BOOL insertsNewLinesInBetweenTypes;

@end
