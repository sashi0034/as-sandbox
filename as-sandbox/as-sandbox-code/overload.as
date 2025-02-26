void add_value(int a, int b) {
    const int v = a + b;
    println("[int] a + b = " + v);
}

void add_value(float a, float b) {
    const float v = a + b;
    println("[float] a + b = " + v);
}

void add_value(double a, double b) {
    const double v = a + b;
    println("[double] a + b = " + v);
}

void main() {
    add_value(1, 2);
    add_value(1.1f, 2.1f);
    add_value(1.2, 2.2);

    const bool gt = 3.0 >= 2.0;
    println(gt ? "True" : "False");
}
