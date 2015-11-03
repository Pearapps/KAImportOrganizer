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

- (instancetype)initWithFileURL:(NSURL *)fileURL importStringTransformer:(id <KAStringTransformer>)importStringTransformer;

- (void)replace;

@end
