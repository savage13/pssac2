
#include <gmt.h>
#include "array.h"

struct GMT_DATASEGMENT *
gmt_datasegment(  ) {
  int i;
  struct GMT_DATASEGMENT *seg = (struct GMT_DATASEGMENT *) malloc(sizeof(struct GMT_DATASEGMENT));
  seg->n_columns = 2;
  seg->n_rows = 0;
  seg->min = (double *) malloc(sizeof(double) * seg->n_columns);
  seg->max = (double *) malloc(sizeof(double) * seg->n_columns);
  for(i = 0; i < (int)seg->n_columns; i++) {
    seg->min[i] =  1e37;
    seg->max[i] = -1e37;
  }
  seg->coord = NULL;
  seg->label = NULL;
  seg->header = NULL;
  seg->mode = 0;
  seg->pol_mode = 0;
  seg->id = -1;
  seg->n_alloc = 2;
  seg->range = 0;
  seg->pole = 0;
  seg->dist = 0;
  seg->lat_limit = 0;
  seg->ogr = NULL;
  seg->next = NULL;
  seg->file[0] = NULL;
  seg->file[1] = NULL;
  return seg;
}

void
gmt_datasegment_alloc(struct GMT_DATASEGMENT *seg, int cols, int rows) {
  uint64_t i;
  if(!seg) {
    return;
  }
  seg->n_columns = cols;
  seg->n_rows = rows;
  seg->coord = (double **) malloc(sizeof(double *) * seg->n_columns);
  for(i = 0; i < seg->n_columns; i++) {
    seg->coord[i] = (double *) malloc(sizeof(double) * seg->n_rows);
  }
}

void
gmt_dataset_append_datasegment(struct GMT_DATASET *data, struct GMT_DATASEGMENT *seg, uint64_t table) {
  struct GMT_DATATABLE *T;
  if(!data || !seg) {
    return;
  }
  if(table >= data->n_tables) {
    return;
  }
  T = data->table[table];
  if(T->segment == NULL) {
    T->segment = xarray_new('p');
  }
  T->segment = xarray_append(T->segment, seg);
  T->n_segments += 1;
  T->n_records += seg->n_rows;

  data->n_segments += 1;
  data->n_records += seg->n_rows;

}

struct GMT_DATATABLE *
gmt_datatable() {
  int i;
  struct GMT_DATATABLE *table;
  table = (struct GMT_DATATABLE *) malloc(sizeof(struct GMT_DATATABLE ));
  table->n_headers = 0;
  table->n_columns = 2;
  table->n_segments = 0;
  table->n_records = 0;
  table->min = (double *) malloc(sizeof(double) * table->n_columns);
  table->max = (double *) malloc(sizeof(double) * table->n_columns);
  for(i = 0; i < (int)table->n_columns; i++) {
    table->min[i] =  1e37;
    table->max[i] = -1e37;
  }
  table->header = NULL;
  table->n_alloc = 0;
  table->segment = NULL;
  table->mode = 0;
  table->ogr = NULL;
  table->file[0] = NULL;
  table->file[1] = NULL;
  return table;
}

void
gmt_dataset_append_datatable(struct GMT_DATASET *data, struct GMT_DATATABLE *table) {
  if(!data || !table) {
    return;
  }
  if(data->table == NULL) {
    data->table = xarray_new('p');
  }
  data->table = xarray_append(data->table, table);
  data->n_tables += 1;
}

struct GMT_DATASET *
gmt_dataset() {
  int i;
  struct GMT_DATASET* data;
  data = (struct GMT_DATASET*) malloc(sizeof(struct GMT_DATASET));
  data->n_tables   = 0;
  data->n_columns  = 2;
  data->n_segments = 0;
  data->n_records  = 0;
  data->min = (double *) malloc(sizeof(double) * data->n_columns);
  data->max = (double *) malloc(sizeof(double) * data->n_columns);
  for(i = 0; i < (int)data->n_columns; i++) {
    data->min[i] =  1e37;
    data->max[i] = -1e37;
  }
  data->table = NULL;
  data->n_alloc = 0;
  data->alloc_mode = 0;
  data->alloc_level = -42;
  return data;
}

struct GMT_VECTOR *
GMT_vector(int ncols, int nrows, enum GMT_enum_type type, int filled) {
  struct GMT_VECTOR *V;
  int i;
  V = (struct GMT_VECTOR *) malloc(sizeof(struct GMT_VECTOR));
  V->alloc_mode = 0;
  V->n_columns = ncols;
  V->type = (enum GMT_enum_type *) malloc(sizeof(enum GMT_enum_type) * ncols);
  for(i = 0; i < ncols; i++) {
    V->type[i] = type;
  }
  V->data = (union GMT_UNIVECTOR *) malloc(sizeof(union GMT_UNIVECTOR) * ncols);
  if(filled) {
    V->n_rows = nrows;
  } else {
    V->n_rows = 0;
  }
  for(i = 0; i < ncols; i++) {
    if(type == GMT_FLOAT) {
      V->data[i].f4 = malloc(sizeof(float) * nrows);
    }
    if(type == GMT_DOUBLE) {
      V->data[i].f8 = malloc(sizeof(double) * nrows);
    }
  }
  return V;
}

void
pvec(struct GMT_VECTOR *V) {
  int i,j;
  for(j = 0; j < (int) V->n_rows; j++) {
    fprintf(stderr, "%d: ", j);
    for(i = 0; i < (int) V->n_columns; i++) {
      if(V->type[i] == GMT_FLOAT) {
        fprintf(stderr, "%e ", V->data[i].f4[j]);
      }
      if(V->type[i] == GMT_DOUBLE) {
        fprintf(stderr, "%e ", V->data[i].f8[j]);
      }
    }
    fprintf(stderr, "\n");
  }
}

struct GMT_VECTOR *
C_to_GMT_vector(double *x, double *y, int n) {
  struct GMT_VECTOR *V;
  V = GMT_vector(2, n, GMT_DOUBLE, 1);
  if(x) {
    V->data[GMT_X].f8 = x;
  }
  if(y) {
    V->data[GMT_Y].f8 = y;
  }
  return V;
}
