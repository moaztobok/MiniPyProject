#ifndef TS_H
#define TS_H

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

typedef enum Updates { 
    U_name = 0x01 , U_type = 0x02,
    U_code = 0x04 , U_val = 0x08
}Updates;

typedef struct node {
    char name[20];
    char type[20];
    char code[20];
    float val;
    struct node *next;
}node;
typedef struct nod {
    char name[20];
    char type[20];
    struct nod *next;
}nod;


node *insertNode(char name[],char type[],char code[],float val);
nod *insertNod(char name[],char type[]);
int addNode(char name[],char type[],char code[],float val,char y);
int updateNode(node *T,char name[],char type[],char code[],float val,Updates flag);
int updateNod(nod *T,char name[],char type[],Updates flag);
int find(char name[],char y);
void Maj(char name[],char type[],char code[],float val,char y,Updates flag);
void display();

#endif
