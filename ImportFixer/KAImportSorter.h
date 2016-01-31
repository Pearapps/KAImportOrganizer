//
//  KAImportSorter.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KAImportStatement.h"
#import "KAImportTypeModel.h"

@interface KAImportSorter : NSObject

- (nonnull instancetype)initWithImports:(nonnull NSArray <KAImportStatement *> *)imports sortOrderOfImportType:(nullable NSArray <KAImportTypeModel *> *)sortOrderOfImportType;

- (nonnull NSArray *)sortedImports;

@end
