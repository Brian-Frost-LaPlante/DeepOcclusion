function [X,Y,Z,V] = randPoly(x,y,z,N,ns,sd,coeffmax,thickness)
    % x, y, z are axes, n polynomial order, sd is noise
    [X,Y,Z] = ndgrid(x,y,z);
    V = randn(size(X))*sd;
    [pX,pY] = meshgrid(x,y); pval = zeros(size(pX));
    for M = 1:N
        for m = 0:ns(M)
            % for each order term there are m+1 different combs
            for k = 0:m
                coeff = coeffmax*(rand(1)-.5); % random from -1 to 1
                pval = pval+coeff*(pX.^k).*(pY.^(m-k));
            end
        end
        for i = 1:(length(x))
            for j = 1:length(y)
                zz = pval(i,j)-z;
                [~,ind] = min(abs(zz));
                T = uint8(rand(1)*thickness);
                for t=0:T
                    if (ind+t)<length(z)
                        V(i,j,ind+t) = 1;
                    end
                end
            end
        end
    end
end