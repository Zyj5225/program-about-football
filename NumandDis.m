function [rushnum,runnum,walknum,rushdis,rundis,walkdis]=NumandDis(sta)
   i=1;
   t=1;
   rushnum=0;
   runnum=0;
   walknum=0;
   rushdis=0;
   rundis=0;
   walkdis=0;
   while 1
       j=i;
       while 1
           j=j+1;
           if j>=length(sta)||(sta(j,1)~=sta(i,1)&&sta(j+1,1)~=sta(i,1))
               break;
           end
       end
       if j==length(sta)
           j=j+1;
       end
       if j>=i+3
           if sta(i,1)==1
               rushnum=rushnum+1;
               rushdis=rushdis+(j-t)*2.7;
               t=j;
           elseif sta(i,1)==2
               runnum=runnum+1;
               rundis=rundis+(j-t)*2.15;
               t=j;
           elseif sta(i,1)==3; 
               walknum=walknum+1;
               walkdis=walkdis+(j-t)*1.47;
               t=j;
           elseif sta(i,1)==4
               t=j;
               
           end
       end
       i=j;
       if i>=length(sta)
           break;
       end
   end
       
           
end
