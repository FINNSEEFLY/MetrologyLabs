int myfunction(int some) {
    def result;
    result = some + 31;
    if (result < 40) {
        result *= 30
    }
    if (result > 100) {
        result /= 3;
    }
    return result;
}

static void main(String[] args) {
    int x = 0;
    int y = 3;
    int n = 1;
    int[] array;
    array = new int[30];
    for (int i = 0; i <= 30; i++) {
        if (i>10) {
            x += y;
            for (int j = 3; j <= 15; j++) {
                y -= j;
                switch (i){
                    case 1: y++; break;
                    case 2: x++; break;
                    default: x += y;
                }
                for (int k = 0; k<=i; k++) {
                    x -= 1;
                    for (int m = 2; m <= j; m++) {
                        if (m < 5) {
                            x++;
                            y++;
                            while (x < m) {
                                x++;
                                y++;
                            }
                        }
                        else {
                            x -= j;
                            y -= m;
                        }
                    }
                }
            }
        }
        else {
            x +=1
        }
    }
    println ("[" + n + "]")
    for (int i = 0 ; i <= 100; i++) {
        x += i;
        y += x + i + array[y%30]
        if (x + i < 30) {
            x += 5;
            array[y % 30] += y + 20 - i
        } 
        else {
            x -= 10;
            y -= 3
        }
        switch (x) {
            case 1..50: 
                x *= 2;
                if (x > 150) {
                    x /= 3;
                } 
                break;
            case 100..250: 
                while (x < 250) {
                    x *= 3;
                }
                if (x > 1000) {
                    x /= 150;
                }
                else {
                    if (x >= 334) {
                        x -= 34;
                    }    
                } 
                break;
            default: 
                x += 1; break;
                array[x % 30] += 2;
                y += 4
        }
    }
    println ("x = " + x);
    println ("y = " + y);
    for (int i = 0; i < 30; i++) {
        array[i] = myfunction(array[i]);
        println("arr[" + i + "] = " + array[i]);
    }
    while (x > 200) {
        x %= 50;
        y %= 30;
        array[ ( x + y ) % 30 ] % 21;
    }
    n++;
    println ("[" + n + "]")
    for (int i = 0 ; i <= 100; i++) {
        x += i;
        y += x + i + array[y%30]
        if (x + i < 30) {
            x += 5;
            array[y % 30] += y + 20 - i
        } 
        else {
            x -= 10;
            y -= 3
        }
        switch (x) {
            case 1..50: 
                x *= 2;
                if (x > 150) {
                    x /= 3;
                } 
                break;
            case 100..250: 
                while (x < 250) {
                    x *= 3;
                }
                if (x > 1000) {
                    x /= 150;
                }
                else {
                    if (x >= 334) {
                        x -= 34;
                    }    
                } 
                break;
            default: 
                x += 1; break;
                array[x % 30] += 2;
                y += 4
        }
    }
    println ("x = " + x);
    println ("y = " + y);
    for (int i = 0; i < 30; i++) {
        array[i] = myfunction(array[i]);
        println("arr[" + i + "] = " + array[i]);
    }
    while (x > 200) {
        x %= 50;
        y %= 30;
        array[ ( x + y ) % 30 ] % 21;
    }
    n++;println ("[" + n + "]")
    for (int i = 0 ; i <= 100; i++) {
        x += i;
        y += x + i + array[y%30]
        if (x + i < 30) {
            x += 5;
            array[y % 30] += y + 20 - i
        } 
        else {
            x -= 10;
            y -= 3
        }
        switch (x) {
            case 1..50: 
                x *= 2;
                if (x > 150) {
                    x /= 3;
                } 
                break;
            case 100..250: 
                while (x < 250) {
                    x *= 3;
                }
                if (x > 1000) {
                    x /= 150;
                }
                else {
                    if (x >= 334) {
                        x -= 34;
                    }    
                } 
                break;
            default: 
                x += 1; break;
                array[x % 30] += 2;
                y += 4
        }
    }
    println ("x = " + x);
    println ("y = " + y);
    for (int i = 0; i < 30; i++) {
        array[i] = myfunction(array[i]);
        println("arr[" + i + "] = " + array[i]);
    }
    while (x > 200) {
        x %= 50;
        y %= 30;
        array[ ( x + y ) % 30 ] % 21;
    }
    n++;println ("[" + n + "]")
    for (int i = 0 ; i <= 100; i++) {
        x += i;
        y += x + i + array[y%30]
        if (x + i < 30) {
            x += 5;
            array[y % 30] += y + 20 - i
        } 
        else {
            x -= 10;
            y -= 3
        }
        switch (x) {
            case 1..50: 
                x *= 2;
                if (x > 150) {
                    x /= 3;
                } 
                break;
            case 100..250: 
                while (x < 250) {
                    x *= 3;
                }
                if (x > 1000) {
                    x /= 150;
                }
                else {
                    if (x >= 334) {
                        x -= 34;
                    }    
                } 
                break;
            default: 
                x += 1; break;
                array[x % 30] += 2;
                y += 4
        }
    }
    println ("x = " + x);
    println ("y = " + y);
    for (int i = 0; i < 30; i++) {
        array[i] = myfunction(array[i]);
        println("arr[" + i + "] = " + array[i]);
    }
    while (x > 200) {
        x %= 50;
        y %= 30;
        array[ ( x + y ) % 30 ] % 21;
    }
    n++;println ("[" + n + "]")
    for (int i = 0 ; i <= 100; i++) {
        x += i;
        y += x + i + array[y%30]
        if (x + i < 30) {
            x += 5;
            array[y % 30] += y + 20 - i
        } 
        else {
            x -= 10;
            y -= 3
        }
        switch (x) {
            case 1..50: 
                x *= 2;
                if (x > 150) {
                    x /= 3;
                } 
                break;
            case 100..250: 
                while (x < 250) {
                    x *= 3;
                }
                if (x > 1000) {
                    x /= 150;
                }
                else {
                    if (x >= 334) {
                        x -= 34;
                    }    
                } 
                break;
            default: 
                x += 1; break;
                array[x % 30] += 2;
                y += 4
        }
    }
    println ("x = " + x);
    println ("y = " + y);
    for (int i = 0; i < 30; i++) {
        array[i] = myfunction(array[i]);
        println("arr[" + i + "] = " + array[i]);
    }
    while (x > 200) {
        x %= 50;
        y %= 30;
        array[ ( x + y ) % 30 ] % 21;
    }
    n++;
    
}
