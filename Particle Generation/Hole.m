clc;
clear all;
clf;
Lx=1;           %change domain length
Ly=1;

Divx=200;       %division of pixels
Divy=200;


Porosity=30;   % porosity of dimension
Order=10;       % coarseness of holes (increase for finer holes)(n*n holes)
DistHoles=1.5; %control distance between holes
Tol_edge=0.01; % Control the distance of the holes from the edges(distance is Tol_edge*L) Value 0 to 1
               %(Note this controls the holes that are not touching the border)

AreaHole=Lx*Ly*Porosity/100;
Lxhole=sqrt(AreaHole);
Lyhole=sqrt(AreaHole);

% Lenx=sort(Lxhole*abs(rand(Order,1)));   %Open for random size holes
% Leny=sort(Lyhole*abs(rand(Order,1)));

Lenx=(0:Lxhole/Order:Lxhole);             %open for same size holes
Leny=(0:Lyhole/Order:Lyhole);

Lenx(1)=0;
Lenx(Order+1)=Lxhole;
Leny(1)=0;
Leny(Order+1)=Lyhole;

for i=1:Order
    for j=1:Order
        Area(i,j)=(Lenx(j+1)-Lenx(j))*(Leny(i+1)-Leny(i));
        Radius(i,j)=sqrt(Area(i,j)/pi);
    end
end

for j=1:Order*Order
    for i=1:Order*Order-1
        ai=floor(i/Order)+1;
        bi=mod(i,Order);
        if(mod(i,Order)==0)
            bi=Order;
            ai=ai-1;
        end
        ai1=floor((i+1)/Order)+1;
        bi1=mod((i+1),Order);
        if(mod(i+1,Order)==0)
            bi1=Order;
            ai1=ai1-1;
        end
        if (Radius(ai,bi)<Radius(ai1,bi1))
            tmp=Radius(ai,bi);
            Radius(ai,bi)=Radius(ai1,bi1);
            Radius(ai1,bi1)=tmp;
        end
    end
end

count=1;
for i=1:Order
    for j=1:Order
        centre(count,:)=[rand*Lx rand*Ly i j];
        flag=1;       %for Overlapping of holes
        flag1=0;      %for adding a portion of the hole on the opposite side which crosses the domain boundary
        while(flag==1)
            flag=0;
            for k=1:count-1
                
                DH=DistHoles*(Radius(centre(k,3),centre(k,4)))+(Radius(centre(count,3),centre(count,4)));
                dist=sqrt((centre(k,1)-centre(count,1))^2+(centre(k,2)-centre(count,2))^2);
                %Above calculates the distance between two holes
                
                 if(Radius(centre(count,3),centre(count,4))+centre(count,1)>Lx)
                     dist2=sqrt((centre(k,1)+Lx-centre(count,1))^2+(centre(k,2)-centre(count,2))^2);
                 else
                     dist2=DistHoles*DH+1;
                 end
                 %Above checks whether the holes is touching the right border and then evaluates the minimum distance between holes
                 
                 if(Radius(centre(count,3),centre(count,4))+centre(count,2)>Ly)
                     dist3=sqrt((centre(k,1)-centre(count,1))^2+(centre(k,2)+Ly-centre(count,2))^2);
                 else
                     dist3=DistHoles*DH+1;
                 end
                 %Above checks whether the holes is touching the top border and then evaluates the minimum distance between holes
                 
                  if(dist<=DH || dist2<=DH || dist3<=DH)
                      flag=1;
                  end
                  %Above checks whether the holes are in accordance to the condition of overlap
                
            end
            if((Radius(centre(count,3),centre(count,4)))+centre(count,1)>Lx || Radius(centre(count,3),centre(count,4))+centre(count,2)>Ly)
                flag1=1;
            elseif((Radius(centre(count,3),centre(count,4)))+centre(count,1)<Tol_edge*Lx || Radius(centre(count,3),centre(count,4))+centre(count,2)<Tol_edge*Ly)
                flag=1;
            end
            %Above checks whether the random centre with a hole crosses the
            %top and right border. If so, then a hole needs to be added on
            %the opposite side so that after the hole is cut off at the edge, the
            %remaining portion is seen on the other side. If the condition
            %is not satisfied check how far the hole is from the edge.
           
            
            if((centre(count,1)-Radius(centre(count,3),centre(count,4)))<Tol_edge*Lx || centre(count,2)-Radius(centre(count,3),centre(count,4))<Tol_edge*Ly)
                flag=1;
            end
            %Above whether the hole crosses the left and bottom edge
            
            if(flag==1)
                centre(count,:)=[rand*Lx rand*Ly i j];
            end
            % if the hole overlapping and border distance conditions are not
            % satisfied a new hole position is selected.
        end
        
        if(flag1==1)
            
            if(Radius(centre(count,3),centre(count,4))+centre(count,1)>Lx && Radius(centre(count,3),centre(count,4))+centre(count,2)>Ly)
                centre(count+1,:)=centre(count,:);
                centre(count+2,:)=centre(count,:);
                centre(count+3,:)=centre(count,:);
                centre(count+1,1)=centre(count,1)-Lx;
                centre(count+2,2)=centre(count,2)-Ly;
                centre(count+3,1)=centre(count,1)-Lx;
                centre(count+3,2)=centre(count,2)-Ly;
                count=count+3;
                
                %if hole is at a corner then it has to be added to all the
                %other corners
            else
                centre(count+1,:)=centre(count,:);
                if(Radius(centre(count,3),centre(count,4))+centre(count,1)>Lx)
                    centre(count+1,1)=centre(count,1)-Lx;
                end
                if(Radius(centre(count,3),centre(count,4))+centre(count,2)>Ly)
                    centre(count+1,2)=centre(count,2)-Ly;
                end
                count=count+1;
                % if a hole is at an edge, it is added to the other
                % edge only
            end    
        end
        %Condition to add a hole on the opposite side if a hole crosses the
        %domain boundary
        count=count+1;
    end
