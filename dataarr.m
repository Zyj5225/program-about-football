function [hpoint,location]=dataarr(gyrZ)

  [hpointt,locationn]=findpeaks(gyrZ);
  hpoint=zeros(length(hpointt),1);
  location=zeros(length(hpointt),1);
  j=1;
  for i=2:length(hpoint)
      t1=locationn(i-1,1);t2=locationn(i,1);
      if min(hpointt(i-1,1),hpointt(i,1))- min(gyrZ(t1:t2,1))<=90 %tuning parameter 
          if gyrZ(t1,1)>=gyrZ(t2,1)
             hpointt(i,1)=hpointt(i-1,1);
             locationn(i,1)=locationn(i-1,1);
          else 
              hpointt(i-1,1)=hpointt(i,1);
              locationn(i-1,1)=locationn(i,1);
          end
      else
          hpoint(j,1)=hpointt(i-1,1);
          location(j,1)=locationn(i-1,1);
          j=j+1;
      end     
  end
  hpoint(j,1)=hpointt(i,1);
  location(j,1)=locationn(i,1);    
  location(find(location==0))=[];
  hpoint(find(hpoint==0))=[];
  

end
