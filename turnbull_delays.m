%from Turnbull 1991 paper
function delays=turnbull_delays(Sound_Speed,n,pitch,alpha,phi,FD)

alpha=alpha*(3.14/180);
phi=phi*(3.14/180);

%auxiliary variables
u0=sin(alpha)*cos(phi);
v0=sin(alpha)*sin(phi);

%pitch of the full array in x direction (i) and y direction (j)

id=-((n-1)*pitch)/2:pitch:(n-1)*pitch/2;
jd=-((n-1)*pitch)/2:pitch:(n-1)*pitch/2;

%distance from center element to focal spot
R=FD/cos(alpha);

delays=zeros(n,n);

%time delays

for i=1:1:n
    
   for j=1:1:n
    
       delays(i,j)=R/Sound_Speed*(1-sqrt((u0-id(i)/R)^2+(v0-jd(j)/R)^2+cos(alpha)^2));
           
   end
   
   
end


end



