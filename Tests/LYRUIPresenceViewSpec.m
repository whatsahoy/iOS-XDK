#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>
#import <Foundation/Foundation.h>
#import <Atlas/LYRUIPresenceView.h>
#import <Atlas/LYRUIConfiguration+DependencyInjection.h>
#import <Atlas/LYRUIPresenceViewConfiguration.h>

SharedExamplesBegin(LYRUIPresenceView)

sharedExamplesFor(@"setting presence view identities using view configuration", ^(NSDictionary *data) {
    __block NSObject<LYRUIPresenceViewTheme> *themeMock;
    __block LYRUIPresenceViewConfiguration *viewConfigurationMock;
    __block LYRUIPresenceView *presenceView;
    __block NSArray *identities;
    
    beforeEach(^{
        themeMock = data[@"theme"];
        viewConfigurationMock = data[@"viewConfiguration"];
        presenceView = data[@"presenceView"];
        
        LYRIdentity *identityMock1 = mock([LYRIdentity class]);
        LYRIdentity *identityMock2 = mock([LYRIdentity class]);
        identities = @[identityMock1, identityMock2];
        presenceView.identities = identities;
    });
    
    it(@"should setup view using configuration", ^{
        [verify(viewConfigurationMock) setupPresenceView:presenceView withIdentities:identities usingTheme:themeMock];
    });
});

SharedExamplesEnd

SpecBegin(LYRUIPresenceView)

describe(@"LYRUIPresenceView", ^{
    __block LYRUIConfiguration *configurationMock;
    __block id<LYRUIDependencyInjection> injectorMock;
    __block NSObject<LYRUIPresenceViewTheme> *themeMock;
    __block LYRUIPresenceViewConfiguration *viewConfigurationMock;
    __block LYRUIPresenceView *presenceView;
    __block NSMutableDictionary *sharedContext = [NSMutableDictionary new];

    beforeEach(^{
        configurationMock = mock([LYRUIConfiguration class]);
        injectorMock = mockProtocol(@protocol(LYRUIDependencyInjection));
        [given(configurationMock.injector) willReturn:injectorMock];
        
        themeMock = mockObjectAndProtocol([NSObject class], @protocol(LYRUIPresenceViewTheme));
        [[given([(id<NSCopying>)themeMock copyWithZone:NSDefaultMallocZone()]) withMatcher:anything()] willReturn:themeMock];
        [given([injectorMock themeForViewClass:[LYRUIPresenceView class]]) willReturn:themeMock];
        
        viewConfigurationMock = mock([LYRUIPresenceViewConfiguration class]);
        [given([injectorMock configurationForViewClass:[LYRUIPresenceView class]]) willReturn:viewConfigurationMock];
        
        sharedContext[@"theme"] = themeMock;
        sharedContext[@"viewConfiguration"] = viewConfigurationMock;
    });

    afterEach(^{
        [sharedContext removeAllObjects];
        presenceView = nil;
        viewConfigurationMock = nil;
        themeMock = nil;
        configurationMock = nil;
    });
    
    context(@"when initialized with configuration", ^{
        beforeEach(^{
            presenceView = [[LYRUIPresenceView alloc] initWithConfiguration:configurationMock];
            sharedContext[@"presenceView"] = presenceView;
        });
        
        describe(@"after initialization", ^{
            it(@"should have proper theme set", ^{
                expect(presenceView.theme).to.equal(themeMock);
            });
            itShouldBehaveLike(@"setting presence view identities using view configuration", sharedContext);
        });
    });
    
    context(@"when configuration is set after initialization", ^{
        beforeEach(^{
            presenceView = [[LYRUIPresenceView alloc] init];
            presenceView.layerConfiguration = configurationMock;
            sharedContext[@"presenceView"] = presenceView;
        });
        
        describe(@"after initialization", ^{
            it(@"should have proper theme set", ^{
                expect(presenceView.theme).to.equal(themeMock);
            });
            itShouldBehaveLike(@"setting presence view identities using view configuration", sharedContext);
        });
    });
});

SpecEnd