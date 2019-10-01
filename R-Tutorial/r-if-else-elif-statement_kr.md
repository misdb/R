# IF, ELSE, ELSE IF 구문



## if else 구문

if-else 구문은 조건을 기반으로 출력을 반환하려는 개발자에게 훌륭한 도구다. R에서의 구문법은 다음과 같다.

```
if (condition) {
    Expr1 
} else {
    Expr2
}
```

[![img](https://www.guru99.com/images/r_programming/032818_1241_IFELSEELIF1.png)](https://www.guru99.com/images/r_programming/032818_1241_IFELSEELIF1.png)



`quantity`로 저장된 변수가 20 이상인지 조사하고자 한다. 수량이 20보다 크면 코드는 "You sold a lot!"이라고 인쇄할 것이다. 그렇지 않으면 "Not enough for today"라고 출력한다.

```
# Create vector quantity
quantity <-  25
# Set the is-else statement
if (quantity > 20) {
    print('You sold a lot!')
} else {
    print('Not enough for today')  
}
```

**결과 :**

```
## [1] "You sold a lot!"
```

**주의 : ** 들여쓰기를 올바르게 했는지 확인하기 바란다. 복수의 조건이 있는 코드는 들여쓰기가 정확한 위치에 있지 않으면 가독성이 떨어지게 된다.



## else if 구문

We can further customize the control level with the else if statement. With elif, you can add as many conditions as we want. The syntax is:

`else if` 구문을 사용하여 제어 수준을 추가로 정의할 수 있다. `else if`만 있으면 얼마든지 조건을 추가할 수 있다. 구문법은 다음과 같다 :

```
if (condition1) { 
    expr1
    } else if (condition2) {
    expr2
    } else if  (condition3) {
    expr3
    } else {
    expr4
}
```



**Example 1 :**

우리는 우리가 20에서 30사이의 수량을 팔았는지 알고 싶다. 만약 그렇다면, 'Average day'를 출력하고, 수량이 30 이상이면, 'What a great day'를, 그렇지 않으면 'Not enough for today'를 출력하자.

`quantity`의 값을 변경하면서 실행해 보자.

```
# Create vector quantiy
quantity <-  10
# Create multiple condition statement
if (quantity <20) {
      print('Not enough for today')
} else if (quantity > 20  &quantity <= 30) {
     print('Average day')
} else {
      print('What a great day!')
}
```

**결과 :**

```
## [1] "Not enough for today"
```



**Example 2:**

부가가치세(VAT)는 구입한 상품에 따라 요율이 다르다. 세 가지 다른 종류의 VAT가 적용되는 세 종류의 제품군이 있다고 가정하자.

| 분류 | 제품                       | VAT  |
| :--- | :------------------------- | :--- |
| A    | 책, 잡지, 신문 등...       | 8%   |
| B    | 야채, 쇠고기, 음료 등...   | 10%  |
| C    | 티셔트, 청바지, 바지 등... | 20%  |

고객이 구매한 제품에 해당하는 정확한 부가가치세율을 적용하기 위한 조건식을 작성할 수 있다.

```
category <- 'A'
price <- 10
if (category =='A'){
  cat('A vat rate of 8% is applied.','The total price is',price *1.08)  
} else if (category =='B'){
    cat('A vat rate of 10% is applied.','The total price is',price *1.10)  
} else {
    cat('A vat rate of 20% is applied.','The total price is',price *1.20)  
}
```

**결과 : **

```
# A vat rate of 8% is applied. The total price is 10.8
```

 