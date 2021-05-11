function Random_numbers_intoCircle(radius,circle_center,numberOfrandomSamples,dimension,evolutionGeneration)
%% Created by Ehsan Farzadnia , M.Sc of Soft Secure Computing at Malek Ashtar University of Technology. 2018/05/16 
% This Source Code produce a uniformly random generated n-dimentional Samples in Polar Coordination only within a super-ring shape. 
% dimension must be bigger than 2 or equal.
%% the Polar Coordination of an n-dimensional Sample d'y1d'y2...d'y_n randomly generated within a Super-ring hyper shape with center of dy1dy2...dy_n and a specific raduis, p is the Polar diameter

% d'y_1 = dy_1 + p.cos(teta1)  
% d'y_2 = dy_2 + p.sin(teta1) * cos(teta2)
%      ...
% d'y_n-1 = dy_n-1 + p.sin(teta1) * sin(teta2) …cos(teta_n-1)
% d'y_n = dy_n + p.sin(teta1) * sin(teta2) … sin(teta_n-1)  

%% My Supervisors : Dr. Hossein Shirazi and Alireza Nowroozi

% dis = 0;
s = 'cosinos';

rectangle('Position',[circle_center(1)-radius,circle_center(2)-radius,2*radius,2*radius],'Curvature',[1,1]);
axis([-5 5 -5 5]);

% while(size(dis(dis >= radius),1) == 0)
       for nn = 1 : numberOfrandomSamples
           [distance] = distance_alc(radius,dimension,evolutionGeneration);
            for iTeta = 1 : dimension - 1
               [teta(iTeta)] = tetaCalc;  
            end
                for d = 1 : dimension
                    if d == dimension
                        s = 'sinous';
                    end
                        if d == 1
                           nodes(d,nn) = circle_center(d) + (distance  * cos(teta(d)));
                        else
                            i = 1;
                            prod = 1;
                            while(i <= d - 1)
                                prod = prod * sin(teta(i));
                                i = i + 1;
                            end
                                if strcmp(s,'sinous')
                                    nodes(d,nn) = circle_center(d) + (distance * prod);
                                else
                                    nodes(d,nn) = circle_center(d) + (distance * prod * cos(teta(i)));
                                end
                        end
                end
        end
         
        for i = 1 : numberOfrandomSamples
            dis(i,1) = pdist2(transpose(nodes(:,i)),circle_center,'euclidean');
        end
        disp(dis);
        disp(['The number of random samples are upper bound is : ',  num2str(size(dis(dis >= radius),1))]);
        disp(dis(dis >= radius));

% end

%% plotting ... 
 
    hold on 
    plot(circle_center(1)+nodes(1,:),circle_center(2)+nodes(2,:),'rs','LineWidth',5,'MarkerSize',1.5);
    
end

function distance = distance_alc(radius,dimension,evolutionGeneration)
%     a = 0;
%     b = radius;
%     distance = a + ((b - a) * unifrnd(0,1));
%     
 distance = unifrnd((sqrt(dimension)/exp(evolutionGeneration)),(sqrt(dimension)/exp(evolutionGeneration - 1)));

end


function teta = tetaCalc
    a = 0;
    b = 2 * pi;
    teta = a + ((b - a) * unifrnd(0,1));
end