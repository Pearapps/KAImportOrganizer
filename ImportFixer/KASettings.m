//
//  KASettings.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettings.h"

@implementation KASettings

- (nonnull instancetype)initWithFileExtensions:(nonnull NSArray *)fileExtensions directories:(nonnull NSArray *)directories insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes sortOrder:(nullable NSArray <NSString *> *)sortOrder {
    NSParameterAssert(fileExtensions);
    NSParameterAssert(directories);
    self = [super init];
    
    if (self) {
        _fileExtensions = fileExtensions;
        _directories = directories;
        _insertsNewLinesInBetweenTypes = insertsNewLinesInBetweenTypes;
        _sortOrder = [sortOrder copy];
    }
    
    return self;
}

@end
