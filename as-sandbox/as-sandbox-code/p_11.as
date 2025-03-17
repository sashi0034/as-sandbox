class Vec3 {
    int x;
    int y;
    int z;

    string opAdd_r(const string& in other) {
        return other + "(" + x + ", " + y + ", " + z + ")";
    }
}

void main() {
    Vec3 v1;
    v1.x = 1;

    Vec3 v2;
    v2.y = 2;

    Vec3@ p_v = v1;
    p_v.z = 3;

    // p_v = v2;
    @p_v = v2; // same as @p_v = @v2

    p_v.x = 10;

    println("v1: " + v1);
    println("v2: " + v2);
    println("p_v: " + p_v);
}
