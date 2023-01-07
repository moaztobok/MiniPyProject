#include"ts.h"

static int cpti=0,cpts=0,cptm=0;
static node *tabi=NULL;
static nod *tabs=NULL;
static nod *tabm=NULL;

int find(char name[],char y){
    int pos=1;
    node *p=NULL;
    nod *q=NULL;
    switch (y)
    {
    case 0:
        p=tabi;
        while(p!=NULL && strcmp(p->name,name)!=0){
            p=p->next;
            pos++;
        }
        if(p!=NULL && !strcmp(p->name,name))
            return pos;
        else 
            return 0;
        break;
    case 1:
        q=tabs;
        while(q!=NULL && strcmp(q->name,name)!=0){
            q=q->next;
            pos++;
        }
        if(q!=NULL && !strcmp(q->name,name))
            return pos;
        else 
            return 0;
        break;
    case 2:
        q=tabm;
        while(q!=NULL && strcmp(q->name,name)!=0){
            q=q->next;
            pos++;
        }
        if(q!=NULL && !strcmp(q->name,name))
            return pos;
        else 
            return 0;
        break;
    }
}
node *insertNode(char name[],char type[],char code[],double val){
    node* q=malloc(sizeof(node));
    strcpy(q->name,name);
    strcpy(q->type,type);
    strcpy(q->code,code);
    q->val=val;
    q->next=NULL;
    return q;
}
nod *insertNod(char name[],char type[]){
    nod* q=malloc(sizeof(nod));
    strcpy(q->name,name);
    strcpy(q->type,type);
    q->next=NULL;
    return q;
}
int addNode(char name[],char type[],char code[],double val,char y){
    if(find(name,y)!=0){
        return -1;
    }
    switch (y)
    {
    case 0:
        if(cpti==0){
            tabi=insertNode(name,type,code,val);
            cpti++;
        }else if(cpti<1000){
            node *p=tabi;
            while (p->next!=NULL)
                p=p->next;
            p->next=insertNode(name,type,code,val);
            cpti++;           
        }else{
            printf("no more space in tab 1.\n");
        }
        break;
    case 1:
        if(cpts==0){
            tabs=insertNod(name,type);
            cpts++;
        }else if(cpts<40){
            nod *p=tabs;
            while (p->next!=NULL)
                p=p->next;
            p->next=insertNod(name,type);
            cpts++;
        }else{
            printf("no more space in tab 2.\n");
        }
        break;
    case 2:
        if(cptm==0){
            tabm=insertNod(name,type);
            cptm++;
        }else if(cptm<40){
            nod *p=tabm;
            while (p->next!=NULL)
                p=p->next;
            p->next=insertNod(name,type);
            cptm++;         
        }else{
            printf("no more space in tab 3.\n");
        }
        break;
    }
    return 0;
}

int updateNode(node* T,char name[],char type[],char code[],double val,Updates flag){
    node *p=T;
    while(p->next!=NULL && strcmp(p->name,name)!=0 )
        p=p->next;
    printf("\nfound match\n");
    if(p!=NULL && strcmp(p->name,name)==0){
        if(flag & U_name)
            strcpy(p->name,name);
        if(flag & U_type)
            strcpy(p->type,type);
        if(flag & U_code)
            strcpy(p->code,code);
        if(flag & U_val)
            p->val=val;
        return 0;
        }else return 1;
}
int updateNod(nod* T,char name[],char type[],Updates flag){
    nod *p=T;
    while(p->next!=NULL && strcmp(p->name,name)!=0 );
        p=p->next;
    if(p!=NULL && strcmp(p->name,name)==0){
        if(flag & U_name)
            strcpy(p->name,name);
        if(flag & U_type)
            strcpy(p->type,type);
        return 0;
        }else return 1;    
}

void Maj(char name[],char type[],char code[],double val,char y,Updates flag){
    switch (y)
    {
    case 0:
        updateNode(tabi,name,type,code,val,flag);
        break;
    case 1:
        updateNod(tabs,name,type,flag & 0x03);
        break;
    case 2:
        updateNod(tabm,name,type,flag & 0x03);
        break;
    }
}

void display(){
    printf("\n**Table de symboles**\n----------------IDFs----------------\n");
    printf("_______________________________________________________________\n");
    printf("| pos |     name    |     type     |    code    |     val     |\n");
    printf("_______________________________________________________________\n");
    node *p=tabi; int pos=0;
    while(p!=NULL){
        printf("|%5d|  %10s | %12s | %10s | %12f|\n",pos,p->name,p->type,p->code,p->val);
        printf("_______________________________________________________________\n");
        pos++; p=p->next;
    }

    printf("\n----------------SYMB----------------\n");
    printf("___________________________________\n");
    printf("| pos |     name    |     type     |\n");
    printf("___________________________________\n");
    nod *q=tabs; pos=0;
    while(q!=NULL){
        printf("|%5d|  %10s | %12s |\n",pos,q->name,q->type);
        printf("___________________________________\n");
        pos++; q=q->next;
    }

    printf("\n---------------KWds----------------\n");
    printf("___________________________________\n");
    printf("| pos |     name    |     type     |\n");
    printf("___________________________________\n");
    q=tabm; pos=0;
    while(q!=NULL){
        printf("|%5d|  %10s | %12s |\n",pos,q->name,q->type);
        printf("___________________________________\n");
        pos++; q=q->next;
    }
    
}

char getBool(char *name){
    node *p=tabi;
    while(p!=NULL && strcmp(name,p->name))
        p=p->next;
    if(p->val==1.0) return 1;
    return 0;
}
