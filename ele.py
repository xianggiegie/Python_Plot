import numpy as np
import matplotlib.pyplot as plt

plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['mathtext.fontset'] = 'stix'

# 定义频率和电场强度数据
frequencies = np.array([1.00000000E+05,1.32830865E+05,1.76440386E+05,2.34367291E+05,3.11312100E+05,4.13518554E+05,5.49280272E+05,7.29613735E+05,9.69152234E+05,1.28733329E+06,1.70997595E+06,2.27137584E+06,3.01708817E+06,4.00762431E+06,5.32336202E+06,7.07106781E+06,9.39256053E+06,1.24762194E+07,1.65722701E+07,2.20130897E+07,2.92401774E+07,3.88399805E+07,5.15914820E+07,6.85294117E+07,9.10282102E+07,1.20913559E+08,1.60610526E+08,2.13340350E+08,2.83381832E+08,3.76418539E+08,5.00000000E+08])

electric_field = np.array([8.14220944E-01,9.12567996E-01,1.08730124E+00,1.28994094E+00,1.55974762E+00,1.91125453E+00,2.30799538E+00,2.73490957E+00,3.09402323E+00,3.23642350E+00,2.59570343E+00,2.20878971E+00,3.63437315E+00,3.57162956E+00,4.12830821E+00,3.20006301E+00,3.74220891E+00,4.17579793E+00,4.63998071E+00,3.59894977E+00,3.22720206E+00,3.94017644E+00,2.62835619E+00,2.40260557E+00,1.76342859E+00,1.31762751E+00,5.11637662E+00,3.74522841E+00,4.35965145E+00,2.38344256E+00,4.50019367E+00])

# 绘图
fig, ax = plt.subplots(figsize=(10, 5))
ax.plot(frequencies, electric_field, 'b-o', linewidth=1.5, markersize=6, label='Electric Field Magnitude')

# 设置对数横轴
ax.set_xscale('log')
ax.set_xlim([1e5, 5e8])
ax.set_xticks([1e5, 10e6, 100e6, 500e6])
ax.set_xticklabels(['0.1 MHz', '10 MHz', '100 MHz', '500 MHz'])

ax.set_xlabel('Frequency (Hz)', fontsize=20)
ax.set_ylabel('Electric Field Magnitude (V/m)', fontsize=20)
ax.set_title('Near Electric Field Magnitude vs Frequency', fontsize=22)
ax.tick_params(axis='both', labelsize=16)
ax.grid(True)
ax.legend(fontsize=16, loc='best')

plt.tight_layout()
plt.savefig('ele.png', dpi=300, bbox_inches='tight')
plt.show()
