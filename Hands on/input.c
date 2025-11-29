int globalA;
int addValues(int a, int b)
{
    int result;
    result = a + b * 2;
    return result;
}

int main()
{
    int x, y;
    x = 1;
    y = addValues(x, 3);
    return 0;
}