//
//  KAImportTypeModel.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportTypeModel.h"

@interface KAImportTypeModel ()

@property (nonatomic, copy, readonly, nonnull) NSString *importTypeString;

@end

@implementation KAImportTypeModel

- (nonnull instancetype)initWithImportTypeString:(nonnull NSString *)importTypeString {
    NSParameterAssert(importTypeString);
    self = [super init];
    
    if (self) {
        _importTypeString = [importTypeString copy];
        _importType = [self importTypeFromString];
    }
    
    return self;
}

- (KAImportType)importTypeFromString {
    if ([self.importTypeString isEqualToString:@"PoundLibrary"]) {
        return KAImportTypePoundLibrary;
    }
    else if ([self.importTypeString isEqualToString:@"Pound"]) {
        return KAImportTypePound;
    }
    else if ([self.importTypeString isEqualToString:@"AtSign"]) {
        return KAImportTypeAtSign;
    }
    else if ([self.importTypeString isEqualToString:@"Swift"]) {
        return KAImportTypeSwift;
    }
    
    @throw [[NSException alloc] initWithName:@"KAInvalidImportString" reason:@"A string that didn't map to any KAImportType was inputted" userInfo:nil];
}

@end
