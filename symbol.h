#ifndef SYMBOL_H
#define SYMBOL_H

/* Enumeration of the possible data types */
typedef enum {
    TYPE_INTEGER,
    TYPE_SINGLE,
    TYPE_DOUBLE,
    TYPE_STRING
} data_type;

/* Structure representing a symbol table entry */
typedef struct {
    char *name;          /* name of the variable/function */
    data_type type;      /* data type of the variable/function */
    int value_int;       /* integer value of the variable/function */
    float value_single;  /* single-precision floating-point value of the variable/function */
    double value_double; /* double-precision floating-point value of the variable/function */
    char *value_string;  /* string value of the variable/function */
    int is_function;     /* whether the symbol is a function */
} symbol_entry;

/* Function prototypes */
void init_symbol_table();
void free_symbol_table();
void set_value(char *name, void *value);
void set_type(char *name, data_type type);
data_type get_type(char *name);
void print_value(char *name);

#endif
