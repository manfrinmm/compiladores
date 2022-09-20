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

struct node
{
  int id;

  enum node_type type;
  int childCount;

  char *name;
  double value;

  struct node *children[1];
};

typedef struct node node;

node *create_node(enum node_type, int quantityChildren);
