enum node_type
{
  PROGRAM,
  STMT,
  GENERIC,
  PARENT,
  IDENT,
  INTEGER,
  FLOAT,
  ASSIGN,
  SUM,
  POW,
  MINUS,
  MULTIPLY,
  DIVIDE,
  PRINT,
};

static const char *node_type_names[] = {
    "program",
    "stmt",
    "generic",
    "( )",
    "ident",
    "integer",
    "float",
    "=",
    "+",
    "^",
    "-",
    "*",
    "/",
    "print",
};

typedef struct
{
  double dblv;
  int intv;
  char *ident;

} token_args;

struct node
{
  int id;

  enum node_type type;
  int childCount;

  char *name;
  double dblv;
  int intv;

  struct node *children[1];
};

typedef struct node node;

node *create_node(enum node_type, int quantityChildren);

void add_node(node node_target, enum node_type);

void print(node *root);
void print_rec(FILE *f, node *root);
