void bmp_grid (unsigned char *imgptr, long long width, long long height, long long gap){

    int remain = width * 3 & 0b11;
    long long h = 0;
    if (remain > 0)
        remain = 4 - remain;

    height--;
    imgptr += height * (remain + width * 3);

    for (int i=0; i<=height; i++){
        unsigned char *simgptr = imgptr;
        int j = 0;
        while (j < width){
            *imgptr = 0;
                imgptr += 1;
                *imgptr = 0;
                imgptr += 1;
                *imgptr = 255;
            if (i == h)
                imgptr += 1
            else
                imgptr += (gap-1) * 3 + 1;
        }
        if (i == h){
            h += gap;
            imgptr = simgptr - (width * 3 + remain);
        }
        else
            imgptr = simgptr - (width * 3 + remain);


        // if (i == h){
        //  for (int j=0; j<width; j++){
        //      *imgptr = 0;
        //      imgptr += 1;
        //      *imgptr = 0;
        //      imgptr += 1;
        //      *imgptr = 255;
        //      imgptr += 1;
        //  }
        //  h += gap;
        //  imgptr = simgptr - (width * 3 + remain);
        // }
        // else {
        //  for (int j=0; j<width; j+= gap){
        //      *imgptr = 0;
        //      imgptr += 1;
        //      *imgptr = 0;
        //      imgptr += 1;
        //      *imgptr = 255;
        //      imgptr += (gap-1) * 3 + 1;
        //  }
        //  imgptr = simgptr - (width * 3 + remain);
        // }
    }


    // h = 0;
    // for (int i=0; i<height; i++){
    //  imgptr = simgptr;
    //  if (i == h)
    //      h+= gap;
    //  for (int j=0; j<width; j+= gap){
    //          *imgptr = 0;
    //          imgptr += 1;
    //          *imgptr = 0;
    //          imgptr += 1;
    //          *imgptr = 255;
    //          imgptr += (gap-1) * 3 + 1;
    //      }
    //      simgptr += width * 3 + remain;
    // }
}