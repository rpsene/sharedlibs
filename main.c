#include <stdio.h>
#include "foo.h"

int main(void) {
    printf("%s", "test of shared library");
    printf ("%d", number);
    foo();
    return 0;
}
