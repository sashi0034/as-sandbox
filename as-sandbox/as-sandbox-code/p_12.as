class Unit {
    int v;

    Unit(int v) {
        this.v = v;
    }
}

class Empty { }

interface I_0 {
    int get();

    Unit unit(Unit);
}

int g_val = 3;

// blank line

// This is a value class
class C_0 : I_0 {
    int value;

    Unit m_unit(g_val);

    Unit unit(Unit) {
        return Unit(1);
    }

    int get(){
        return value;
    }

    bool opImplConv() const {
        return true;
    }

    int opImplConv(){
        return value;
    }

    // C_0 opImplCast(const C_0& c0) const {
    //     return this;
    // }
}

enum Kind {
    A,
    B,
    C
}

C_0 g_c0();

void main() {
    bool b = bool(false);
    Kind kk = Kind(Kind(2));
    C_0 c0 = C_0();

    g_c0.value = c0.get();

    c0.value = int(0);

    int f = int(c0);
    println("f: " + f);

    C_0@ hc = c0;

    // bool f = hc && c0;

    // if (c0) {
    //     println("value: " + hc.value);
    // }

    {
        flag_t flag = true;
        if (flag) {
            println("value: " + hc.value);
        }

        if (flag ^^ bool(flag)) {
            println("ok");
        }
    }

    println("Finish!");
}