end

figure(1)
count=1;
for i=1:length(centre)
    circle(centre(i,1),centre(i,2),Radius(centre(i,3),centre(i,4)));
end
%Plot the holes and domain

hold on;
rectangle('Position',[-0.1*Lx -0.1*Ly 0.1*Lx 1.2*Ly],'facecolor',[1 1 1],'edgecolor',[1 1 1]);
rectangle('Position',[Lx -0.1*Ly 0.1*Lx 1.2*Ly],'facecolor',[1 1 1],'edgecolor',[1 1 1]);
rectangle('Position',[0 -0.1*Ly Lx 0.1*Ly],'facecolor',[1 1 1],'edgecolor',[1 1 1]);
rectangle('Position',[0 Ly Lx 0.1*Ly],'facecolor',[1 1 1],'edgecolor',[1 1 1]);
rectangle('Position',[0 0 Lx Ly],'edgecolor',[0 0 0]);
hold off;
% Erase of the leftover portion of holes at the edges by using rectangles

Porositycheck=sum(sum(Area))/(Lx*Ly)*100;

nnx= Divx+1;%input('Enter the number of nodes in x-direction :-');
nny= Divy+1;%input('Enter the number of nodes in y-direction :-'); 
%filename='/home/asingh/Research/Diffusion2D_Petsc/tension/tension'
for count=1;
    for j=1:nny-1;
        for i=1:nnx-1;
            kN=[i+nnx*(j-1) i+nnx*(j-1)+1 nnx+i+1+nnx*(j-1) nnx+i+nnx*(j-1)];
            CN(count,:)=kN; % storing connectivity values for each element
            count=count+1;
        end
    end
end

numel=length(CN(:,1));
% co-ordinates

a=Lx/(nnx-1);
b=Ly/(nny-1);

for count=1;
for j=0:nny-1;
    for i=0:nnx-1;
        coor=[i*a j*b];
        co_or(count,:)=coor;
        count=count+1;
    end
end
end
numnp=length(co_or(:,1));

for i=1:numel
    nd=CN(i,:);
    xarr=co_or(nd,1);
    yarr=co_or(nd,2);
    xc=sum(xarr)/4.0;
    yc=sum(yarr)/4.0;
    elem_centre(i,1)=xc;
    elem_centre(i,2)=yc;
end


Gridx=0:Lx/(Divx):Lx;
Gridy=0:Ly/(Divy):Ly;
coord=zeros(Divx*Divx,8);
M=zeros(Divx,Divy);
count=1;
numcircle=length(centre(:,1));

CellDataArray(1:numel)=0.0;

for i=1:numel
        xc=elem_centre(i,1);
        yc=elem_centre(i,2);
                
        for k=1:numcircle
            circ_cen_x=centre(k,1);
            circ_cen_y=centre(k,2);
            rad=sqrt((xc-circ_cen_x)^2+(yc-circ_cen_y)^2);  
          
            if(rad<(Radius(centre(k,3),centre(k,4))))
             CellDataArray(i)=1.0;
            end
        end
end

Cell_Fibre=reshape(CellDataArray,[Divx,Divy]);
Cell_Matrix=1.0-Cell_Fibre;

FFT_Cell_Fibre=fft2(Cell_Fibre);
Conjugate_FFT_Cell_Fibre=conj(FFT_Cell_Fibre);

FFT_Cell_Matrix=fft2(Cell_Matrix);
Conjugate_FFT_Cell_Matrix=conj(FFT_Cell_Matrix);


% S_fm
figure(2)
ISfm=FFT_Cell_Fibre*Conjugate_FFT_Cell_Matrix;
Sfm=real(ifft2(ISfm));
surf(Sfm);
legend('S_{fm}');

% S_mm
figure(3)
ISmm=FFT_Cell_Matrix*Conjugate_FFT_Cell_Matrix;
Smm=real(ifft2(ISmm));
surf(Smm);
legend('S_{mm}');

% S_mf
figure(4)
ISmf=FFT_Cell_Matrix*Conjugate_FFT_Cell_Fibre;
Smf=real(ifft2(ISmf));
surf(Smf);
legend('S_{mf}');

%S_ff
figure(5)
ISff=FFT_Cell_Fibre*Conjugate_FFT_Cell_Fibre;
Sff=real(ifft2(ISff));
surf(Sff);
legend('S_{ff}');


dat=fopen('CellIndexData.dat','wb');

for k=1:numel;
 fprintf(dat,'%4d %7f %7f  %4d\n',k, elem_centre(k,1:2), CellDataArray(k));
end

% %check for isotropic nature of curves(checking at all angles for a radius R)
% 
% Centre_x=ceil(nnx/2); % centre of x coordinate of domain
% Centre_y=ceil(nny/2); % centre of y coordinate of domain
% R=0.5;                % Radius of domain
% cnt=1;
% 
% for i=1:2*pi/100:2*pi
%     Rad(cnt)=
%     cnt=cnt+1;    
















