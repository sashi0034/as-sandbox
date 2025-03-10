
class Gen0 {
    int v;
}

class Gen1 : Gen0{
}

class Gen2 : Gen1{
}

void test_inherit(Gen0 gen0) {
    println("Gen0");
}

void test_inherit(Gen1 gen1) {
    println("Gen1");
}

// void test_inherit(Gen2 gen2) {
//     println("Gen2");
// }

void main() {
    Gen0 gen0 = Gen0();
    Gen1 gen1 = Gen1();
    Gen2 gen2 = Gen2();

    test_inherit(gen0);
    test_inherit(gen1);
    test_inherit(cast<Gen0>(gen2));
}
