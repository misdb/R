# While 반복구문 (예제 포함)



조건이 만족되어 있는 동안 계속실행하는 구문이 while 반복구문이다. `while` 반복구문의 표현법은 다음과 같다 :

```
while (condition) {
     Exp	
}
```

[![img](https://www.guru99.com/images/r_programming/032818_1244_WhileLoopin1.png)](https://www.guru99.com/images/r_programming/032818_1244_WhileLoopin1.png)

while 반복구문의 흐름도

**Note**: Remember to write a closing condition at some point otherwise the loop will go on indefinitely.

**주의 **: 반복문이 무한정 반복되지 않게 하려면 어느 시점에선가 종료 조건을 작성해야 한다는 것을 기억하십시오.



**예제 1:**

매우 간단한 예를 통해 `while` 반복구문의 개념을 이해해보자. 루프를 생성하고 각 실행 후 저장된 변수에 1을 더하게 하자. 반복을 종료해야 하기 때문에, 우리는 R에게 변수가 10에 도달했을 때 반복을 멈추라고 명확히 알려야 한다.

**주의 : ** 현재 반복 값을 보려면 그 변수를 `print( )` 함수의 인수로 사용해야 한다.

```
# Create a variable with value 1
begin <- 1

# Create the loop
while (begin <= 10){

       # See which we are  
       cat('This is loop number',begin)

       # add 1 to the variable begin after each loop
       begin <- begin+1
       print(begin)
}
```

**결과 :**

```
## This is loop number 1[1] 2
## This is loop number 2[1] 3
## This is loop number 3[1] 4
## This is loop number 4[1] 5
## This is loop number 5[1] 6
## This is loop number 6[1] 7
## This is loop number 7[1] 8
## This is loop number 8[1] 9
## This is loop number 9[1] 10
## This is loop number 10[1] 11
```



**예제 2 :**

당신이 50달러의 가격으로 주식을 샀다. 가격이 45 이하로 떨어지면 우리는 그것을 줄이고 싶다. 그렇지 않으면, 우리는 그것을 우리의 포트폴리오에 보관한다. 가격이 각 반복이후 -10에서 +10 사이에서 변동할 수 있다. 여러분은 다음과 같이 코드를 작성할 수 있다 :

```
set.seed(123)
# Set variable stock and price
stock <- 50
price <- 50

# Loop variable counts the number of loops 
loop <- 1

# Set the while statement
while (price > 45){

      # Create a random price between 40 and 60
      price <- stock + sample(-10:10, 1)

      # Count the number of loop
      loop = loop +1 

      # Print the number of loop
      print(loop)
}
```

**결과 :**

```
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
cat('it took',loop,'loop before we short the price. The lowest price is',price)
```

**결과 : **

```
## it took 7 loop before we short the price.The lowest price is 40
```



 