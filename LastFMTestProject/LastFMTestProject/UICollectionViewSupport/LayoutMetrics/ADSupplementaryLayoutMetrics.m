
#import "ADSupplementaryLayoutMetrics.h"

@implementation ADSupplementaryLayoutMetrics

- (instancetype)initWithClass:(Class) supplementaryClass
                   identifier:(NSString *) supplementaryIdentifier
                       useNib:(BOOL)useNib {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.supplementaryClass = supplementaryClass;
    self.reuseIdentifier = supplementaryIdentifier;
    self.useNib = useNib;
    
    return self;
}

- (void) registerWithCollectionView:(UICollectionView *) collectionView supplementaryKind:(NSString *) kind {
    if (self.useNib) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(self.supplementaryClass) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:kind withReuseIdentifier:self.reuseIdentifier];
    } else {
        [collectionView registerClass:self.supplementaryClass forSupplementaryViewOfKind:kind withReuseIdentifier:self.reuseIdentifier];
    }
}

@end
