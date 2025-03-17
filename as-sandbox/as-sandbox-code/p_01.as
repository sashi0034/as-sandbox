funcdef int ValueGetter(int, int);

funcdef int ValueGetter2(int, int);

int add(int a, int b) {
// int add(int a, int b) {
    return a + b;
}

double add_f(double a, double b) {
    return a + b;
}

class C_0 {
    int m_v;
    C_0(int v = 0) {
        this.m_v = v;
    }

    int32 added_c0(C_0 other) {
        return m_v + other.m_v;
    }
}

class C_1 : C_0 {
    C_1() {
        super(1);
    }

    int added_c1(C_1 other) {
        return m_v + other.m_v;
    }
}

funcdef int CustomGetter(C_0);

void main() {
    {
        ValueGetter@ vg = add;
        ValueGetter2@ vg2 = vg;
        int a = vg2(1, 2);
        println("value: " + a);
    }

    {
        ValueGetter@ vg = function(a, b) { return int(add_f(a, b)); }; // { return add_f(a, b); };
        int a = vg(3, 4);
        println("value: " + a);
    }

    {
        C_1 c;
        CustomGetter@ cg = CustomGetter(c.added_c0);
        println("value: " + cg(c));
    }
}
