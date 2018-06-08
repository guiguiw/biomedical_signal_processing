import matplotlib.pyplot as plt
import numpy as np

l1 = np.array([46.00, 45.00, 45.00, 46.00, 46.00, 45.00, 46.40, 46.00, 45.00])
l1_mean = l1.mean()
l1_varp = np.sum(np.power(l1-l1.mean(), 2))/(len(l1))
l1_vara = np.sum(np.power(l1-l1.mean(), 2))/(len(l1)-1)

l2 = np.array([47.00, 39.50, 38.50, 39.20, 39.30, 38.00, 39.00, 39.00, 37.00])
l2_mean = l1.mean()
l2_varp = np.sum(np.power(l2-l2.mean(), 2))/(len(l2))
l2_vara = np.sum(np.power(l2-l2.mean(), 2))/(len(l2)-1)

l2_sem_out = np.array([39.50, 38.50, 39.20, 39.30, 38.00, 39.00, 39.00, 37.00])
l2_mean_sem_out = l1.mean()
l2_varp_sem_out = np.sum(np.power(l2_sem_out - l2_sem_out.mean(),
                         2))/(len(l2_sem_out))
l2_vara_sem_out = np.sum(np.power(l2_sem_out - l2_sem_out.mean(),
                         2))/(len(l2_sem_out)-1)

kl1 = np.sum(np.power(l1-l1.mean(), 3))/(len(l1)-1)
sl1 = np.sum(np.power(l1-l1.mean(), 4))/(len(l1)-1)

kl2 = np.sum(np.power(l2-l2.mean(), 3))/(len(l2)-1)
sl2 = np.sum(np.power(l2-l2.mean(), 4))/(len(l2)-1)

kl2_sem_out = np.sum(np.power(l2_sem_out-l2_sem_out.mean(),
                              3))/(len(l2_sem_out)-1)
sl2_sem_out = np.sum(np.power(l2_sem_out-l2_sem_out.mean(),
                              4))/(len(l2_sem_out)-1)

# plt.hist(l2)
# plt.show()
