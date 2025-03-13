class A {
    B opAdd_r(B b) { println("A::opAdd_r"); return B(); }
    B opAdd(B b) { println("A::opAdd"); return B(); }

    B opMul_r(B b) { return B(); }
    B opMul(B b) { return B(); }
}

class A1 : A{}

class B {
    B opAdd_r(A a) { println("B::opAdd_r"); return B(); }
    B opAdd(A a) { println("B::opAdd"); return B(); }

    B opMul_r(A a) { return B(); }
    B opMul(A a) { return B(); }

    int opAdd_r(int a) { return 0; }
}

void main() {
    B b;
    A a;

    b = a + b;
    b = b + a;

    b = a * b;
    b = b * a;

    uint16 v1 = 1;
    const auto v2 = v1 + b;

    println("Compiled successfully!");
}
