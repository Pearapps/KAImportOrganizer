//
//  KASettings.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettings.h"

@implementation KASettings

- (instancetype)initWithDirectories:(NSArray *)directories fileExtensions:(NSArray *)fileExtensions {
    self = [super init];
    
    _directories = directories;
    _fileExtensions = fileExtensions;
    
    return self;
}


@end
