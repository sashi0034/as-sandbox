enum Color {
    Red
}

enum Animal {
    Red
}

namespace Internal {
    enum Color {
        Red
    }
}

string str_animal(Animal a) {
    return "Animal";
}

void main() {
    Color c0 = Red;
    Color c1 = Color(0);
    Internal::Color c2 = Red; // Color(Red);

    println(str_animal(Red));

    println("value: " + c1);
}
