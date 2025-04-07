namespace C_0 {
    void global_fn() {
        Action@ a = C_0::global_fn;
    }
}

class C_0 {
    void fn() {
        C_0::global_fn();

        Action@ a = C_0::global_fn;
    }

    funcdef void Action();
}

void main() {

}
