class A {
}

class B {
    B opAdd_r(A a) { return B(); }
    B opAdd(A a) { return B(); }

    B opMul_r(A a) { return B(); }
    B opMul(A a) { return B(); }
}

void main() {
    B b;
    A a;

    b = a + b;
    b = b + a;

    b = a * b;
    b = b * a;

    println("Compiled successfully!");
}
