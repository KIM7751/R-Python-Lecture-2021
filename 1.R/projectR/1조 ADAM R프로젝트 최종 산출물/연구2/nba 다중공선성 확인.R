# 다중공선성 확인

season_c <- read.csv('Seasons_Stats_NEW.csv', header = T)
season_c <- season %>% filter(Year >= 2000)

head(season)

season_c <- select(season_c, Age, MP)
stat_cor <- cor(season_c[5, 7:20])
stat_cor          # corelation 다중공선성 확인 결과, MP와 PTS(0.91), MP와 TOV(0.88), TOV와 PTS(0.92) 다중공선성 확인. 

# 계수 추정이 잘 되지 않거나 불안정해져서 데이터가 약간만 바뀌어도 추정치가 크게 달라질 수 있다
# 계수가 통계적으로 유의미하지 않은 것처럼 나올 수 있다

# 이제 여기서 MP를 MP >= MEDIAN(MP) 로 하고 나서 다시 한번 다중공선성 확인하여 다중공선성이 줄었다면 
# MP가 중위값이 안 되는 데이터 행들을 삭제한 데이터 가공이 유의미하다고 설득할 수 있다. 

season_med <- season_c %>% filter(MP >= median(MP))
cor(season_med[7:20])                                # 모든 다중공선성 지수가 유의하게 낮아짐.

# MP 변수가 PTS, TOS 에 미치는 영향력을 배제하기 위하여 MP변수에 조건을 줌.
