
#include "constants.as"

int fox(int n) {
    int sum = 0;

    for (int i = 0; i < n; i++) {
        sum += i;
    }

    for (int i = 0; i < n; i++) {
        sum += i * 2;
    }

    if (n == 0) {
        const int v = 1;
        sum += v;
    } else if (n == 1) {
        const int v = 2;
        sum += v;
    }

    return sum;
}

void main() {
    println('Hello, World!');

    const double v = sin(1.0);
    const string s1 = "sin(1.0) = " + v;
    println(s1);

    const auto s2 = "pi = " + Constants::Pi;
    println(s2);
    // println(message: s2);

    println("" + fox(10));

    println("[info] finished!"); // [info]
}
