
int f(int x, int y) {
    return x + y;
}

extern "C" int main() {
    return f(1, 2);
}
