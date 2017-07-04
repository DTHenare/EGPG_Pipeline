function [ electrodePairs ]= getElectrodePairs(chanlocs, numElectrodes)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

index = 1;
for i = 1:numElectrodes
    for j = 1:numElectrodes
        currentY=chanlocs(1,i).Y;
        currentX=chanlocs(1,i).X;
        currentZ=chanlocs(1,i).Z;
        if currentY<0
            if (chanlocs(1,j).Y == (currentY*-1) && chanlocs(1,j).Z == currentZ && chanlocs(1,j).X == currentX && chanlocs(1,j).Y ~=0)
                electrodePairs(index,1)=i;
                electrodePairs(index,2)=j;
                index=index+1;
            end
        end
    end
end

end

