#include <stdio.h>
#include "foo.h"

int main(void) {
    printf("%s\n", "test of shared library");
    printf ("%d\n", number);
    foo();
    return 0;
}
