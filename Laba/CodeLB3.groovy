static void main(String[] args) {

    Scanner scanner = new Scanner(System.in);
    int x;
    int Res = 0;
    int n = 1;
    int y = 1;
    int b = 1;
    x = scanner.nextInt();
    for (int i = 0; i < 10; i++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (i>5) {
            Res += x*n;
            x--;
        }
    }
    for (int j = 0; j < 10; j++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (j>5) {
            Res += x*n;
            x--;
        }
    }
    for (int f = 0; f < 10; f++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (f>5) {
            Res += x*n;
            x--;
        }
    }
    for (int ij = 0; ij < 10; ij++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (ij>5) {
            Res += x*n;
            x--;
        }
    }
    for (ij = 0; ij < 10; ij++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (ij>5) {
            Res += x*n;
            x--;
        }
    }
    for (int tm = 0; tm < 10; tm++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (tm>5) {
            Res += x*n;
            x--;
        }
    }
    for (int op = 0; op < 10; op++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (op>5) {
            Res += x*n;
            x--;
        }
    }
    for (int dl = 0; dl < 10; dl++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (dl>5) {
            Res += x*n;
            x--;
        }
    }
    for (int sl = 0; sl < 10; sl++) {
        Res += y;
        y *= 3;
        if (Res < 13) {
            Res--;
            y /= 2;
        }
        while (b <= 10) {
            Res -= 3;
            b++;
            if (n > -5) {
                Res++;
                n++;
            }
        }
        if (sl>5) {
            Res += x*n;
            x--;
        }
    }
    println(Res);
    scanner.close(); 
}
