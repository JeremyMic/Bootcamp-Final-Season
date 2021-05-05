#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Node{
    char name[100],condition[100];
    int prio;
    Node *prev, *next;
} *head, *tail;

Node *createNode(char name[], char condition[]){
    Node *nd = (Node*)malloc(sizeof(Node));
    strcpy(nd->name,name);
    strcpy(nd->condition,condition);
    nd->prev=nd->next=NULL;
    return nd;
}

int getPrio(char condition[]){
    if(strcmp(condition,"Critical") == 0){
        return 1;
    }else if(strcmp(condition,"Serious") == 0){
        return 2;
    }else if(strcmp(condition,"Fair") == 0){
        return 3;
    }else if(strcmp(condition,"Good") == 0){
        return 4;
    }
}

void add(char name[], char condition[]){
    Node *temp = createNode(name,condition);
    if(!head){
        head = tail = temp;
    }else if(getPrio(temp->condition) < getPrio(head->condition)){
        head->prev=temp;
        temp->next=head;
        head = temp;
    }else if(getPrio(temp->condition) >= getPrio(tail->condition)){
        tail->next = temp;
        temp->prev=tail;
        tail = temp;
    }else{
        Node *curr = head;
        while(curr){
            if(getPrio(curr->condition) > getPrio(temp->condition)){
                temp->prev=curr->prev;
                temp->next=curr;
                curr->prev=temp;
                temp->prev->next=temp;
                break;
            }
            curr = curr->next;
        }
    }
}

void call(){
    if(!head){
        return;
    }else{
        if(getPrio(head->condition) == 1){
            printf("%s is in the Emergency Room\n",head->name);
        }else if(getPrio(head->condition) == 2){
            printf("%s is in the Examination Room\n",head->name);
        }else if(getPrio(head->condition) == 3 || getPrio(head->condition) == 4){
            printf("%s is in the Consultation Room\n",head->name);
        }
        Node *temp = head->next;
        head->next=head->prev=NULL;
        free(head);
        head = temp;
    }
}

void waitingRoom(){
    printf("Waiting Room:");
    Node *curr = head;
    while(curr){
        if(curr->next){
            printf(" %s,",curr->name);
        }else{
            printf(" %s",curr->name);
        }
        curr = curr->next;
    }
}

int main(){
    int n;
    char menu[100],name[100],condition[100];
    scanf("%d",&n);
    getchar();
    for(int i=0; i<n; i++){
        scanf("%s",menu);
        getchar();
        if(strcmp(menu,"ADD") == 0){
            scanf("%s %s",name,condition);
            getchar();
            add(name,condition);
        }
        else if(strcmp(menu, "CALL") == 0){
            call();
        }
    }
    waitingRoom();

    return 0;
}