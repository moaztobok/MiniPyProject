#ifndef TS_H
#define TS_H

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

typedef enum Updates { 
    U_name = 0x01 , U_type = 0x02,
    U_code = 0x04 , U_val = 0x08
}Updates;

typedef enum {
    DT_int= 0x01, DT_double= 0x02,
    DT_char= 0x04, DT_bool= 0x08
}data_T;

typedef struct node {
    char name[20];
    char type[20];
    char code[20];
    double val;
    struct node *next;
}node;
typedef struct nod {
    char name[20];
    char type[20];
    struct nod *next;
}nod;


int find(char name[],char y);
node *insertNode(char name[],char type[],char code[],double val);
nod *insertNod(char name[],char type[]);
int addNode(char name[],char type[],char code[],double val,char y);
int updateNode(node *T,char name[],char type[],char code[],double val,Updates flag);
int updateNod(nod *T,char name[],char type[],Updates flag);
void Maj(char name[],char type[],char code[],double val,char y,Updates flag);
void display();
char getBool(char *name);
double getval(const char *name);


#endif
