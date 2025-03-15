class C_0 {

}

class C_1 {
    C_1() { }

    C_1(C_0 c) {
#if EXPR

#endif
    }
}

[Directives in metadata --> #include "This is not included because it is in the meta data."]
class C_2 {
    C_2() { }

    C_2(C_1 c) {
    }
}

[Parse(にゃんぱすー) [123, 23, 3]]
void main() {
    C_0 c0;

    C_1 c1 = c0;

    println("Compiled successfully");
}
