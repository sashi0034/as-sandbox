class C_0 {
    int v = 0;
}

class C_1 : C_0 {
}

void main() {
    array<int32> a = { 1, 2 };

    array<int> b = a;

    array<array<int>> v1 = { };

    array<array<int>> v2 = v1;

    array<const C_1> cv1 = { };

    array<const C_1>@ cv2 = @cv1;

    // C_1 d;
    // C_0@ p_d = @d;
    // p_d.v = 20;
    // println("d: " + d.v);

    bool b_f = false;

    // b_f = a[0];
    // b[0] = int(b_f);

    println("value: " + b[0]);
}
