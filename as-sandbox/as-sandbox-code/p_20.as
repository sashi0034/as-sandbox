class C_0 {
    C_0(int x, int y) {

    }

    void play() {
    }
}

interface IC_1 {
    int get_x() const;
}

class C_1 : C_0, IC_1 {
    C_1(){
        super(1, 2);
    }

    ~C_1(){
        //super();
    }

    void dead(){
    }

    bool opEquals(const C_1& in c1) const {
        return true;
    }

    int get_x() const property {
        return 1;
    }
}

void main() {
    println("hello world");

    C_1 c1;
    C_1@ h1 = c1;

    C_1 cc1;
    C_1@ hh1 = cc1;

    if (h1 !is hh1) {
        println("yes");
    } else {
        println("no");
    }
}
