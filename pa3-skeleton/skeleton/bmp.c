//---------------------------------------------------------
//
// Project #3: Drawing grid lines in an image
//
// April 30, 2018
//
// Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
// Systems Software & Architecture Laboratory
// Dept. of Computer Science and Engineering
// Seoul National University
//
//---------------------------------------------------------


#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include "bmp.h"


struct bmp_info b;

int bmp_in (char *bmpfile)
{
	int fd;
	int inbytes, rc;
	bmp_header *bh;
	bi_header *bi;

	if ((fd = open (bmpfile, O_RDONLY)) < 0)
	{
		printf ("Error: cannot open file %s.\n", bmpfile);
		return -1;
	}

	b.filesize = (int) lseek (fd, 0, SEEK_END);
	lseek (fd, 0, SEEK_SET);

	b.memptr = (unsigned char *) malloc (b.filesize);
	if (b.memptr == NULL)
	{
		printf ("Error: not enough memory (size = %d).\n", b.filesize);
		return -2;
	}

	inbytes = 0;
	while (inbytes < b.filesize)
	{
		if ((rc = read (fd, b.memptr + inbytes, b.filesize - inbytes)) < 0)
		{
			printf ("Error: file read error.\n");
			return -3;
		}
		inbytes += rc;
	}

	bh = (bmp_header *) b.memptr;
	b.offset = (bh->offset_high << 16) | bh->offset_low;
	if (bh->magic != BMP_MAGIC)
	{
		printf ("Error: file \"%s\" is not in BMP format.\n", bmpfile);
		return -4;
	}
	if (((bh->length_high << 16) | bh->length_low) != b.filesize)
	{
		printf ("Error: file size mismatch (header=%d, actual=%d).\n",
			(bh->length_high << 16) | bh->length_low, b.filesize);
		return -5;
	}

	bi = (bi_header *) (b.memptr + sizeof(bmp_header));
	if (bi->size != BITMAPINFOHEADER)
	{
		printf ("Error: this BMP header type is not supported %d.\n",
			bi->size);
		return -6;
	}
	if (bi->colors_used > 0)
	{
		printf ("Error: color palette is not supported.\n");
		return -7;
	}
	if (bi->compression != BI_RGB)
	{
		printf ("Error: compressed BMP files are not supported.\n");
		return -8;
	}
	if (bi->bitcount != 24)
	{
		printf ("Error: cannot support %d bits/pixel.\n", bi->bitcount);
		return -9;
	}

	printf ("BMP file: %s (%d x %d pixels, %d bits/pixel)\n",
		bmpfile, bi->width, bi->height, bi->bitcount);

	b.imgptr = b.memptr + b.offset;
	b.width = bi->width;
	b.height = bi->height;
	close (fd);

	return 0;
}

int bmp_out (char *outfile)
{
	int fd;
	int outbytes, rc;

	if ((fd = creat (outfile, S_IRWXU)) < 0)
	{
		printf ("Error: cannot create file %s\n", outfile);
		return -10;
	}

	outbytes = 0;
	while (outbytes < b.filesize)
	{
		if ((rc = write (fd, b.memptr + outbytes, b.filesize - outbytes)) < 0)
		{
			printf ("Error: file write error\n");
			return -11;
		}
		outbytes += rc;
	}

	close (fd);

	return 0;
}

void bmp_grid (unsigned char *imgptr, long long width, long long height, long long gap){
	unsigned char *simgptr = imgptr;
	int remain = (width*3 & 0b11);
	long long h = 0;
	if (remain > 0)
		remain = 4 - remain;


	imgptr += height *(remain + width*3); // (0, 0)
	for (int i=0; i<height; i++){
		// printf("%ld\n", imgptr);
		if (i == h){
			imgptr -= remain;
			for (int j=0; j<width; j++){
				imgptr -= 1;
				*imgptr = 255;
				imgptr -= 1;
				*imgptr = 0;
				imgptr -= 1;
				*imgptr = 0;
			}
			h += gap;
			imgptr -= width * (gap-1) * 3 + remain * (gap-1);
			// (gap-1)*(width*3 + remain)
		}
	}
	h = 0;
	for (int i=0; i<height; i++){
		imgptr = simgptr;
		if (i == h)
			h+= gap;
		for (int j=0; j<width; j+= gap){
				*imgptr = 0;
				imgptr += 1;
				*imgptr = 0;
				imgptr += 1;
				*imgptr = 255;
				imgptr += (gap-1) * 3 + 1;
			}
			simgptr += width * 3 + remain;
	}
}

int main (int argc, char *argv[])
{

	if (argc != 4)
	{
		printf ("Usage: %s bmpfile outfile gap\n", argv[0]);
		return 1;
	}

	if (bmp_in (argv[1]) < 0)
		return 2;

	b.gap = atoi(argv[3]);
	if (b.gap <= 0)
	{
		printf ("Invalid gap %lld.\n", b.gap);
		return 3;
	}

	bmp_grid (b.imgptr, b.width, b.height, b.gap);

	if (bmp_out (argv[2]) < 0)
		return 3;


	return 0;
}

