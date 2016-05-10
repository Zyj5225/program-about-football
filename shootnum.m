function shootnum=shootnum(sta)
shootnum=0;
  for i=1:length(sta)-1
      if (sta(i,1)==4&&sta(i+1,1)~=4)||(sta(i,1)==4&&i==length(sta)-1)
          shootnum=shootnum+1;   
      end
  end

end