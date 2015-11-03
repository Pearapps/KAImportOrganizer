//
//  KAImportReplacer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

@class KAImportStatement;
@protocol KAStringTransformer;

@interface KAImportReplacer : NSObject

- (instancetype)initWithFileURL:(NSURL *)fileURL imports:(NSArray *)imports numbersOfNewlines:(NSArray *)numbersOfNewlines originalContents:(NSString *)originalContents;

// @return The number of imports that were sorted.
- (NSInteger)replace;

@end
