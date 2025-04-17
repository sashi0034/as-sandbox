IBox@ get() {
    return CBox();
}

class IBox {
    int get_size() property {
        return 0;
    }
}

class CBox : IBox {
    private int _size = 10;

    int size = 2;

    int get_size() property override {
        return _size;
    }
}

void main() {
    IBox@ box = CBox();

    println("Box size: " + box.size);
}
