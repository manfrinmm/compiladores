#include <stdlib.h>
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
