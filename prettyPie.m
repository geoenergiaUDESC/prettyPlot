function prettyPie(varargin)

% Set latex interpreter
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% Set default input parameters and parse
p=inputParser;
addParameter(p,'RLim',[-1.1 1.1]);
addParameter(p,'Title',strings(1));
addParameter(p,'PaperPoints',595);
addParameter(p,'PaperMarginPoints',90);
addParameter(p,'BoxMarginScale',0.1);
addParameter(p,'LineWidth',0.5);
addParameter(p,'FontSize',10);
addParameter(p,'AxLabelOffset',0.75);
parse(p,varargin{:});
RLim=p.Results.RLim;
TitleString=p.Results.Title;
PaperPoints=p.Results.PaperPoints;
PaperMarginPoints=p.Results.PaperMarginPoints;
BoxMarginScale=p.Results.BoxMarginScale;
LineWidth=p.Results.LineWidth;
FontSize=p.Results.FontSize;
AxLabelOffset=p.Results.AxLabelOffset;

% Set figure and axis dimensions
RMin=RLim(1);
RMax=RLim(2);
xfigwidth=PaperPoints-(2*PaperMarginPoints);
boxmarginwidth=BoxMarginScale*xfigwidth;
xaxiswidth=xfigwidth-(2*boxmarginwidth);
yaxiswidth=double(xaxiswidth);
yfigwidth=yaxiswidth+(2*boxmarginwidth);

% Set figure properties
close all;
fig=gcf;
axis off;
set(fig,'Units','points');
set(fig,'Color',[1 1 1]);
set(fig,'InnerPosition',[boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth]);
set(fig,'Position',[0 0 xfigwidth yfigwidth]);
set(fig,'Renderer','painter');

% Create axes
ax=gca;
hold on;
axis off;
ax.Units='points';
ax.PositionConstraint='innerposition';
ax.Box='off';
ax.BoxStyle='back';
ax.Color=[1 1 1];
ax.DataAspectRatio=[1 1 1];
ax.FontName='Times';
ax.FontSize=FontSize;
ax.FontUnits='points';
ax.GridColor=[0 0 0];
ax.LabelFontSizeMultiplier=1;
ax.LineWidth=LineWidth;
ax.MinorGridColor=[0 0 0];
ax.Position=[boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth];
ax.TickLabelInterpreter='latex';
ax.View=[0 90];

% Create title
ax.Title.Units='points';
ax.Title.Color=[0 0 0];
ax.Title.FontName='Times';
ax.Title.FontSize=FontSize;
ax.Title.FontUnits='points';
ax.Title.HorizontalAlignment='center';
ax.Title.Interpreter='latex';
ax.Title.LineWidth=LineWidth;
ax.Title.Position=[xaxiswidth/2 yaxiswidth+(0.5*boxmarginwidth) 0];
ax.Title.String=TitleString;
ax.Title.VerticalAlignment='middle';
ax.Title.Visible='on';
ax.TitleFontSizeMultiplier=1;

% Create x axis
ax.XAxis.Color=[0 0 0];
ax.XAxis.FontName='Times';
ax.XAxis.FontSize=FontSize;
ax.XAxis.HandleVisibility='off';
ax.XAxis.Label.Color=[0 0 0];
ax.XAxis.Label.FontName='Times';
ax.XAxis.Label.FontSize=FontSize;
ax.XAxis.Label.FontUnits='points';
ax.XAxis.Label.HandleVisibility='off';
ax.XAxis.Label.HorizontalAlignment='center';
ax.XAxis.Label.Interpreter='latex';
ax.XAxis.Label.LineWidth=LineWidth;
ax.XAxis.Label.Units='points';
ax.XAxis.Label.Position=[xaxiswidth/2 -boxmarginwidth*AxLabelOffset 0];
ax.XAxis.Label.String=[];
ax.XAxis.Label.VerticalAlignment='middle';
ax.XAxis.Label.Visible='off';
ax.XAxis.Limits=[double(RMin) double(RMax)];
ax.XAxis.LineWidth=LineWidth;
ax.XAxis.TickLabelInterpreter='latex';
ax.XAxis.TickLabels=[];
ax.XAxis.TickValues=[double(RMin) double(RMax)];
ax.XAxis.Visible='off';
ax.XColor=[0 0 0];
ax.XGrid='off';
ax.XLabel.BackgroundColor=[1 1 1];
ax.XLabel.Color=[0 0 0];
ax.XLabel.FontName='Times';
ax.XLabel.FontSize=FontSize;
ax.XLabel.FontUnits='points';
ax.XLabel.HandleVisibility='off';
ax.XLabel.HorizontalAlignment='center';
ax.XLabel.Interpreter='latex';
ax.XLabel.LineWidth=LineWidth;
ax.XLabel.Units='points';
ax.XLabel.Position=[xaxiswidth/2 -boxmarginwidth*AxLabelOffset 0];
ax.XLabel.String=[];
ax.XLabel.VerticalAlignment='middle';
ax.XLabel.Visible='off';
ax.XLim=[double(RMin) double(RMax)];
ax.XTick=[double(RMin) double(RMax)];
ax.XTickLabel=[];

