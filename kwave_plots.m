function kwave_plots(data,dim1,dim2,grid,anim,surfopt,iteration)

max_pressure=0;
aux_max=0;
time_idx_max=0;

%anim=0
%surfopt=0

Z=zeros(length(grid.t_array),dim1,dim2);

for i=1:length(grid.t_array)
   
Z(i,:,:)=double(reshape(data.p(:,i),dim1,dim2));
    aux_max=max(max(Z(i,:,:)));
    if(aux_max>max_pressure)
       max_pressure=aux_max;
       time_idx_max=i;
    end
end
%% 

cmap1=jet;
cmap2=flip(jet);
cmap=cat(1,cmap2,cmap1);
% 
if(anim==1)

    figure
    set(gcf, 'Position', get(0,'Screensize'));
    for i=1:length(grid.t_array)
        
        surf(grid.y_vec*1e6,grid.x_vec*1e6,squeeze(Z(i,:,:)),'EdgeColor','none','LineStyle','none','FaceLighting','phong');
        zlim([-1.5*max_pressure 1.5*max_pressure]);
        caxis([-max_pressure max_pressure])
        colormap(cmap)
        colorbar
        set(gca,'FontSize',20);
        xlabel('Z [\mum]')
        ylabel('X [\mum]')
        zlabel('Normalized pressure')
        pause(0.001);
        drawnow
    end
end

if(surfopt==1)

    figure(2)
    surf(grid.y_vec*1e6,grid.x_vec*1e6,squeeze(Z(time_idx_max,:,:)),'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    zlim([-1.5*max_pressure 1.5*max_pressure]);
    caxis([-max_pressure max_pressure])
    colormap(cmap)
    colorbar
    set(gca,'FontSize',20);
    xlabel('Z [\mum]')
    ylabel('X [\mum]')
    zlabel('Normalized pressure')
    pause(0.001);
    drawnow
end

%%
Zrms(:,:)=double(reshape(data.p_rms(:),dim1,dim2));
h=figure(2+iteration)
hold on
imagesc(grid.y_vec*1e3,grid.x_vec*1e3,Zrms)
colormap(jet)
colorbar
set(gca,'FontSize',20);
xlabel('z axis [mm]')
ylabel('x axis [mm]')
hold off


end