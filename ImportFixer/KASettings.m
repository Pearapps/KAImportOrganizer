//
//  KASettings.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettings.h"

@implementation KASettings

- (instancetype)initWithFileExtensions:(NSArray *)fileExtensions directories:(NSArray *)directories insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes {
    self = [super init];
    
    if (self) {
        _fileExtensions = fileExtensions;
        _directories = directories;
        _insertsNewLinesInBetweenTypes = insertsNewLinesInBetweenTypes;
    }
    
    return self;
}

@end
