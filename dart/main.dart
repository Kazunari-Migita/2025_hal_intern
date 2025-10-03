void main() {
print("①");
final int age = 20;
print(age);


final String names = "aaa";
print(names);


final double price = 13.5;
print(price);


print("----------------");
print("②");
int num = 56;
if (num % 2 == 0){
  print("偶数です");
}else{
  print("奇数です");
}

print("----------------");
print("3");
for(int i = 1; i<=10; i++ ){
  print(i);
}

print("----------------");
print("4");
int sum(int s1,int s2) => s1 + s2;

print(sum(10, 20));

}