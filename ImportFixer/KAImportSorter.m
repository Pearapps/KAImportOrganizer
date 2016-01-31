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

- (nonnull NSArray <KAImportStatement *> *)sortedImports {
    NSArray <KAImportStatement *> * sortedImports = ^ NSArray <KAImportStatement *> * {
        NSArray <KAImportStatement *> *imports = [_imports sortedArrayUsingComparator:^NSComparisonResult(KAImportStatement * _Nonnull obj1, KAImportStatement * _Nonnull obj2) {
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
        
        if (self.sortOrderOfImportType) {
            NSInteger (^IndexFinder)(KAImportType importType) = ^ NSInteger (KAImportType importType) {
                for (NSInteger i = 0; i < self.sortOrderOfImportType.count; i++) {
                    const KAImportTypeModel *typeModel = self.sortOrderOfImportType[i];
                    
                    if (typeModel.importType == importType) {
                        return i;
                    }
                }
                
                return -1;
            };
            
            imports = [imports sortedArrayUsingComparator:^NSComparisonResult(KAImportStatement * _Nonnull obj1, KAImportStatement *  _Nonnull obj2) {
                if (obj1.importType == obj2.importType) {
                    return NSOrderedSame;
                }
                
                if (IndexFinder(obj1.importType) < IndexFinder(obj2.importType)) {
                    return NSOrderedAscending;
                }
                else {
                    return NSOrderedDescending;
                }
            }];
        }
        
        return imports;
    }();
    
    return sortedImports;
}

@end
