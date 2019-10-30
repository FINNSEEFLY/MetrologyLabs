    for (int i = 0; i <= 30; i++) {
        if (i>10) {
            x += y;
            for (int j = 3; j <= 15; j++) {
                y -= j;
                switch (i){
                    case 1: y++; break;
                    case 2: x++; break;
                    default: x += y; break;
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