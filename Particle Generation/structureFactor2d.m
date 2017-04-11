function [S,qx,qy] = structureFactor2d(Lx,Ly,scatrpos)
% STRUCTUREFACTOR2D 
% http://en.wikipedia.org/wiki/Structure_factor
% The structure factor (written in Latex) is defined as
%  S(\vec{q})=\frac{1}{N} \left| \sum_{\ell}^N \exp 
%  \left( i \vec{q}\cdot \vec{R}_{\ell} \right)\right|^2
% 
% Example use with fully-occupied periodic array:
%     First specify the dimensions,
% Lx=100; Ly=Lx; 
%     then specify location of scatterers
% scatrpos=ones(Lx+1,Ly+1);
%     finally, pass these to this function 
% [S,qx,qy] = structureFactor2d(Lx,Ly,scatrpos);
%     which returns the structure factor
%     and assoicated momentum-space coordinates
% 
% note: loops are not vectorized for pedagogical simplicity

x=0;
S=zeros(size(scatrpos,1),size(scatrpos,2));
for n=-Lx/2:Lx/2
  x=x+1;
  y=0;
  for m=-Ly/2:Ly/2
    y=y+1;
    for ell=-Lx/2:Lx/2
      for jin=-Ly/2:Ly/2
        S(x,y)=exp(1i*2*pi* (n*(scatrpos(x,y)*ell)/Lx +...
                            m*(scatrpos(x,y)*jin  )/Ly)) + S(x,y);
      end
    end
    S(x,y)=(1/(Lx*Ly))*abs(S(x,y)).^2;
  end
end
qx(1:Lx+1)=2*pi*(-Lx/2:Lx/2)/Lx; qy(1:Ly+1)=2*pi*(-Ly/2:Ly/2)/Ly;
surf(qx/(2*pi),qy/(2*pi),S/(Lx*Ly)); shading flat;
xlabel('q_x/(2*\pi)'); ylabel('q_y/(2*\pi)'); zlabel('S(q)/(L_x*L_y)');

