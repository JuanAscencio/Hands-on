int x;
int suma(int a, int b)
{
    int r;
    r = a + b;
    return r;
}

int main()
{
    int y;
    x = 3;
    y = suma(x, 5);
    z = 10; // variable no declarada (error)
    return 0;
}