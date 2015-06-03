#import <Foundation/Foundation.h>
#import "MTLModel+JSON.h"
#import <MTLJSONAdapter.h>


@implementation MTLModel (JSON)


+ (instancetype)modelWithJSON:(NSDictionary *)JSONdictionary
{
    NSError *error = nil;
    id instance = [self modelWithJSON:JSONdictionary error:&error];
    if (!instance && error) {
        [NSException raise:@"Error creating instance from JSON" format:@"%@", error];
    }
    return instance;
}

+ (instancetype)modelWithJSON:(NSDictionary *)JSONdictionary error:(NSError **)error
{
    id initialObject = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:JSONdictionary error:error];


    // For some feed items we're given the feed item JSON and object it represents
    // in the same JSON structure, to deal with this we allow declaring it as a host object.
    // This means sending the same JSON data to property on the feed item class itself.
    return initialObject;
}

@end
