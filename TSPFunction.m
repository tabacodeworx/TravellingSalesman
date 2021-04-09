function [tour, objVec] = TSPFunction(adjMat, A, nSearch)

% get instance matrix
n = size(adjMat,1);

% initialize tour
tour = [(1:n)'; 1]; 
obj = getObj(tour,adjMat,n);
objVec = obj;
figure(2); subplot(1,2,1); showtour(A); axis square; axis off;
title('INITIAL TOUR');

% begin search
for i = 1:nSearch
    infeasible = 1;
    while infeasible
        ind = randi(n,2,1);
        infeasible = length(unique(ind))~=2 || abs(diff(ind))<= 1;
    end
    newTour = swap(tour,ind);
    obj = getObj(newTour,adjMat,n);
    if i>1
        if obj < objVec(i-1);
            tour = newTour;
            objVec = [objVec; obj];
        else
            objVec = [objVec; objVec(i-1)];
        end
    end
    figure(1); plot(objVec);
    newA = A(newTour(1:end-1),:);
    figure(2); subplot(1,2,2); showtour(newA); axis square; axis off; 
end
newA = A(tour(1:end-1),:);
figure(2); subplot(1,2,2); showtour(newA); axis square; axis off; 
title('OPTIMAL TOUR');
legend('Intermediate Vertices', 'Starting Vertex', 'Final Vertex');


function obj = getObj(tour,adjMat,n)
obj = 0;
for i = 1:n
    obj = obj + adjMat(tour(i),tour(i+1));
end


function newTour = swap(tour,ind)
ind_s = sort(ind);
newTour = [tour(1:ind_s(1)); flipud(tour(1+ind_s(1):ind_s(2))); tour(1+ind_s(2):end)];


function showtour(A)
hold off; 
plot(A(:,2),A(:,3),'o-','markerfacecolor','c','markersize',6); hold on
plot([A(1,2) A(end,2)],[A(1,3) A(end,3)],'o-','markerfacecolor','g','markersize',6);
plot(A(end,2),A(end,3),'ko','markerfacecolor','r','markersize',6)

