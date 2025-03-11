class Ant {
    int m_v;

    Ant(int v = 0) {
        this.m_v = v;
    }
}

class Box {
    Ant a;

    Box(Ant a = Ant()) {
        this.a = a;
    }
}

class Coin {
    Box b;

    Coin(Box b = Box()) {
        this.b = b;
    }
}

void main() {
    // Ant a = Ant(1);

    Coin b = Box(3);
    println("v: " + b.b.a.m_v);
}
