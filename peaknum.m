function [Num, posi]=peaknum(vect)

  [Num,loca]=findpeaks(vect);
   [Num,loc]=findpeaks(Num);
   posi=zeros(length(Num),1);
   for i=1:length(Num)
       posi(i,1)=loca(loc(i,1));
   end
 
end

