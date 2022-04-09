from multiprocessing import Pool
import re
import jieba
import pandas as pd
from tqdm import tqdm
def task(df,p):
    cut_list = list()
    for text in tqdm(df['text'][(p-1)*20000:p*20000]):
        try:
            text1 = re.sub("[\s+\.\!\/_,$%^*(+\"\']+|[+——！，。？、~@#￥%……&*（）]+", "", str(text))
            cut_list.append(list(jieba.cut(text1)))
        except KeyError:
            pass
    return cut_list
if __name__ == '__main__':
    df = pd.read_csv('舆情情感文本.csv', encoding='gb18030')
    result = list()
    pool = Pool(processes=8)
    for i in range(1,1+8):
        result.append(pool.apply_async(task, (df,i)))
    pool.close()
    pool.join()
    for returns in result:
        print(len(returns.get()))