#include <stdio.h>

int main(){
    int arr[4] = {6, 2, 7, 5};
    int temp;
    
    printf("Before SORT \n");
    for (int i =0; i < 4; i++){
        printf("%d ", arr[i]);
    }
    printf("\n");

    for (int j = 3; j > 0; j-- ){
        for(int k = j - 1; k >= 0; k--){
            if(arr[k] > arr[j]){
                temp = arr[j];
                arr[j] = arr[k];
                arr[k] = temp;
            }
        }
    }

    printf("After SORT \n");
    for (int i =0; i < 4; i++){
        printf("%d ", arr[i]);
    }

    return 0;

}