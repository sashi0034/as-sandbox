class Value {
    int v;

    int opImplConv() const {
        return v;
    }
}

void named_0(int a, int b, Value& out c = void) {
    println("named_0: " + a + ", " + b + "=" + (a + b));

    c.v = a ** b;
}

class B {
    int v;

    B(int v = 0) {
        this.v = v;
    }
}

class C {
    int v;

    C() { }

    C(B b) {
        this.v = b.v;
    }
}

void named_1(int a, B b = B(15), int c = 20) {
    println("[named_1] " + a + ", " + b.v + ", " + c);
}

void named_1(int a, float c = 0){
    println("dummy");
}

void main() {
    Value value;
    named_0(4, 2, value);
    println("c: " + value.v);

    named_1(a: 10, c: 2);

    B b;
    C c = b;
}
