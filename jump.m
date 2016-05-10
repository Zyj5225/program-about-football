function [jumpnum,jumpdis]=jump(gyrZ)
  [hpoint,location]=dataarr(gyrZ);
  jumpnum=0;
  jumpdis=zeros(length(hpoint),1);
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