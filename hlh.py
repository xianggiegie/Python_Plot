import numpy as np
import matplotlib.pyplot as plt

plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['mathtext.fontset'] = 'stix'

# 定义频率和磁场强度数据
frequencies = np.array([1.00000000E+05,1.32830865E+05,1.76440386E+05,2.34367291E+05,3.11312100E+05,4.13518554E+05,5.49280272E+05,7.29613735E+05,9.69152234E+05,1.28733329E+06,1.70997595E+06,2.27137584E+06,3.01708817E+06,4.00762431E+06,5.32336202E+06,7.07106781E+06,9.39256053E+06,1.24762194E+07,1.65722701E+07,2.20130897E+07,2.92401774E+07,3.88399805E+07,5.15914820E+07,6.85294117E+07,9.10282102E+07,1.20913559E+08,1.60610526E+08,2.13340350E+08,2.83381832E+08,3.76418539E+08,5.00000000E+08])

electric_field = np.array([1.67991646E-02,1.65938055E-02,1.64433930E-02,1.62604763E-02,1.59888036E-02,1.54691406E-02,1.45422226E-02,1.28449067E-02,9.88862112E-03,5.84947646E-03,7.47797915E-03,1.57255320E-02,1.67406130E-02,5.58125932E-03,1.66617536E-02,4.79317191E-03,5.57415000E-03,6.57799133E-03,1.16742333E-02,9.49196493E-03,9.63656695E-03,8.73518254E-03,3.46542278E-03,4.84864010E-03,1.94981508E-03,3.61156456E-03,1.29130940E-02,1.19965239E-02,9.80418010E-03,3.57842256E-03,1.10345809E-02])

# 绘图
fig, ax = plt.subplots(figsize=(10, 5))
ax.plot(frequencies, electric_field, 'r-o', linewidth=1.5, markersize=6, label='Magnetic Field Magnitude')

# 设置对数横轴
ax.set_xscale('log')
ax.set_xlim([1e5, 5e8])
ax.set_xticks([1e5, 10e6, 100e6, 500e6])
ax.set_xticklabels(['0.1 MHz', '10 MHz', '100 MHz', '500 MHz'])

ax.set_xlabel('Frequency (Hz)', fontsize=20)
ax.set_ylabel('Magnetic Field Magnitude (mA/m)', fontsize=20)
ax.set_title('Near Magnetic Field Magnitude vs Frequency', fontsize=22)
ax.tick_params(axis='both', labelsize=16)
ax.grid(True)
ax.legend(fontsize=16, loc='best')

plt.tight_layout()
plt.savefig('hlh.png', dpi=300, bbox_inches='tight')
plt.show()
