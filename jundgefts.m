function [sta,fts]=jundgefts(posi,Num)
   sta=zeros(length(posi),1);
   fts=zeros(length(posi),1);
   dif=diff(posi);
   i=1;
   while(i<=length(dif)-1)
         if (max(Num(i:i+1,1))-min(Num(i:i+1,1)))<900   %û������
             j=i;
             if dif(j,1)<=12                    %���
                   sta(j,1)=1;
                   fts(j,1)=2.7;
             elseif dif(j,1)>12&&dif(j,1)<16    %����
                   sta(j,1)=2;
                   fts(j,1)=2.15;
             elseif dif(j,1)>=16                %����
                   sta(j,1)=3;
                  fts(j,1)=1.47;
             end
            
         else
             sta(i:i+1,1)=4;
             fts(i:i+1,1)=0;
         end
         i=i+1;
   end
   j=length(dif);
    if (max(Num(j:j+1,1))-min(Num(j:j+1,1)))<900   %�Ƿ�����
             if dif(j,1)<=12                    %���
                   sta(j,1)=1;
                   fts(j,1)=2.7;
             elseif dif(j,1)>12&&dif(j,1)<16    %����
                   sta(j,1)=2;
                   fts(j,1)=2.15;
             elseif dif(j,1)>=16                %����
                   sta(j,1)=3;
                  fts(j,1)=1.47;
             end
    else
        sta(j,1)=4;
        fts(j,1)=0;
    end
   sta(length(posi),1)=sta(length(posi)-1,1);
   fts(length(posi),1)=fts(length(posi)-1,1);
end