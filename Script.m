clear;
close all;
clc;
addpath('Quaternions');
addpath('ximu_matlab_library');

% -------------------------------------------------------------------------
% Select dataset (comment in/out)

% filePath= 'Datasets/slinetest3';
% startTime = 2 ;
% stopTime =30;

% filePath= 'Datasets/shoot6';
% startTime = 0 ;
% stopTime =12.5;
filePath= 'Datasets/dianqiu8';
startTime = 0 ;
stopTime =7.5;
% -------------------------------------------------------------------------
% Import data
samplePeriod = 1/20;
xIMUdata = xIMUdataClass(filePath, 'InertialMagneticSampleRate', 1/samplePeriod);
time = xIMUdata.CalInertialAndMagneticData.Time;
gyrX = xIMUdata.CalInertialAndMagneticData.Gyroscope.X;
gyrY = xIMUdata.CalInertialAndMagneticData.Gyroscope.Y;
gyrZ = xIMUdata.CalInertialAndMagneticData.Gyroscope.Z;
accX = xIMUdata.CalInertialAndMagneticData.Accelerometer.X;
accY = xIMUdata.CalInertialAndMagneticData.Accelerometer.Y;
accZ = xIMUdata.CalInertialAndMagneticData.Accelerometer.Z;
clear('xIMUdata');

% -------------------------------------------------------------------------
indexSel = find(sign(time-startTime)+1, 1) : find(sign(time-stopTime)+1, 1);
time = time(indexSel);
gyrX = gyrX(indexSel, :);
gyrY = gyrY(indexSel, :);
gyrZ = gyrZ(indexSel, :);
accX = accX(indexSel, :);
accY = accY(indexSel, :);
accZ = accZ(indexSel, :);

% -----------------------------------------------------------------------

% Compute accelerometer magnitude
acc_mag = sqrt(accX.*accX + accY.*accY + accZ.*accZ);

% Plot data raw sensor data
figure('Position', [9 39 900 600], 'Number', 'off', 'Name', 'Sensor Data');
ax(1) = subplot(2,1,1);
    hold on;
    plot(time, gyrX, 'r');
    plot(time, gyrY, 'g');
    plot(time, gyrZ, 'b');
    title('Gyroscope');
    xlabel('Time (s)');
    ylabel('Angular velocity (^\circ/s)');
    legend('X', 'Y', 'Z');
    hold off;
ax(2) = subplot(2,1,2);
    hold on;
    plot(time, accX, 'r');
    plot(time, accY, 'g');
    plot(time, accZ, 'b');
    title('Accelerometer');
    xlabel('Time (s)');
    ylabel('Acceleration (g)');
    hold off;
    linkaxes(ax,'x');

% % -------------------------------------------------------------------------
[sta,pos,maxsp,distance,rushnum,runnum,walknum,shnum,jumpnum,rushdis,rundis,walkdis,jumpdis,accshoot]=fx(gyrZ,accX,accY,accZ);
%pos表示每跑一步之后的路程
%maxsp表示在一段运动过程中的最大速度
%distance表示运动的路程 
%rushnum表示冲刺次数，rushdis为冲刺距离
%runnum表示跑步此处，rundis为跑步距离
%walknum 表示走路次数，walkdis为走路距离
%shnum表示射门次数， accshoot为射门力量
%jumpnum表示起跳次数，jumpdis表示每次起跳高度


% [Num,posi]=peaknum(gyrZ);
% pos = zeros(length(Num),3);
% [sta,footstep]=jundgefts(posi,Num);
% for t = 2:length(Num)
%     pos(t,1) = pos(t-1,1) + footstep(t,1);    % integrate velocity to yield position
% end
% maxspeed=maxspeed(posi,sta);
% distance=pos(length(Num),1);
% [rushnum,runnum,walknum,rushdis,rundis,walkdis]=NumandDis(sta);
% shootnum=shootnum(sta);
% accshoot=accofshoot(acc_mag,sta,posi);
% [jumpnum,jumpdis]=jump(gyrZ);
% -------------------------------------------------------------------------
% Plot 3D foot trajectory  该画图函数是在网上找的，可以换成其他的
posPlot = pos;
quatPlot = zeros(size(pos,1),4);
extraTime = 20;
onesVector = ones(extraTime*(1/samplePeriod), 1);
SamplePlotFreq = 1;
Spin = 12;
SixDofAnimation(posPlot, quatern2rotMat(quatPlot), ...
                'SamplePlotFreq', SamplePlotFreq, 'Trail', 'DotsOnly', ...
                'Position', [9 39 1280 768], 'View', [(100:(Spin/(length(posPlot)-1)):(100+Spin))', 10*ones(length(posPlot), 1)], ...
                'AxisLength', 0.1, 'ShowArrowHead', false, ...
                'Xlabel', 'X (m)', 'Ylabel', 'Y (m)', 'Zlabel', 'Z (m)', 'ShowLegend', false, ...
                'CreateAVI', false, 'AVIfileNameEnum', false, 'AVIfps', ((1/samplePeriod) / SamplePlotFreq));


