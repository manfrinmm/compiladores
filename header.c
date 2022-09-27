#include <stdlib.h>
#include <stdio.h>

#include "header.h"

node *create_node(enum node_type nodeType, int quantityChildren)
{
  static int IDCOUNT = 0;

  node *newNode = (node *)calloc(1, sizeof(node) + sizeof(node *) * (quantityChildren - 1));

  newNode->id = IDCOUNT++;
  newNode->type = nodeType;
  newNode->childCount = quantityChildren;

  return newNode;
}

const char *get_label(node *no)
{
  static char aux[100];

  switch (no->type)
  {
  case INTEGER:
    sprintf(aux, "%d", no->intv);

    return aux;

  case FLOAT:
    sprintf(aux, "%f", no->dblv);

    return aux;
  case IDENT:
    return no->name;

  default:
    return node_type_names[no->type];
  }
}

void print_rec(FILE *f, node *root)
{
  fprintf(f, "N%d[label=\"%s\"];\n", root->id, get_label(root));
  for (int i = 0; i < root->childCount; i++)
  {
    print_rec(f, root->children[i]);
    fprintf(f, "N%d -- N%d;\n", root->id, root->children[i]->id);
  }
}

void print(node *root)
{
  FILE *file = fopen("./output.txt", "w");

  fprintf(file, "graph G {\n");
  print_rec(file, root);
  fprintf(file, "}");

  fclose(file);
}
