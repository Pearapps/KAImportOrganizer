//
//  KAImportReplacer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

@class KAImportStatement;
@interface KAImportReplacer : NSObject

- (instancetype)initWithOriginalImports:(NSArray <KAImportStatement *> *)originalImports sortedImportStatements:(NSArray <KAImportStatement *> *)sortedImportStatements fileURL:(NSURL *)fileURL numberOfNewlines:(NSInteger)numberOfNewlines originalContents:(NSString *)originalContents;

- (void)replace;

@end
