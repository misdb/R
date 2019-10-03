# ch_13_solution_exercise

# 수학적 확률(소숫점 둘째자리)
prob_real = round(1/6, 2)
prob_real

# 시행 횟수
iterations <- c(100, 1000, 10000)

# 실험적 확률
prob_expt <- NULL

# 시행 횟수별 실험 
for(iteration in iterations) {    # iterations <- c(100, 1000, 10000) 의 세 요소값으로 반복 (반복회수 3번)**
    sum <- 0
    for(x in 1:iteration) {
        dice <- sample(1:6, 2, replace=T)
        if (dice[1] == dice[2])
            sum = sum + 1 
    }

	# 실험적 확률
      prob_expt <- c(prob_expt, round(sum / iteration, 2))             # prob_expt 는 3개의 요소로 구성된 벡터.
}

# 출력
iterations
prob_expt

# 오차
abs(prob_real - prob_expt)