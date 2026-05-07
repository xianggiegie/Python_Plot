% 第一个文件（电场Ex）的读取代码
filename_Ex = 'E:\fekowenjian\Matlab_project\tiqu\006.efe'; % 电场文件
target_X = 0.000000000E+0; % 更新目标X坐标
target_Y = 3.00000000E+01; % 更新目标Y坐标
target_Z = 1.25000000E+00; % 更新目标Z坐标
tolerance = 1e-6;

Re_Ex_all = zeros(31, 1);
Im_Ex_all = zeros(31, 1);
frequencies_Ex = zeros(31, 1);

fid_Ex = fopen(filename_Ex, 'r');
freq_count_Ex = 0;
expected_points = 21 * 11 * 9;

while ~feof(fid_Ex)
    while ~feof(fid_Ex)
        line = fgetl(fid_Ex);
        if contains(line, '#Frequency:')
            freq_count_Ex = freq_count_Ex + 1;
            freq_str = strsplit(line, ':');
            frequencies_Ex(freq_count_Ex) = str2double(strtrim(freq_str{2}));
            break;
        end
    end
    while ~feof(fid_Ex)
        line = fgetl(fid_Ex);
        if ~isempty(line) && line(1) ~= '#' && line(1) ~= '*'
            break;
        end
    end
    data = textscan(fid_Ex, '%f %f %f %f %f %f %f %f %f', expected_points, ...
        'CollectOutput', true, 'HeaderLines', 0, 'MultipleDelimsAsOne', true, 'CommentStyle', '#');
    current_data = data{1};
    found = false;
    for i = 1:size(current_data, 1)
        X = current_data(i, 1);
        Y = current_data(i, 2);
        Z = current_data(i, 3);
        if (abs(X - target_X) < tolerance) && (abs(Y - target_Y) < tolerance) && (abs(Z - target_Z) < tolerance)
            Re_Ex_all(freq_count_Ex) = current_data(i, 4); % Re(Ex)
            Im_Ex_all(freq_count_Ex) = current_data(i, 5); % Im(Ex)
            found = true;
            break;
        end
    end
    if ~found
        warning(['在频点 ' num2str(frequencies_Ex(freq_count_Ex)) ' 未找到目标坐标 (0, 5, 7)']);
    end
    while ~feof(fid_Ex)
        pos = ftell(fid_Ex);
        line = fgetl(fid_Ex);
        if ~isempty(line) && contains(line, '#Frequency:')
            fseek(fid_Ex, pos, -1);
            break;
        end
    end
end
fclose(fid_Ex);
Ex_all = complex(Re_Ex_all(1:freq_count_Ex), Im_Ex_all(1:freq_count_Ex));
frequencies_Ex = frequencies_Ex(1:freq_count_Ex);

% 第二个文件（磁场Hy）的读取代码
filename_Hy = 'E:\fekowenjian\Matlab_project\tiqu\006.hfe'; % 磁场文件
Re_Hy_all = zeros(31, 1);
Im_Hy_all = zeros(31, 1);
frequencies_Hy = zeros(31, 1);

fid_Hy = fopen(filename_Hy, 'r');
freq_count_Hy = 0;

while ~feof(fid_Hy)
    while ~feof(fid_Hy)
        line = fgetl(fid_Hy);
        if contains(line, '#Frequency:')
            freq_count_Hy = freq_count_Hy + 1;
            freq_str = strsplit(line, ':');
            frequencies_Hy(freq_count_Hy) = str2double(strtrim(freq_str{2}));
            break;
        end
    end
    while ~feof(fid_Hy)
        line = fgetl(fid_Hy);
        if ~isempty(line) && line(1) ~= '#' && line(1) ~= '*'
            break;
        end
    end
    data = textscan(fid_Hy, '%f %f %f %f %f %f %f %f %f', expected_points, ...
        'CollectOutput', true, 'HeaderLines', 0, 'MultipleDelimsAsOne', true, 'CommentStyle', '#');
    current_data = data{1};
    found = false;
    for i = 1:size(current_data, 1)
        X = current_data(i, 1);
        Y = current_data(i, 2);
        Z = current_data(i, 3);
        if (abs(X - target_X) < tolerance) && (abs(Y - target_Y) < tolerance) && (abs(Z - target_Z) < tolerance)
            Re_Hy_all(freq_count_Hy) = current_data(i, 6); % Re(Hy)
            Im_Hy_all(freq_count_Hy) = current_data(i, 7); % Im(Hy)
            found = true;
            break;
        end
    end
    if ~found
        warning(['在频点 ' num2str(frequencies_Hy(freq_count_Hy)) ' 未找到目标坐标 (0, 5, 7)']);
    end
    while ~feof(fid_Hy)
        pos = ftell(fid_Hy);
        line = fgetl(fid_Hy);
        if ~isempty(line) && contains(line, '#Frequency:')
            fseek(fid_Hy, pos, -1);
            break;
        end
    end
end
fclose(fid_Hy);
Hy_all = complex(Re_Hy_all(1:freq_count_Hy), Im_Hy_all(1:freq_count_Hy));
frequencies_Hy = frequencies_Hy(1:freq_count_Hy);

% 检查频率是否匹配
if ~isequal(frequencies_Ex, frequencies_Hy)
    error('两个文件的频率点不匹配，请检查文件内容！');
end

% 计算 Ex/Hy
Ex_over_Hy = Ex_all ./ Hy_all;

% 计算模值
Mag_Ex_over_Hy = abs(Ex_over_Hy);

% 显示结果（包括模值）
disp('各频点的Ex/Hy数据（模值）：');
for i = 1:length(frequencies_Ex)
    fprintf('频率: %.2e Hz, |Ex/Hy|: %.6e\n', ...
        frequencies_Ex(i), Mag_Ex_over_Hy(i));
end

% 假设已有数据：frequencies_Ex, Mag_Ex_over_Hy, Ex_all
% 计算第二条曲线数据（例如 |Ex| 的模值）
Mag_Ex = [26.2 45.5 72 90 107 95 81 48.3 122.9 305.6 193.8 312.5 403.8 761 740 1428];

% 绘制 |Ex/Hy| 和 |Ex| 随频率变化的图
figure;
plot(frequencies_Ex, Mag_Ex_over_Hy, 'b-o', 'LineWidth', 1.5, 'DisplayName', 'This paper'); % 第一条曲线
hold on;
plot(frequencies_Ex, Mag_Ex, 'r-^', 'LineWidth', 1.5, 'DisplayName', 'The reference[9]'); % 第二条曲线
plot([1e5 30e6], [377 377], 'k--', 'LineWidth', 1.5, 'DisplayName', 'Free Space (377 Ω)'); % 第三条曲线（横线）
hold off;

% 设置图表属性
xlabel('Frequency (Hz)');
ylabel('Wave impedance (Ω)');
title('Wave impedance vs frequency');
grid on;

% 设置横坐标和纵坐标范围及刻度
set(gca, 'XScale', 'log'); % 横轴为对数刻度
set(gca, 'YScale', 'log'); % 纵轴为对数刻度
set(gca, 'XLim', [1e5 30e6]); % 设置频率范围 0.1MHz 到 30MHz
set(gca, 'XTick', [1e5, 1e6, 10e6, 30e6]); % 设置横轴主要刻度
set(gca, 'XTickLabel', {'0.1 MHz', '1 MHz', '10 MHz', '30 MHz'}); % 设置横轴刻度标签
% 设置字体大小
set(gca, 'FontSize', 14);

% 添加图例
legend('show');

% 调整图形大小
set(gcf, 'Position', [100, 100, 800, 400]);