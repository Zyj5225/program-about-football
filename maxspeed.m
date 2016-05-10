function maxspeed=maxspeed(posi,sta)
   diff=zeros(length(sta),1);
   diff=diff+1000;
   for i=1:(length(sta)-1)
       if (sta(i,1)<=3)&&(sta(i+1,1)<=3)
           diff(i,1)=posi(i+1,1)-posi(i,1);
       end
   end
   minposi=min(diff);
   if minposi<=12
       maxspeed=2.7/(minposi/20);
   elseif minposi>12&&minposi<16
       maxspeed=2.15/(minposi/20);
   else
       maxspeed=1.47/(minposi/20);
   end
end

