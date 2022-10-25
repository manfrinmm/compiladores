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
  EQUAL,
  NOT_EQUAL,
  GREATER_THAN,
  LESS_THAN,
  GREATER_THAN_OR_EQUAL,
  LESS_THAN_OR_EQUAL,
  CONDITIONAL,
  LOGICAL_AND,
  LOGICAL_OR,
  LOOP
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
    "equal",
    "not_equal",
    "greater_than",
    "less_than",
    "greater_than_or_equal",
    "less_than_or_equal",
    "conditional",
    "logical_and",
    "logical_or",
    "loop"};

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
