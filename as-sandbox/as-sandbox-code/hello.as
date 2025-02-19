
#include "constants.as"

void main() {
    println('Hello, World!');

    const double v = sin(1.0);
    const string s1 = "sin(1.0) = " + v;
    println(s1);

    const string s2 = "pi = " + Constants::Pi;
    println(s2);
}
