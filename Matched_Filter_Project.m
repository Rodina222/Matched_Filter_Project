clear all;
clc;
%PAM=2

t=0:0.0001:1-0.0001+0.05;  %number of generated bits (10,500)

bits=randi([0 1],1,length(t)); %generating random bits
%% Sampling with sample rate 3
version_1=[];
for i=1:length(bits)
    if bits(i)== 0
        version_1=[version_1 0 0 0];
    elseif bits(i)==1
         version_1=[version_1 1 1 1];
        
    end
end
SNR_Array=[];
Error=[];
errors=0;
%% Channel & Receiver
for SNR=0:0.5:25
   Channel=awgn(version_1,SNR,'measured');
   
   Recieved_1=[];
   for j=1:3:length(version_1)-3
       Matched=conv(Channel(j:j+3),Channel(j:j+3));
       if(sqrt(Matched(3)/3)>=0.5)
       Recieved_1=[Recieved_1 1];
       elseif (sqrt(Matched(3)/3)<0.5)
          Recieved_1=[Recieved_1 0]; 
       end
   end
    for k=1:length(bits)-1
        n=bits(k);
        m=Recieved_1(k);
        if n~=m
        errors=errors+1;
        end
    end
    SNR_Array=[SNR_Array SNR];
    Error=[Error errors/length(bits)];
    errors=0;
end
figure(1)
semilogy(SNR_Array,Error);


%***********************

%%   PAM=4
bits2=randi([0 3],1,length(t)); %generating random bits
%% Sampling with sample rate 3
version_2=[];
for i=1:length(bits2)
    if bits2(i)== 0
        version_2=[version_2 0 0 0];
    elseif bits2(i)==1
         version_2=[version_2 1 1 1];
    elseif bits2(i)==2
         version_2=[version_2 2 2 2];
    elseif bits2(i)==3
         version_2=[version_2 3 3 3];
    end
end
%% intialization
SNR_Array2=[];
Error2=[];
errors=0;

%% Channel & Receiver (Matched filter)
for SNR=0:0.5:25
   Channel2=awgn(version_2,SNR,'measured');
   Recieved_2=[];
   for j=1:3:length(version_2)-3
       Matched2=conv(Channel2(j:j+3),Channel2(j:j+3));
       bitValue=sqrt(Matched2(3)/3);
       if bitValue<0.5
           Recieved_2=[Recieved_2 0];
       elseif(bitValue>=0.5 && bitValue<1.5)
       Recieved_2=[Recieved_2 1];
       elseif (bitValue>=1.5 && bitValue<2.5 )
          Recieved_2=[Recieved_2 2];
       elseif (bitValue>=2.5)
          Recieved_2=[Recieved_2 3];
       end
   end
    for k=1:length(bits2)-1
        n=bits2(k);
        m=Recieved_2(k);
        if n~=m
        errors=errors+1;
        end
    end
    SNR_Array2=[SNR_Array2 SNR];
    Error2=[Error2 errors/length(bits)];
    errors=0;
end
hold on;

semilogy(SNR_Array2,Error2);



%% %%   PAM=8
bits3=randi([0 7],1,length(t)); %generating random bits
%% Sampling with sample rate 3
version_3=[];
for i=1:length(bits3)
    if bits3(i)== 0
        version_3=[version_3 0 0 0];
    elseif bits3(i)==1
         version_3=[version_3 1 1 1];
    elseif bits3(i)==2
         version_3=[version_3 2 2 2];
    elseif bits3(i)==3
         version_3=[version_3 3 3 3];
    elseif bits3(i)==4
         version_3=[version_3 4 4 4];
    elseif bits3(i)==5
         version_3=[version_3 5 5 5];
    elseif bits3(i)==6
         version_3=[version_3 6 6 6];
    elseif bits3(i)==7
         version_3=[version_3 7 7 7];
    end
end
%% intialization
SNR_Array3=[];
Error3=[];
errors=0;

%% Channel & Reciever (Matched filter)
for SNR=0:0.5:25
   Channel3=awgn(version_3,SNR,'measured');
   Recieved_3=[];
   for j=1:3:length(version_3)-3
       Matched3=conv(Channel3(j:j+3),Channel3(j:j+3));
       bitValue=sqrt(Matched3(3)/3);
       if bitValue<0.5
           Recieved_3=[Recieved_3 0];
       elseif(bitValue>=0.5 && bitValue<1.5)
       Recieved_3=[Recieved_3 1];
       elseif (bitValue>=1.5 && bitValue<2.5 )
          Recieved_3=[Recieved_3 2];
       elseif (bitValue>=2.5 && bitValue<3.5)
          Recieved_3=[Recieved_3 3];
       elseif (bitValue>=3.5 && bitValue<4.5)
          Recieved_3=[Recieved_3 4];
       elseif (bitValue>=4.5 && bitValue<5.5)
          Recieved_3=[Recieved_3 5];
       elseif (bitValue>=5.5 && bitValue<6.5)
          Recieved_3=[Recieved_3 6];
       elseif (bitValue>=6.5)
          Recieved_3=[Recieved_3 7];
       end
   end
    for k=1:length(bits3)-1
        n=bits3(k);
        m=Recieved_3(k);
        if n~=m
        errors=errors+1;
        end
    end
    SNR_Array3=[SNR_Array3 SNR];
    Error3=[Error3 errors/length(bits)];
    errors=0;
end
hold on;
semilogy(SNR_Array3,Error3);
title('BER VS SNR');
xlabel('SNR');
ylabel('BER');
legend('2-PAM','4-PAM','8-PAM');