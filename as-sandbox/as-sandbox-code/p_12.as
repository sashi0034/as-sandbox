class Unit {
    int v;

    Unit(int v) {
        this.v = v;
    }
}

interface I_0 {
    int get();

    Unit unit(Unit);
}

int g_val = 3;

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
}

C_0 g_c0();

void main() {
    C_0 c0 = C_0();

    g_c0.value = c0.get();

    int f = int(1);

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
    }

    println("Finish!");
}
