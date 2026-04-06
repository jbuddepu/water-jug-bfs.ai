from collections import deque

cap = [12, 8, 3, 5]
start = (0, 0, 0, 0)
goal = (6, 6, 0, 0)

visited = set()
q = deque([(start, [])])


def next_states(state):
    states = []
    for i in range(4):
        if state[i] < cap[i]:
            new = list(state)
            new[i] = cap[i]
            states.append(tuple(new))

        if state[i] > 0:
            new = list(state)
            new[i] = 0
            states.append(tuple(new))
    return states


while q:
    state, path = q.popleft()
    if state in visited:
        continue
    visited.add(state)

    if state == goal:
        print("Solution:", path)
        break

    for s in next_states(state):
        q.append((s, path + [s]))
