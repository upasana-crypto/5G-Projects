function fname = fig2pdf(figN, path, name_pref)
figure(figN);
fig=gcf();
ca=gca();

if ~exist('path', 'var') || isempty(path)
    path='./';
end
if ~exist('name_pref', 'var')
    name_pref='';
end

n=1;
while ~ isprop(fig.Children(n), 'XLabel')
    n=n+1;
end
xlab = (fig.Children(n).XLabel.String);
ylab = (fig.Children(n).YLabel.String);
if isprop(fig.Children(n), 'ZLabel') && ~isempty(fig.Children(n).ZLabel.String)
    zlab = (fig.Children(n).ZLabel.String);
    fig.Name=[fig.Children(n).Title.String '_' zlab '_of_' ylab '_of_' xlab] ;
else
    fig.Name=[fig.Children(n).Title.String '_' ylab '_of_' xlab] ;
end

fig.Name=[name_pref fig.Name];
fig.Name=strrep(fig.Name,'.','_');
fig.Name=strrep(fig.Name,'#','');
fig.Name=strrep(fig.Name,' ','_');
fig.Name=strrep(fig.Name,'/',':');
fig.Name=strrep(fig.Name,'\','');
fig.Name=strrep(fig.Name,'{','(');
fig.Name=strrep(fig.Name,'}',')');
fig.Name=strrep(fig.Name,'|','][');

fig.PaperPosition=[0 0 16 9];
fig.PaperSize=[16 9];
a=findall(fig.Children, 'Type', 'axes');
for i=1:numel(a)
    axes(a(i)); ca=gca();

    pbaspect([16 9 9]);
    
    ca.Title.FontSize=30;
    ca.Title.FontWeight='bold';
    ca.XLabel.FontSize=20;
    ca.XLabel.FontWeight='bold';
    ca.YLabel.FontSize=20;
    ca.YLabel.FontWeight='bold';
    ca.ZLabel.FontSize=20;
    ca.ZLabel.FontWeight='bold';
    ca.XAxis.FontSize=30;
    ca.YAxis.FontSize=30;
    ca.ZAxis.FontSize=30;
    
    for indx = 1:numel(fig.Children)
        if isprop(fig.Children(indx), 'Location')
            fig.Children(indx).Location='northeastoutside'
            fig.Children(indx).FontSize=30;
        end
    end
    
    for i = 1:numel(ca.Children)
        if isprop(ca.Children(i), 'LineWidth')
            ca.Children(i).LineWidth = 2;
        end
        if isprop(ca.Children(i), 'MarkerSize')
            ca.Children(i).MarkerSize = 20;
        end
    end
    
    % path = 'Doc/figures/';
    % for i = 1:5
    %     if isfolder(path)
    %         break
    %     else
    %         path=['../' path];
    %     end
    % end
end
fname = [path get(fig,'Name') '.pdf'];
fig.WindowStyle='normal';
fig.Visible=false;
fig.Units='normalized';
fig.OuterPosition=[0 0 1 1];

saveas(fig,fname);
fig.Visible=true;
fig.WindowStyle='docked';
end