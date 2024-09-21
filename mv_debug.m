maxGen=300;
Rmv_line=zeros([maxGen 1]);
x5_ave=zeros([maxGen 1]);

x4_ave=zeros([maxGen 1]);
x4_max=zeros([maxGen 1]);
x4_min=zeros([maxGen 1]);

x1_ave=zeros([maxGen 1]);
x1_max=zeros([maxGen 1]);
x1_min=zeros([maxGen 1]);

x2_ave=zeros([maxGen 1]);
x2_max=zeros([maxGen 1]);
x2_min=zeros([maxGen 1]);

x3_ave=zeros([maxGen 1]);
x3_max=zeros([maxGen 1]);
x3_min=zeros([maxGen 1]);

x6_ave=zeros([maxGen 1]);
x6_max=zeros([maxGen 1]);
x6_min=zeros([maxGen 1]);

x7_ave=zeros([maxGen 1]);
x7_max=zeros([maxGen 1]);
x7_min=zeros([maxGen 1]);

x8_ave=zeros([maxGen 1]);
x8_max=zeros([maxGen 1]);
x8_min=zeros([maxGen 1]);

x9_ave=zeros([maxGen 1]);
x9_max=zeros([maxGen 1]);
x9_min=zeros([maxGen 1]);

x10_ave=zeros([maxGen 1]);


%1. heart rate debug
for i=1:maxGen
    %Cv=36; 
    %Emax1=3;
    Rmv=0.004;
    Rmv_re=0.04+1/maxGen*(i-1)*3;
    %HR=80;
    %Rscr=1.1;

    Rmv_line(i)=Rmv_re;
    disp(Rmv_re);
    output=sim('two_cycle_mv.slx',12,[]); %运行simulink文件
    
    x4=output.x4; 
    x4_data=get_ave(x4);
    x4_max(i)=x4_data(1);
    x4_min(i)=x4_data(2);
    x4_ave(i)=x4_data(3); %获得x4的平均值,储存在数组中

    x1=output.x1; 
    x1_data=get_ave(x1);
    x1_max(i)=x1_data(1);
    x1_min(i)=x1_data(2);
    x1_ave(i)=x1_data(3); %获得x1的平均值,储存在数组中

    x2=output.x2; 
    x2_data=get_ave(x2);
    x2_max(i)=x2_data(1);
    x2_min(i)=x2_data(2);
    x2_ave(i)=x2_data(3); %获得x2的平均值,储存在数组中

    x3=output.x3; 
    x3_data=get_ave(x3);
    x3_max(i)=x3_data(1);
    x3_min(i)=x3_data(2);
    x3_ave(i)=x3_data(3); %获得x3的平均值,储存在数组中

    x6=output.x6; 
    x6_data=get_ave(x6);
    x6_max(i)=x6_data(1);
    x6_min(i)=x6_data(2);
    x6_ave(i)=x6_data(3); %获得x6的平均值,储存在数组中

    x7=output.x7; 
    x7_data=get_ave(x7);
    x7_max(i)=x7_data(1);
    x7_min(i)=x7_data(2);
    x7_ave(i)=x7_data(3); %获得x7的平均值,储存在数组中

    x8=output.x8; 
    x8_data=get_ave(x8);
    x8_max(i)=x8_data(1);
    x8_min(i)=x8_data(2);
    x8_ave(i)=x8_data(3); %获得x8的平均值,储存在数组中

    x9=output.x9; 
    x9_data=get_ave(x9);
    x9_max(i)=x9_data(1);
    x9_min(i)=x9_data(2);
    x9_ave(i)=x9_data(3); %获得x9的平均值,储存在数组中

    x5=output.x5; 
    x5_data=get_inte(x5); %x5使用积分的方法
    x5_ave(i)=x5_data*60/1000; %获得x5的平均值,储存在数组中

    x10=output.x10; 
    x10_data=get_inte(x10); %x5使用积分的方法
    x10_ave(i)=x10_data*60/1000; %获得x5的平均值,储存在数组中
end

%draw the plot
figure();
subplot(221);plot(Rmv_line,x2_ave, '-o');
xlabel('Rmv');
ylabel('Left atrial pressure(mmHg)');
subplot(222);plot(Rmv_line,x7_ave,'-o');
xlabel('Rmv');
ylabel('Right ventricular pressure(mmHg)');
subplot(223);plot(Rmv_line,x8_ave,'-o');
xlabel('Rmv');
ylabel('Pulmonary artery pressure(mmHg)');
subplot(224);plot(Rmv_line,x9_ave,'-o');
xlabel('Rmv');
ylabel('Pulmonary venous pressure(mmHg)');

figure();
subplot(221);plot(Rmv_line,x1_ave, '-o');
xlabel('Rmv');
ylabel('Left ventricular pressure(mmHg)');
subplot(222);plot(Rmv_line,x3_ave,'-o');
xlabel('Rmv');
ylabel('Central venous pressure(mmHg)');
subplot(223);plot(Rmv_line,x4_ave,'-o');
xlabel('Rmv');
ylabel('Systemic arterial pressure(mmHg)');
subplot(224);plot(Rmv_line,x6_ave,'-o');
xlabel('Rmv');
ylabel('Right atrial pressure(mmHg)');

figure();
subplot(211);plot(Rmv_line,x5_ave, '-o');
xlabel('Rmv');
ylabel('Systemic circulation flow(L/min)');
subplot(212);plot(Rmv_line,x10_ave,'-o');
xlabel('Rmv');
ylabel('Pulmonary circulation flow(L/min)');


function y=get_ave(x)
    x1=x.data; %timeseries数据段转化为矩阵
    x1=x1(8009:10008, : ); %提取8-10s的内容
    max_num=max(x1); %获取最大值
    min_num=min(x1); %最小值
    ave=max_num*0.67+min_num*0.33; %计算平均值
    y=[max_num,min_num,ave];
end

function y=get_inte(x)
    x_d=x.data; %timeseries数据段转化为矩阵
    x_d=x_d(8009:10008, : ); %提取8-10s的内容
    y=mean(x_d);

end



