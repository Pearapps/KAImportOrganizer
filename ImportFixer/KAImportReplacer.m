//
//  KAImportReplacer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportReplacer.h"
#import "KAImportStatement.h"
#import "KAStringTransformer.h"

@interface KAImportReplacer ()

@property (nonatomic, readonly) NSURL *fileURL;
@property (nonatomic, readonly) id <KAStringTransformer> importStringTransformer;

@end

@implementation KAImportReplacer

- (instancetype)initWithFileURL:(NSURL *)fileURL importStringTransformer:(id <KAStringTransformer>)importStringTransformer {
    self = [super init];
    
    if (self) {
        _fileURL = fileURL;
        _importStringTransformer = importStringTransformer;
    }
    
    return self;
}

- (void)replace {
#warning Here
   // if (_originalImports.count == 0) { return; }
   // if ([_originalImports isEqual:_sortedImportStatements]) { return; }
    
    [[_importStringTransformer transformedString] writeToURL:self.fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
