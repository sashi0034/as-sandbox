void f_1(array<int>& a) {
    a[0] = 100;
}

void f_2(array<array<int>>& a) {
    a[0][0] = 200;
}

void main() {
    array<int> a1 = { 1 };
    f_1(a1);
    println("value: " + a1[0]);

    array<array<int>> a2 = { { 2 } };
    f_2(a2);
    println("value: " + a2[0][0]);
}
