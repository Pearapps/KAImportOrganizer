//
//  KAImportSorter.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportSorter.h"

@interface KAImportSorter ()

@property (nonatomic, copy, readonly, nonnull) NSArray <KAImportStatement *> *imports;
@property (nonatomic, copy, readonly, nullable) NSArray <KAImportTypeModel *> *sortOrderOfImportType;

@end

@implementation KAImportSorter

- (nonnull instancetype)initWithImports:(nonnull NSArray <KAImportStatement *> *)imports sortOrderOfImportType:(nullable NSArray <KAImportTypeModel *> *)sortOrderOfImportType {
    NSParameterAssert(imports);
    self = [super init];
    
    if (self) {
        _imports = [imports copy];
        _sortOrderOfImportType = [sortOrderOfImportType copy];
    }
    
    return self;
}

static inline BOOL isAscending(KAImportStatement *first, KAImportStatement *second) {
    const KAImportType firstType = first.importType;
    const KAImportType secondType = second.importType;
    
    if (firstType == KAImportTypeAtSign && secondType == KAImportTypePound) {
        return YES;
    }
    else if (firstType == KAImportTypePound && secondType == KAImportTypeAtSign) {
        return NO;
    }
    
    if (firstType == secondType) {
        NSInteger i = 0;
        NSComparisonResult result = NSOrderedSame;
        while (result == NSOrderedSame && i < first.importParts.count && i < second.importParts.count) {
            NSString *firstString = first.importParts[i];
            NSString *secondString = second.importParts[i];
            
            result = [firstString compare:secondString options:NSCaseInsensitiveSearch];
            
            i++;
        }
        return result == NSOrderedAscending;
    }
    
    return NO;
}

- (nonnull NSArray *)sortedImports {
    return [_imports sortedArrayUsingComparator:^NSComparisonResult(KAImportStatement * _Nonnull obj1, KAImportStatement * _Nonnull obj2) {
        if ([obj1.importString isEqualToString:obj2.importString]) {
            return NSOrderedSame;
        }
        
        if (isAscending(obj1, obj2)) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
}

@end
