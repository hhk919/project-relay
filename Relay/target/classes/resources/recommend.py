# -*- coding:utf-8 -*-
import pandas as pd
import numpy as np
from math import sqrt
import cx_Oracle
import os 
import sys
import warnings
warnings.filterwarnings('ignore')

#==========================================================db불러온 샘플
os.environ["NLS_LANG"] = ".AL32UTF8"
with cx_Oracle.connect('big4/admin1234@localhost:1521/xe') as conn :
    cur = conn.cursor()
    cur.execute('SELECT * FROM wishlist where mno >7')
    
    mem=[]
    pro=[]
    rate=[]
    
    for row in cur : 
        mem.append(row[0])
        pro.append(row[1])
        rate.append(row[2])
        
d = {'mno': pd.Series(mem), 'pno': pd.Series(pro),  'rating': pd.Series(rate)}
df = pd.DataFrame(d)
#==========================================================

def recur_dictify(frame):
    if len(frame.columns) == 1:
        if frame.values.size == 1: return frame.values[0][0]
        return frame.values.squeeze()
    grouped = frame.groupby(frame.columns[0])
    d = {k: recur_dictify(g.ix[:, 1:]) for k,g in grouped}
    return d

df_to_dict = recur_dictify(df)  #{회원1:{상품1:평점, 상품2:평점, 상품3:평점,...}, 회원2:{상품1:평점, 상품2:평점, 상품3:평점,...},....}

#============================사용자 목록, 상품 목록을 리스트로 담시
name_list = []    # 회원 목록을 담을 리스트
prd_set = set()   # 상품 목록을 set

#회원수 만큼 반복
for user_key in df_to_dict:
#     print(user_key)
    name_list.append(user_key)
     
    for prd_key in df_to_dict[user_key]:
#         print(user_key, ":", prd_key)
        prd_set.add(prd_key)
prd_set        
prd_list = list(prd_set)

#================================CF추천시스템에 사용할 rating 딕셔너리 만들기(닉,제품번호,평점)
#학습할 데이터를 준비한다.
rating_dic = {
    'mno' : [],
    'pno' : [],
    'rating' : []
    }  


for name_key in df_to_dict:
    # 해당 사용자가 본 상품 수 만큼 반복
    for prd_key in df_to_dict[name_key]:
        
        #회원 인덱스 번호를 추출
#         a1 = name_list.index(name_key)
        #회원 번호
        a1 = name_key
        
        #상품 인덱스 번호를 추출한다.
#         a2 = prd_list.index(prd_key)
        #상품번호
        a2 = prd_key
        
        #평점을 가져온다.
        a3 = df_to_dict[name_key][prd_key]
        
        #딕셔너리에 담는다.
        rating_dic['mno'].append(a1)
        rating_dic['pno'].append(a2)
        rating_dic['rating'].append(a3)
          
df = pd.DataFrame(rating_dic)

# 피어슨 상관계수 구하기
def sim_pearson(data, name1, name2):
    sumX=0 # X의 합
    sumY=0 # Y의 합
    sumPowX=0 # X 제곱의 합
    sumPowY=0 # Y 제곱의 합
    sumXY=0 # X*Y의 합
    count=0 #상품 개수
    
     
    for i in data[name1]: # i = key
        if i in data[name2]: # 같은 상품을 평가했을때만
            sumX+=data[name1][i]
            sumY+=data[name2][i]
            sumPowX+=pow(data[name1][i],2)
            sumPowY+=pow(data[name2][i],2)
            sumXY+=data[name1][i]*data[name2][i]
            count+=1
    
    if count==0 or sqrt( (sumPowX - (pow(sumX,2) / count)) * (sumPowY - (pow(sumY,2)/count)))==0:
        return -2        
    else:
        return (sumXY- ((sumX*sumY)/count) )/ sqrt( (sumPowX - (pow(sumX,2) / count)) * (sumPowY - (pow(sumY,2)/count)))

    
def top_match(data, name, index=10, sim_function=sim_pearson):
    li=[]

    for i in data: #딕셔너리를 돌고
        if name!=i: #자기 자신이 아닐때만
            if np.isnan(sim_function(data,name,i))==0:
                li.append((sim_function(data,name,i),i)) #sim_function()을 통해 상관계수를 구하고 li[]에 추가 
            elif sim_function(data,name,i)==-2:
                pass       
    li.sort() #오름차순
    li.reverse() 
        
    return li[:index]    


def allRecommendationlist (data,person, sim_function=sim_pearson):
    
    if person in df_to_dict:
        result = top_match(data, person ,len(data))
    
        simSum=0 # 유사도 합을 위한 변수
        score=0 # 평점 합을 위한 변수
        li=[] # 리턴을 위한 리스트
        score_dic={} # 평점 총합을 위한 dic
        sim_dic={} # 유사도 총합을 위한 dic
    
        for sim,name in result: # 튜플이므로 한번에 
            if sim<0 : continue #유사도가 양수인 사람만
            for prd in data[name]: 
                if prd not in data[person]: #name이 평가를 내리지 않은 영화
                    score+=sim*data[name][prd] # 그사람의 상품평점 * 유사도
                    score_dic.setdefault(prd,0) # 기본값 설정
                    score_dic[prd]+=score # 합계 구함
 
                    # 조건에 맞는 사람의 유사도의 누적합을 구한다
                    sim_dic.setdefault(prd,0) 
                    sim_dic[prd]+=sim
 
                    score=0  #상품이 바뀌었으니 초기화한다

        for key in score_dic: 
            score_dic[key]=score_dic[key]/sim_dic[key] # 평점 총합/ 유사도 총합
            if np.isnan(score_dic[key])==0:
                li.append((score_dic[key],key)) # list((tuple))의 리턴을 위해서.
        li.sort() #오름차순
        li.reverse() #내림차순
           
        if len(li)>=5:
            tu=(li[0][1],li[1][1],li[2][1],li[3][1],li[4][1])    
            print(tu)
            return tu
        else:
            tu=('','','','','')
            print(tu)
            return tu

def main(mno) :
    mno = int(mno)
    allRecommendationlist (df_to_dict,mno, sim_function=sim_pearson)

if __name__ == '__main__':
    main(sys.argv[1])
