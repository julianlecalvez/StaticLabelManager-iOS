//
//  StaticLabelManagerTests.m
//  StaticLabelManagerTests
//
//  Created by Julian Le Calvez on 02/09/2015.
//  Copyright (c) 2014 Julian Le Calvez. All rights reserved.
//

#import "SLMTestHelper.h"

SpecBegin(InitialSpecs)

describe(@"will fail", ^{
    beforeAll(^{
        [SLMTestHelper clearSLMFolder];
        [Expecta setAsynchronousTestTimeout:3];
    });
    
    it(@"updates labels without config", ^{
        expect(^{
            [SLMTestHelper clearSLMFolder];
            [[SLManager sharedManager] update];
        }).to.raise(@"SLManagerConfigurationError");
    });
});

describe(@"will pass", ^{
    beforeAll(^{
        [SLMTestHelper clearSLMFolder];
        [Expecta setAsynchronousTestTimeout:3];
    });
    
    it(@"create singleton", ^{
        expect([SLManager sharedManager]).toNot.beNil();
    });
    
    it(@"get first label", ^{
        expect([[SLManager sharedManager] get:@"test" withDefault:@"###"]).to.equal(@"embbed");
    });
    
    it(@"updates labels with bad config", ^{
        expect(^{
            [SLManager sharedManager].versionFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/bversion.txt"];
            [SLManager sharedManager].labelsFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels.strings"];
            [[SLManager sharedManager] update];
        }).toNot.raiseAny();
    });
    
    it(@"updates labels with good config", ^{
        expect(^{
            [SLManager sharedManager].versionFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/version.txt"];
            [SLManager sharedManager].labelsFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels.strings"];
            [[SLManager sharedManager] update];
        }).toNot.raiseAny();
    });
    
    it(@"get updated label", ^{
        expect([[SLManager sharedManager] get:@"test1" withDefault:@"###"]).will.equal(@"test 1");
    });
    
    it(@"updates labels with new version", ^{
        expect(^{
            [SLManager sharedManager].versionFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/version2.txt"];
            [SLManager sharedManager].labelsFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels2.strings"];
            [[SLManager sharedManager] update];
        }).toNot.raiseAny();
    });
    
    it(@"get not updated label yet", ^{
        expect([[SLManager sharedManager] get:@"test1" withDefault:@"###"]).to.equal(@"test 1");
    });
    it(@"get second updated label", ^{
        expect([[SLManager sharedManager] get:@"test1" withDefault:@"###"]).will.equal(@"essai 1");
    });
});

SpecEnd
