struct GMT_DATASEGMENT * gmt_datasegment();
struct GMT_DATATABLE * gmt_datatable();
struct GMT_DATASET * gmt_dataset();
struct GMT_VECTOR * GMT_vector(int ncols, int nrows, enum GMT_enum_type type, int filled);
struct GMT_VECTOR * C_to_GMT_vector(double *x, double *y, int n);
void pvec(struct GMT_VECTOR *V);
void gmt_datasegment_alloc(struct GMT_DATASEGMENT *seg, int cols, int rows);
void gmt_dataset_append_datatable(struct GMT_DATASET *data, struct GMT_DATATABLE *table);
void gmt_dataset_append_datasegment(struct GMT_DATASET *data, struct GMT_DATASEGMENT *seg, uint64_t table);

