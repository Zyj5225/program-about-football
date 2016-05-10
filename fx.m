function [sta,pos,maxsp,distance,rushnum,runnum,walknum,shnum,jumpnum,rushdis,rundis,walkdis,jumpdis,accshoot]=fx(gyrZ,accX,accY,accZ)

acc_mag = sqrt(accX.*accX + accY.*accY + accZ.*accZ);
   
% [Num,posi]=peaknum(gyrZ);
[Num,loca]=findpeaks(gyrZ);
[Num,loc]=findpeaks(Num);
posi=zeros(length(Num),1);
for i=1:length(Num)
    posi(i,1)=loca(loc(i,1));
end
%------------------------------------------------------------------------
pos = zeros(length(Num),3);
% [sta,footstep]=jundgefts(posi,Num);
sta=zeros(length(posi),1);
   footstep=zeros(length(posi),1);
   dif=diff(posi);
   i=1;
   while(i<=length(dif)-1)
         if (max(Num(i:i+1,1))-min(Num(i:i+1,1)))<900   %没有射门
             j=i;
             if dif(j,1)<=12                    %冲刺
                   sta(j,1)=1;
                   footstep(j,1)=2.7;
             elseif dif(j,1)>12&&dif(j,1)<16    %快跑
                   sta(j,1)=2;
                   footstep(j,1)=2.15;
             elseif dif(j,1)>=16                %慢跑
                   sta(j,1)=3;
                  footstep(j,1)=1.47;
             end
           
         else
             sta(i:i+1,1)=4;
             footstep(i:i+1,1)=0;
         end
         i=i+1;
   end
   j=length(dif);
    if (max(Num(j:j+1,1))-min(Num(j:j+1,1)))<900   %是否射门
             if dif(j,1)<=12                    %冲刺
                   sta(j,1)=1;
                   footstep(j,1)=2.7;
             elseif dif(j,1)>12&&dif(j,1)<16    %快跑
                   sta(j,1)=2;
                   footstep(j,1)=2.15;
             elseif dif(j,1)>=16                %慢跑
                   sta(j,1)=3;
                  footstep(j,1)=1.47;
             end
    else
        sta(j,1)=4;
        footstep(j,1)=0;
    end
   sta(length(posi),1)=sta(length(posi)-1,1);
   footstep(length(posi),1)=footstep(length(posi)-1,1);
%--------------------------------------------------------------------
for t = 2:length(Num)
    pos(t,1) = pos(t-1,1) + footstep(t,1);    
end

%-----------------------------------------------------------
% maxsp=maxspeed(posi,sta);
diffe=zeros(length(sta),1);
   diffe=diffe+1000;
   for i=1:(length(sta)-1)
       if (sta(i,1)<=3)&&(sta(i+1,1)<=3)
           diffe(i,1)=posi(i+1,1)-posi(i,1);
       end
   end
   minposi=min(diffe);
   if minposi<=12
       maxsp=2.7/(minposi/20);
   elseif minposi>12&&minposi<16
       maxsp=2.15/(minposi/20);
   else
       maxsp=1.47/(minposi/20);
   end
%---------------------------------------------------------
distance=pos(length(Num),1);

%-----------------------------------------------------
% [rushnum,runnum,walknum,rushdis,rundis,walkdis]=NumandDis(sta);
   rushnum=0;
   runnum=0;
   walknum=0;
   rushdis=0;
   rundis=0;
   walkdis=0;
   stanum=zeros(length(sta),1);
   staloc=zeros(length(sta),1);
   stanum(1,1)=sta(1,1);
   staloc(1,1)=1;
   j=1;
   for i=1:length(sta)
       if(sta(i,1)~=stanum(j,1))
           j=j+1;
           stanum(j,1)=sta(i,1);
           staloc(j,1)=i;
       end
   end
   staloc(staloc==0)=[];
   stanum(stanum==0)=[];
   diffstaloc=diff(staloc);
   diffstaloc=[diffstaloc; length(sta)-staloc(length(staloc),1)];
   for i=1:length(stanum)
       if stanum(i,1)==1
          rushnum=rushnum+1;
          rushdis=rushdis+2.7*diffstaloc(i,1);
       elseif stanum(i,1)==2
              runnum=runnum+1; 
              rundis=rundis+2.15*diffstaloc(i,1);
       elseif stanum(i,1)==3
           walknum=walknum+1;
           walkdis=walkdis+1.47*diffstaloc(i,1);
       end
   end

%----------------------------------------------------------
% shnum=shootnum(sta);
shnum=0;
  for i=1:length(sta)-1
      if (sta(i,1)==4&&sta(i+1,1)~=4)||(sta(i,1)==4&&i==length(sta)-1)
          shnum=shnum+1;   
      end
  end
%------------------------------------------------------------
% accshoot=accofshoot(acc_mag,sta,posi);
accshoot=zeros(length(sta),1);
 i=1;
 k=1;
 while(i<=length(sta))
     if sta(i,1)==4
         m=i;
         for j=i:length(sta)
             if sta(j,1)~=4
                 n=j-1;
                 break;
             end
             if j==length(sta)
                 n=j;
             end
         end
         i=j+1;
         t1=posi(m,1);
         t2=posi(n,1);
         accshoot(k,1)=max(acc_mag(t1:t2,1));
         k=k+1;
     else i=i+1;
     end
 end
 %-----------------------------------------------------------
% [jumpnum,jumpdis]=jump(gyrZ);

[hpoint,location]=dataarr(gyrZ);
  jumpnum=0;
  jumpdis=zeros(10,1);
  for i=2:length(hpoint)
      if hpoint(i-1,1)>100&&hpoint(i,1)>100 %参数可改 波峰要足够大
          t1=location(i-1,1);t2=location(i,1);
          if min(hpoint(i-1,1),hpoint(i,1))-min(gyrZ(t1:t2,1))<300%参数可改
              jumpnum=jumpnum+1;
              jumpdis(jumpnum,1)=0.5*8.9*((t2-t1)/40)*((t2-t1)/40);
          end
      end      
  end
end