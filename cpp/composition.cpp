int g(int x) {
    return x * x;
}

int f(int x, int y) {
    return x + y;
}

extern "C" int main() {
    return g(f(1, 2)); // 9
}
