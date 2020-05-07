import xlrd
import copy
import time

g = {}
p = []


def optimized_path(k, a, matrix, times):
    if (k, a) in g:
        return g[k, a]

    values = []
    all_min = []
    for j in a:
        set_a = copy.deepcopy(list(a))
        set_a.remove(j)
        all_min.append([j, tuple(set_a)])
        result = optimized_path(j, tuple(set_a), matrix, times)
        values.append(matrix[k][j] + times[k] + result)

    g[k, a] = min(values)
    p.append(((k, a), all_min[values.index(g[k, a])]))

    return g[k, a]

def get_matrix(n):
    workbook = xlrd.open_workbook(f'P{n}.xls')
    worksheet = workbook.sheet_by_index(0)
    matrix = []
    for i in range(n+1):
        row = []
        for j in range(n+1):
            row.append(int(worksheet.cell(i, j).value))
        matrix.append(row)
    return matrix

def get_study_times(n):
    workbook = xlrd.open_workbook(f'P{n}.xls')
    worksheet = workbook.sheet_by_index(0)
    matrix = []
    for i in range(n+1):
        matrix.append(int(worksheet.cell(n+1, i).value))
    return matrix

for n in range(5, 76, 5):
    distance_matrix = get_matrix(n)
    time_list = get_study_times(n)

    start = time.time()
    for x in range(1, n+1):
        g[x, ()] = distance_matrix[0][x] + time_list[x]

    total = optimized_path(0, tuple(range(1,n+1)), distance_matrix, time_list)

    print("\n\nBacktracking...")
    print(f'Path for N={n}: 1 -> ', end='')
    solution = p.pop()
    print(solution[1][0]+1, end=' -> ')
    for x in range(n):
        for new_solution in p:
            if tuple(solution[1]) == new_solution[0]:
                solution = new_solution
                print(solution[1][0]+1, end=' -> ')
                break
    print('1')
    
    print(f'Total Time: {total}')
    run_time = time.time() - start
    print(f"Runtime: {int(run_time*1000)}ms")
    
    g.clear()
    del p[:]