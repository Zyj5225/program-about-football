function [walkfs,runfs,rushfs]= calculatef(high) 
    walkfs=(high-155.911)/0.262;
    runfs=walkfs*1.463;
    rushfs=walkfs*1.837;
end
