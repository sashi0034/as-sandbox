namespace Outer {
    namespace Inner {
        enum Color {
            Red = 3,
        }

        enum LED2 {
            Red = 107,
        }

        void a() {
            write_outer_innter_color(Outer::Red); // OK
        }

        void b() {
            write_led(Red);
        }
    }

    void a() {
        write_outer_innter_color(::Red); // OK
        // write_outer_innter_color(Red); // Error
        write_outer_innter_color(Inner::Red); // OK
    }

    enum Color {
        Red = 2,
    }

    enum Score {
        Red
    }
}

namespace A_0 {
    namespace B_0 {
        enum Color {
            Red
        }

        void b() {
            // write_led(Red); // Error
        }
    }
}

enum Color {
    Red = 7,
    Blue = 1,
}

enum LED {
    Red = 103,
}

void write_int(int v) {
    println("value: " + v);
}

void write_int(Color v) {
    println("value: " + v);
}

void write_color(Color c) {
    println("color: " + c);
}

void write_outer_color(Outer::Color c) {
    println("color: " + c);
}

void write_outer_innter_color(Outer::Inner::Color c) {
    println("color: " + c);
}

void write_led(LED c) {
    println("LED color: " + c);
}

namespace G_0 {
    void fn() {
        Color c =::Red;

        write_outer_innter_color(::Red); // OK

        write_outer_innter_color(Outer::Red); // OK
    }

    enum God {
        Red = 2025,
    }

    enum Color {
        Red = 2,
    }
}

namespace G_1 {
    void fn() {
        write_outer_innter_color(Red); // OK
    }

    enum God {
        Blue = 2025,
    }
}

class Apple {
    string Red;

    void sell() {
        // Color c1 = Red; // Error
        Color c2 =::Red;
    }
}

void main() {
    // int Red = -1;
    // write_int(Red);

    // write_int(Blue);

    write_outer_innter_color(Red); // OK
    // write_outer_innter_color(Outer::Red); // Error
    write_outer_innter_color(Outer::Inner::Red); // OK

    // auto c = Red;

    // println("color: " + c);
}
