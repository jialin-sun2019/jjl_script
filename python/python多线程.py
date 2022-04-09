from multiprocessing import Pool

def task(p):
    sum = 0
    for i in range(1000000):
        sum = sum + p
    return sum
if __name__ == '__main__':
    result = list()
    pool = Pool(processes=12)
    for i in range(1,1+12):
        result.append(pool.map(task, (i,)))
    pool.close()
    pool.join()
    print(result)

    # result = list()
    # pool = Pool(processes=12)
    # for i in range(1, 1 + 12):
    #     result.append(pool.apply_async(task, (i,)))
    # pool.close()
    # pool.join()
    # for returns in result:
    #     print(returns.get())