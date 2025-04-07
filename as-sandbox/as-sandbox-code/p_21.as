class A {
    A(string str) {
    }
}

void fn(A@ a) {
    println("fn called");
}

void main() {
    fn("");
}
