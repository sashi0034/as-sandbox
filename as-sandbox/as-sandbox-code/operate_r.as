class A {
    B opAdd_r(B b) { println("A::opAdd_r"); return B(); }
    B opAdd(B b) { println("A::opAdd"); return B(); }

    // B opMul_r(B b) { return B(); }
    // B opMul(B b) { return B(); }
}

class A1 : A{}

funcdef int AddHandler(int, int);

class B {
    B opAdd_r(A a) { println("B::opAdd_r"); return B(); }
    B opAdd(A a) { println("B::opAdd"); return B(); }

    B opAdd(A1 a) { println("B::opAdd (1)"); return B(); }

    B opMul_r(A a) { return B(); }
    B opMul(A a) { return B(); }

    int opAdd_r(int a) { return 0; }

    int opAdd(AddHandler@ a) { println("B::opAdd: " + a(13, 11)); return 1; }
}

void main() {
    B b;
    A1 a;
    b = a + b;
    b = b + a;

    b = a * b;
    b = b * a;

    uint16 v1 = 1;
    const auto v2 = v1 + b;

    AddHandler@ h = function(a, b) { return a + b; };
    b + h;

    println("Compiled successfully!");
}
