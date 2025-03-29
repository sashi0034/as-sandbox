class A {
    int get() {
        return A::g_value;
    }
}

namespace A {
    int g_value;
}

void main() {
    A a;
    println("value: " + a.get());
}