% Create y axis
ax.YAxis.Color=[0 0 0];
ax.YAxis.FontName='Times';
ax.YAxis.FontSize=FontSize;
ax.YAxis.HandleVisibility='off';
ax.YAxis.Label.Color=[0 0 0];
ax.YAxis.Label.FontName='Times';
ax.YAxis.Label.FontSize=FontSize;
ax.YAxis.Label.FontUnits='points';
ax.YAxis.Label.HandleVisibility='off';
ax.YAxis.Label.HorizontalAlignment='center';
ax.YAxis.Label.Interpreter='latex';
ax.YAxis.Label.LineWidth=LineWidth;
ax.YAxis.Label.Units='points';
ax.YAxis.Label.Position=[-boxmarginwidth*AxLabelOffset yaxiswidth/2 0];
ax.YAxis.Label.String=[];
ax.YAxis.Label.VerticalAlignment='middle';
ax.YAxis.Label.Visible='off';
ax.YAxis.Limits=[double(RMin) double(RMax)];
ax.YAxis.LineWidth=LineWidth;
ax.YAxis.TickLabelInterpreter='latex';
ax.YAxis.TickLabels=[];
ax.YAxis.TickValues=[double(RMin) double(RMax)];
ax.YAxis.Visible='off';
ax.YColor=[0 0 0];
ax.YGrid='off';
ax.YLabel.BackgroundColor=[1 1 1];
ax.YLabel.Color=[0 0 0];
ax.YLabel.FontName='Times';
ax.YLabel.FontSize=FontSize;
ax.YLabel.FontUnits='points';
ax.YLabel.HandleVisibility='off';
ax.YLabel.HorizontalAlignment='center';
ax.YLabel.Interpreter='latex';
ax.YLabel.LineWidth=LineWidth;
ax.YLabel.Units='points';
ax.YLabel.Position=[-boxmarginwidth*AxLabelOffset yaxiswidth/2 0];
ax.YLabel.String=[];
ax.YLabel.VerticalAlignment='middle';
ax.YLabel.Visible='off';
ax.YLim=[double(RMin) double(RMax)];
ax.YTick=[double(RMin) double(RMax)];
ax.YTickLabel=[];

% Create z axis
ax.ZAxis.Color=[0 0 0];
ax.ZAxis.FontName='Times';
ax.ZAxis.FontSize=FontSize;
ax.ZAxis.HandleVisibility='off';
ax.ZAxis.Label=[];
ax.ZAxis.Limits=[double(RMin) double(RMax)];
ax.ZAxis.LineWidth=LineWidth;
ax.ZAxis.TickLabelInterpreter='latex';
ax.ZAxis.TickLabels=[];
ax.ZAxis.TickValues=[double(RMin) double(RMax)];
ax.ZAxis.Visible='off';
ax.ZColor=[0 0 0];
ax.ZGrid='off';
ax.ZLabel.BackgroundColor=[1 1 1];
ax.ZLabel.Color=[0 0 0];
ax.ZLabel.FontName='Times';
ax.ZLabel.FontSize=FontSize;
ax.ZLabel.FontUnits='points';
ax.ZLabel.HandleVisibility='off';
ax.ZLabel.HorizontalAlignment='center';
ax.ZLabel.Interpreter='latex';
ax.ZLabel.LineWidth=LineWidth;
ax.ZLabel.Position=[0.5 -0.1 0];
ax.ZLabel.String=[];
ax.ZLabel.Units='points';
ax.ZLabel.VerticalAlignment='middle';
ax.ZLabel.Visible='off';
ax.ZLim=[double(RMin) double(RMax)];
ax.ZTick=[double(RMin) double(RMax)];
ax.ZTickLabel=[];

end