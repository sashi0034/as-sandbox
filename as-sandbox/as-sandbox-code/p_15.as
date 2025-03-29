class C_0 {
    C_0(int x, int) { }
}

class C_1 : C_0 {
    C_1() {
        super(1, 2);

        println('C_1 constructor called');
    }

    int check(C_0@ c) {
        C_0@ c1 = c;
        C_1@ c2 = cast<C_1>(c);
        return 0;
    }
}

void main() {
    C_1 c1;
    C_0 c0(10, 1);
    c1.check(c0);
    println('C_1 constructor called');
}
