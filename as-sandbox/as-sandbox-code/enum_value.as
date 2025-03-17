enum Color {
    Red = 10,
    Blue
}

namespace Color {
    const int Red2 = 20;
}

namespace Color {
    const int Red3 = 30;
}

enum Animal {
    Red
}

namespace Internal {
    enum Color {
        Red
    }

    void push() { }
}

namespace Internal::detail {
    enum Color {
        Red
    }
}

string str_animal(Animal a) {
    return "Animal";
}

void main() {
    int v1;

    const auto a = Color::Red2;
    println("" + a);

    const auto blue = Blue;
    // const auto red = Red;

    int v = 1 + blue;
    Color c0 = Red;
    Color c1 = Color(0);
    Internal::Color c2 = Red; // Color(Red);

    println(str_animal(Red));

    println("value: " + c1);
}
