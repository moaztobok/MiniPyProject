#include"ts.h"

static int cpti=0,cpts=0,cptm=0;
static node *tabi=NULL;
static nod *tabs=NULL;
static nod *tabm=NULL;

int find(char name[],char y){
    int pos=0;
    node *p=NULL;
    nod *q=NULL;
    switch (y)
    {
    case 0:
        p=tabi;
        while(p!=NULL){
            if(!strcmp(p->name,name)){
                return pos; break;
            }
            pos++;
            p=p->next;
        }
        break;
    case 1:
        q=tabs;
        while(q!=NULL){
            if(!strcmp(q->name,name)){
                return pos; break;
            }
            pos++;
            q=q->next;
        }
        break;
    case 2:
        q=tabm;
        while(q!=NULL){
            if(!strcmp(q->name,name)){
                return pos; break;
            }
            pos++;
            q=q->next;
        }
        break;
    }
    return -1;
}
node *insertNode(char name[],char type[],char code[],float val){
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
int addNode(char name[],char type[],char code[],float val,char y){
    int i;
    if(i=find(name,y)!=-1){
        return -1;
    }else{
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
                printf("no more space in tab %d",(int)y+1);
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
                printf("no more space in tab %d",(int)y+1);
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
                printf("no more space in tab %d",(int)y+1);
            }
            break;
        }
    }
    return 0;
}

int updateNode(node* T,char name[],char type[],char code[],float val,Updates flag){
    if(T){
        if(flag & U_name)
            strcpy(T->name,name);
        if(flag & U_type)
            strcpy(T->type,type);
        if(flag & U_code)
            strcpy(T->code,code);
        if(flag & U_val)
            T->val=val;
        return 0;
        }else return 1;
}
int updateNod(nod* T,char name[],char type[],Updates flag){
    if(T){
        if(flag & U_name)
            strcpy(T->name,name);
        if(flag & U_type)
            strcpy(T->type,type);
        return 0;
        }else return 1;    
}

void Maj(char name[],char type[],char code[],float val,char y,Updates flag){
    node *p=NULL;
    nod *q=NULL;
    switch (y)
    {
    case 0:
        p=tabi;
        while(p!=NULL){
            if(!strcmp(p->name,name)){
                updateNode(p,name,type,code,val,flag);
                break;
            }
        }
        break;
    case 1:
        q=tabs;
        while(q!=NULL){
            if(!strcmp(q->name,name)){
                updateNod(q,name,type,flag|0x03);
                break;
            }
        }
        break;
    case 2:
        q=tabm;
        while(q!=NULL){
            if(!strcmp(q->name,name)){
                updateNod(q,name,type,flag|0x03);
                break;
            }
        }
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
