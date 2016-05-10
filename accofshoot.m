function accshoot=accofshoot(acc,sta,posi)
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
         accshoot(k,1)=max(acc(t1:t2,1));
         k=k+1;
     else i=i+1;
     end
     
 end
         
  
end