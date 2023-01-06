#ifndef SYNT_H
#define SYNT_H

    #include<stdlib.h>
    #include<string.h>


typedef struct Pile{
    char idf[20];
    struct Pile *next;
}Pile;

void empiler(const char *idf,Pile *T){
    if(T==NULL){
        T=(Pile *)malloc(sizeof(Pile));
        strcpy(T->idf,idf);
        T->next=NULL;
    }else{
        Pile *p=T;
        while(p->next!=NULL)
            p=p->next;
        p->next=(Pile *)malloc(sizeof(Pile));
        p=p->next;
        strcpy(p->idf,idf);
        p->next=NULL;
    }
}

void depiler(Pile* T,char *target){
    if(T){
        strcpy(target,T->idf);
        if(T->next){
            Pile *p=T;
            T=T->next;
            free(p);
        }else{
            free(T);
        }
    }
}
#endif

