#ifndef QUAD_H
#define QUAD_H

#include<string.h>
#include<stdlib.h>
#include<stdio.h>

typedef enum {
    U_1=1 , U_2=2,
    U_3=4 , U_4=8
}quadUpdates;

typedef struct quad{
    char a[30];
    char b[30];
    char c[30];
    char d[30];
    struct quad *next;
}quad_t;

static quad *qdr=NULL;
static int qc = 0;

quad *quad_Create(char *a,char *b,char *c,char *d){
    quad *p=(quad *)malloc(sizeof(quad));
    strcpy(p->a,a);
    strcpy(p->b,b);
    strcpy(p->c,c);
    strcpy(p->d,d);
    p->next=NULL;
    return p;
}

int addQuad(char *a,char *b,char *c,char *d){
    if(!qdr)
        qdr=quad_Create(a,b,c,d);
    else{
        quad *p=qdr;
        while(qdr->next!=NULL)
            p=p->next;
        p->next=quad_Create(a,b,c,d);
    }
    qc++;
    return 0;
}

void quadDisplay(){
    int pos=0;
    quad *p=qdr;
    printf("\n-------QUADS-----\n");
    while (pos<qc && p!=NULL)
    {
        printf("%d -(\" %s \" ,\" %s \" ,\" %s \" ,\" %s \")",pos,p->a,p->b,p->c,p->d);
        p=p->next;
        pos++;
    }
}

void quadMaj(int pos,char *a,char *b,char *c,char *d,quadUpdates flag){
    int pos=0;
    quad *p=qdr;
    while (pos!=qc && p!=NULL)
    {
        p=p->next;
        pos++;
    }
    if(p!=NULL or pos != qc){
        if(flag & 0x1)
            strcpy(p->a,a);
        if(flag & 0x2)
            strcpy(p->b,b);
        if(flag & 0x4)
            strcpy(p->c,c);
        if(flag & 0x08)
            strcpy(p->d,d);
        p->next=NULL;
    }
}





#endif

