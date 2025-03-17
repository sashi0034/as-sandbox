funcdef int add_f(int, int);

class A_0 {
    A_0() {
        @add = add_f(addImpl);
    }

    int v;

    add_f@ add;

    private int addImpl(int a, int b) {
        v += a + b;
        return v;
    }
}

void main() {
    A_0 a0;

    // @a0.add = add_f(a0.addImpl);
    // add_f@ af = add_f(a0.addImpl);

    int added = a0.add(1, 2);

    println("added: " + added);
}
