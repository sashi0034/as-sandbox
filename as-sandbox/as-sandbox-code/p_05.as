class C_0 {
    int v;

    // int opConv() {
    //     return v;
    // }

    int opImplConv() {
        return v;
    }
}

class C_1 {
    C_0 opImplConv() {
        C_0 c;
        c.v = 1;
        return c;
    }
}

class C_2 {
    C_1 opImplConv() {
        return C_1();
    }
}

enum Kind {
    k_A = 3
}

void main() {
    C_1 c1;
    C_0 c = c1;
    int i0 = c; // int(c);
    auto i = 1.1f + c;
    auto ka = k_A;

    string str = "";
    str += "1";

    println("Compiled successfully: " + i);
}
