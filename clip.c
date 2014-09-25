
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "array.h"

#define INSIDE  0
#define LEFT    1
#define RIGHT   2
#define BOTTOM  4
#define TOP     8

typedef struct polygon polygon;
struct polygon {
  double *x;
  double *y;
  int n;
};

int
outcode(double x, double y, double r[4]) {
  int code = INSIDE;
  if(x < r[0]) {
    code |= LEFT;
  } else if(x > r[1]) {
    code |= RIGHT;
  }
  if(y < r[2]) {
    code |= BOTTOM;
  } else if(y > r[3]) {
    code |= TOP;
  }
  return code;
}


int 
clip_to_rect(double x[2], double y[2], double r[4]) {
  int c0,c1,c2;
  c0 = outcode(x[0],y[0],r);
  c1 = outcode(x[1],y[1],r);
  while(1) {
    if(!(c0 | c1)) {
      return 1;
    }
    if((c0 & c1)) {
      return 0;
    }
    double tx, ty;
    c2 = c0 ? c0 : c1;
    if(c2 & TOP) {
      tx = x[0] + (x[1] - x[0]) * (r[3] - y[0]) / (y[1] - y[0]);
      ty = r[3];
    } else if(c2 & BOTTOM) {
      tx = x[0] + (x[1] - x[0]) * (r[2] - y[0]) / (y[1] - y[0]);
      ty = r[2];
    } else if(c2 & RIGHT) {
      ty = y[0] + (y[1] - y[0]) * (r[1] - x[0]) / (x[1] - x[0]);
      tx = r[1];
    } else if(c2 & LEFT) {
      ty = y[0] + (y[1] - y[0]) * (r[0] - x[0]) / (x[1] - x[0]);
      tx = r[0];
    }

    if(c2 == c0) {
      x[0] = tx;
      y[0] = ty;
      c0 = outcode(x[0],y[0],r);
    } else {
      x[1] = tx;
      y[1] = ty;
      c1 = outcode(x[1],y[1],r);
    }
  }
  return 0;
}

polygon *
polygon_new(double *x, double *y, int n) {
  polygon *p;
  p = (polygon *) malloc(sizeof(polygon));
  p->n = n;
  p->x = (double *) malloc(sizeof(double) * n);
  p->y = (double *) malloc(sizeof(double) * n);
  memcpy(p->x, x, sizeof(double) * n);
  memcpy(p->y, y, sizeof(double) * n);
  return p;
}

#define SET_POINT(x,y,X,Y) do { \
    x = X;                      \
    y = Y;                      \
  } while(0);


polygon **
polyfillrect(double *x, double *y, int n, int positive, double rect[4]) {
  int i, k;
  double xc[2],yc[2];
  double *xp, *yp, *tmp;
  int na;
  double base;

  polygon **P;

  P = xarray_new('p');

  base = (positive) ? rect[2] : rect[3];

  xc[0] = x[0];
  yc[0] = base;
  na = 16;
  xp = (double *) malloc(sizeof(double) * na);
  yp = (double *) malloc(sizeof(double) * na);
  k = 0;

  for(i = 0; i < n; i++) {
    xc[1] = x[i];
    yc[1] = y[i];
    if(clip_to_rect(xc, yc, rect)) {
      
      if(k+3 >= na) {
        na *= 2;
        if(!(tmp = (double *) realloc(xp, sizeof(double) * na))) {
          fprintf(stderr, "Error growing fill buffer\n");
          return NULL;
        }
        xp = tmp;
        if(!(tmp = (double *) realloc(yp, sizeof(double) * na))) {
          fprintf(stderr, "Error growing fill buffer\n");
          return NULL;
        }
        yp = tmp;
      }
      if(k == 0) {
        SET_POINT(xp[k], yp[k], xc[0], base); k++;
      }
      SET_POINT(xp[k], yp[k], xc[0], yc[0]); k++;
      SET_POINT(xp[k], yp[k], xc[1], yc[1]); k++;
    } else {
      if(k > 0) {
        SET_POINT(xp[k], yp[k], xp[k-1], base); k++;
        /* Polygon determined, do something with it */
        P = xarray_append(P, polygon_new(xp,yp,k));
        k = 0;
      }
    }
    xc[0] = x[i];
    yc[0] = y[i];
  }
  if(k > 0) {
    SET_POINT(xp[k], yp[k], xp[k-1], base); k++;
    /* Polygon determine, do something with it */
    P = xarray_append(P, polygon_new(xp,yp,k));
  }
  if(xp) {
    free(xp);
    xp = NULL;
  }
  if(yp) {
    free(yp);
    yp = NULL;
  }
  return P;
}
