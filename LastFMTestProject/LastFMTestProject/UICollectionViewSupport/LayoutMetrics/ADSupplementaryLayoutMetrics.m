
#import "ADSupplementaryLayoutMetrics.h"

@implementation ADSupplementaryLayoutMetrics

- (void) registerWithCollectionView:(UICollectionView *) collectionView supplementaryKind:(NSString *) kind {
    if (self.useNib) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(self.supplementaryClass) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:kind withReuseIdentifier:self.reuseIdentifier];
    } else {
        [collectionView registerClass:self.supplementaryClass forSupplementaryViewOfKind:kind withReuseIdentifier:self.reuseIdentifier];
    }
}

@end
