dictionary get_d() {
    dictionary d;
    d["a"] = 11;
    d["b"] = 23;
    d["c"] = "c"; // 31
    d["d"] = 41;
    d["e"] = 53;
    return d;
}

void main() {
    array<bool> flags;
    flags.resize(5);
    flags[0] = true;

    foreach (const auto v, const auto i : flags) {
        println("Value: " + v + ", Index: " + i);
    }

    dictionary d;
    d["a"] = 11;
    d["b"] = 23;
    d["c"] = "c"; // 31
    d["d"] = 41;
    d["e"] = 53;

    foreach (const auto value, const auto key: get_d()) {
        println("Key: " + key + ", Value: " + int64(value));
    }
}
