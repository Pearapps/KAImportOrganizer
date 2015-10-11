//
//  KAImportSorter.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KAImportStatement.h"

@interface KAImportSorter : NSObject

- (instancetype)initWithImports:(NSArray <NSString *> *)imports;

- (NSArray *)sortedImports;

@end
