#include <iostream>
using namespace std;

#define MAX_SIZE 100 


int CheckSumPossibility(int num, int arr[], int arraySize);


int main(){
	int arraySize;
	int arr[MAX_SIZE];
	int num;
	int returnVal;

	cin >> arraySize;
	cin >> num;


	for(int i =0; i < arraySize; ++i){
		cin >> arr[i];
	}
	
	
	returnVal = CheckSumPossibility(num, arr,arraySize);
	
	if(returnVal ==1){
		cout <<""<<endl;
		cout <<"Possible!"<<endl;
	}else{
		cout <<"Not possible!"<<endl;
	}
	
	return 0; 
}

int CheckSumPossibility(int num, int arr[], int arraySize){
	
	if(num==0){
		//Found subset of the array can sum up to the target number
		return 1;
	}else if (num<0){
		//It's to ignore the next recursive calls when the sum exceeded the target number num
		return 0;
	}
	if(arraySize==0){
		//All possible elements are tried
		return 0;
	}
	
	//Choose the current 0 index element for sum
	int addToSum=CheckSumPossibility(num-arr[0], arr+1,arraySize-1);
	//Non choose the current 0 index element for sum
	int notAddToSum=0;	
	if(addToSum!=1){
		notAddToSum=CheckSumPossibility(num, arr+1,arraySize-1);
	}else{
		cout << arr[0]<< " ";
	}
		
	return addToSum || notAddToSum;
}
