function prettyPolar(varargin)

% Set latex interpreter
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% Check if symbolic toolbox is installed
symtoggle=license('test', 'symbolic_toolbox');

% Set default input parameters and parse
p=inputParser;
addParameter(p,'BoxMarginScale',0.1);
addParameter(p,'FontSize',10);
addParameter(p,'CAxis',[-5 5]);
addParameter(p,'CBarTickFormat',3);
addParameter(p,'LineWidth',0.5);
addParameter(p,'TickNumberFormat','Decimal');
addParameter(p,'NCBarTicks',11);
addParameter(p,'NRTicks',6);
addParameter(p,'NThetaTicks',13);
addParameter(p,'PaperMarginPoints',90);
addParameter(p,'PaperPoints',595);
addParameter(p,'RLabelAngle',pi/4);
addParameter(p,'RLabel',strings(1));
addParameter(p,'RLim',[0 1]);
addParameter(p,'RTickFormat',3);
addParameter(p,'ThetaDir','clockwise');
addParameter(p,'ThetaLabel',strings(1));
addParameter(p,'ThetaTickFormat',3);
addParameter(p,'ThetaZeroLocation','top');
addParameter(p,'Title',strings(1));
addParameter(p,'UseAxisDiagram',false);
addParameter(p,'UseBorder',false);
addParameter(p,'UseColorBar',false);
addParameter(p,'UseCBarTickFractions',false);
addParameter(p,'UseCBarScientificNotation',false);
addParameter(p,'UsePolarAxisType',true);
addParameter(p,'UseRTickLabels',true);
addParameter(p,'UseRTickFractions',false);
addParameter(p,'UseRScientificNotation',false);
addParameter(p,'UseThetaTickFractions',false);
addParameter(p,'UseThetaTickLabels',true);
addParameter(p,'UseThetaScientificNotation',false);
parse(p,varargin{:});
BoxMarginScale=p.Results.BoxMarginScale;
CBarMax=p.Results.CAxis(2);
CBarMin=p.Results.CAxis(1);
CBarTickFormat=p.Results.CBarTickFormat;
FontSize=p.Results.FontSize;
LineWidth=p.Results.LineWidth;
NCBarTicks=p.Results.NCBarTicks;
NRTicks=p.Results.NRTicks;
NThetaTicks=p.Results.NThetaTicks;
PaperMarginPoints=p.Results.PaperMarginPoints;
PaperPoints=p.Results.PaperPoints;
RLabelAngle=p.Results.RLabelAngle;
RLabelString=p.Results.RLabel;
RMax=p.Results.RLim(2);
RMin=p.Results.RLim(1);
RTickFormat=p.Results.RTickFormat;
ThetaDir=p.Results.ThetaDir;
ThetaLabelString=p.Results.ThetaLabel;
ThetaMax=360;
ThetaMin=0;
ThetaTickFormat=p.Results.ThetaTickFormat;
ThetaZeroLocation=p.Results.ThetaZeroLocation;
TitleString=p.Results.Title;
UseAxisDiagram=p.Results.UseAxisDiagram;
UseBorder=p.Results.UseBorder;
UseColorBar=p.Results.UseColorBar;
UseCBarTickFractions=p.Results.UseCBarTickFractions;
UseCBarScientificNotation=p.Results.UseCBarScientificNotation;
UsePolarAxisType=p.Results.UsePolarAxisType;
UseRTickFractions=p.Results.UseRTickFractions;
UseRTickLabels=p.Results.UseRTickLabels;
UseRScientificNotation=p.Results.UseRScientificNotation;
UseThetaTickFractions=p.Results.UseThetaTickFractions;
UseThetaTickLabels=p.Results.UseThetaTickLabels;
UseThetaScientificNotation=p.Results.UseThetaScientificNotation;

% Set figure and axis dimensions
xfigwidth=PaperPoints-(2*PaperMarginPoints);
boxmarginwidth=BoxMarginScale*xfigwidth;
xaxiswidth=xfigwidth-(2*boxmarginwidth);
yaxiswidth=xaxiswidth;
yfigwidth=yaxiswidth+(2*boxmarginwidth);

% Create r ticks and labels
if symtoggle==1
    RTicks=simplify(linspace(sym(RMin),sym(RMax),NRTicks),'Steps',100);
    RTickLabels=strings(1,NRTicks);
    if UseRTickFractions==false
        if UseRScientificNotation==false
            for a=1:NRTicks
                RTickLabels(a)=strcat('$',num2str(double(simplify(RTicks(a),'Steps',100)),RTickFormat),'$');
            end
        else
        end
        if UseRScientificNotation==true
            RExponent=double(floor(log10(RTicks(end))));
            RExponentLabel=strcat('$\times 10^{',num2str(RExponent,'%0.0f'),'}$');
            for a=1:NRTicks
                RTickLabels(a)=strcat('$',num2str(double(simplify(RTicks(a)/(sym(10)^RExponent),'Steps',100)),RTickFormat),'$');
            end
        else
        end
    else
    end
    if UseRTickFractions==true
        for a=1:NRTicks
            RTickLabels(a)=strcat('$',latex(simplify(RTicks(a),'Steps',100)),'$');
        end
    else
    end
else
    RTicks=simplify(linspace(RMin,RMax,NRTicks),'Steps',100);
    RTickLabels=strings(1,NRTicks);
    if UseRScientificNotation==false
        for a=1:NRTicks
            RTickLabels(a)=strcat('$',num2str(double(RTicks(a)),RTickFormat),'$');
        end
    else
    end
    if UseRScientificNotation==true
        RExponent=double(floor(log10(RTicks(end))));
        RExponentLabel=strcat('$\times 10^{',num2str(RExponent,'%0.0f'),'}$');
        for a=1:NRTicks
            RTickLabels(a)=strcat('$',num2str(double(RTicks(a)/(sym(10)^RExponent)),RTickFormat),'$');
        end
    else
    end
end

% Create theta ticks and labels
if symtoggle==1
    ThetaTicks=simplify(linspace(sym(ThetaMin),sym(ThetaMax),NThetaTicks),'Steps',100);
    ThetaTickLabels=strings(1,NThetaTicks);
    if UseThetaTickFractions==false
        if UseThetaScientificNotation==false
            for a=1:NThetaTicks
                ThetaTickLabels(a)=strcat('$',num2str(double(simplify(ThetaTicks(a),'Steps',100)),ThetaTickFormat),'$');
            end
        else
        end
        if UseThetaScientificNotation==true
            ThetaExponent=double(floor(log10(ThetaTicks(end))));
            for a=1:NThetaTicks
                ThetaTickLabels(a)=strcat('$',num2str(double(simplify(ThetaTicks(a)/(sym(10)^ThetaExponent),'Steps',100)),ThetaTickFormat),'$');
            end
        else
        end
    else
    end
    if UseThetaTickFractions==true
        for a=1:NThetaTicks
            ThetaTickLabels(a)=strcat('$',latex(simplify(ThetaTicks(a),'Steps',100)),'$');
        end
    else
    end
else
    ThetaTicks=simplify(linspace(ThetaMin,ThetaMax,NThetaTicks),'Steps',100);
    ThetaTickLabels=strings(1,NThetaTicks);
    if UseThetaScientificNotation==false
        for a=1:NThetaTicks
            ThetaTickLabels(a)=strcat('$',num2str(double(ThetaTicks(a)),ThetaTickFormat),'$');
        end
    else
    end
    if UseThetaScientificNotation==true
        ThetaExponent=double(floor(log10(ThetaTicks(end))));
        for a=1:NThetaTicks
            ThetaTickLabels(a)=strcat('$',num2str(double(ThetaTicks(a)/(sym(10)^ThetaExponent)),ThetaTickFormat),'$');
        end
    else
    end
end

% Create colorbar ticks and labels
if symtoggle==1
    CBarTicks=simplify(linspace(sym(CBarMin),sym(CBarMax),NCBarTicks),'Steps',100);
    CBarTickLabels=strings(1,NCBarTicks);
    if UseCBarTickFractions==false
        if UseCBarScientificNotation==false
            for a=1:NCBarTicks
                CBarTickLabels(a)=strcat('$',num2str(double(simplify(CBarTicks(a),'Steps',100)),CBarTickFormat),'$');
            end
        else
        end
        if UseCBarScientificNotation==true
            CBarExponent=double(floor(log10(CBarTicks(end))));
            CBarExponentLabel=strcat('$\times 10^{',num2str(CBarExponent,'%0.0f'),'}$');
            for a=1:NCBarTicks
                CBarTickLabels(a)=strcat('$',num2str(double(simplify(CBarTicks(a)/(sym(10)^CBarExponent),'Steps',100)),CBarTickFormat),'$');
            end
        else
        end
    else
    end
    if UseCBarTickFractions==true
        for a=1:NCBarTicks
            CBarTickLabels(a)=strcat('$',latex(simplify(CBarTicks(a),'Steps',100)),'$');
        end
    else
    end
else
    CBarTicks=simplify(linspace(CBarMin,CBarMax,NCBarTicks),'Steps',100);
    CBarTickLabels=strings(1,NCBarTicks);
    if UseCBarScientificNotation==false
        for a=1:NCBarTicks
            CBarTickLabels(a)=strcat('$',num2str(double(CBarTicks(a)),CBarTickFormat),'$');
        end
    else
    end
    if UseCBarScientificNotation==true
        CBarExponent=double(floor(log10(CBarTicks(end))));
        CBarExponentLabel=strcat('$\times 10^{',num2str(CBarExponent,'%0.0f'),'}$');
        for a=1:NCBarTicks
            CBarTickLabels(a)=strcat('$',num2str(double(CBarTicks(a)/(sym(10)^CBarExponent)),CBarTickFormat),'$');
        end
    else
    end
end

% Set figure properties
fig=figure;
axis off;
set(fig,'Units','points');
set(fig,'Color',[1 1 1]);
set(fig,'InnerPosition',double([boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth]));
set(fig,'Position',double([0 0 xfigwidth yfigwidth]));
set(fig,'Renderer','painter');

% Create blank axis for polar axis diagram
ta=gca;
hold on;
axis on;
ta.Units='points';
ta.PositionConstraint='innerposition';
ta.Box='off';
ta.BoxStyle='back';
ta.CLim=[double(CBarMin) double(CBarMax)];
ta.Color=[1 1 1];
ta.DataAspectRatio=[1 1 1];
ta.FontName='Times';
ta.FontSize=FontSize;
ta.FontUnits='points';
ta.GridColor=[0 0 0];
ta.LabelFontSizeMultiplier=1;
ta.LineWidth=LineWidth;
ta.MinorGridColor=[0 0 0];
ta.PlotBoxAspectRatio=[1 1 1];
ta.Position=double([0 0 xfigwidth yfigwidth]);
ta.TickLabelInterpreter='latex';
ta.View=[0 90];

% Create colorbar
if UseColorBar==true
    C=colorbar;
    C.Units='points';
    C.Color=[0 0 0];
    C.FontName='Times';
    C.FontSize=FontSize;
    C.Label.Units='points';
    C.Label.Color=[0 0 0];
    C.Label.FontName='Times';
    C.Label.FontSize=FontSize;
    C.Label.FontUnits='points';
    C.Label.HorizontalAlignment='center';
    C.Label.Interpreter='latex';
    C.Label.Position=double(CBarLabelXYZ);
    C.Label.LineWidth=LineWidth;
    C.Label.VerticalAlignment='middle';
    C.Limits=[double(CBarMin) double(CBarMax)];
    C.LineWidth=LineWidth;
    C.Position=double(CBarXYZ);
    C.TickLabelInterpreter='latex';
    C.TickLabels=CBarTickLabels;
    C.Ticks=double(CBarTicks);
    C.Visible='on';
else
end

% Create blank title
ta.Title.BackgroundColor='none';
ta.Title.Color=[0 0 0];
ta.Title.FontName='Times';
ta.Title.FontSize=FontSize;
ta.Title.FontUnits='points';
ta.Title.HorizontalAlignment='center';
ta.Title.Interpreter='latex';
ta.Title.LineWidth=LineWidth;
ta.Title.Units='points';
ta.Title.Position=double([xaxiswidth/2 yaxiswidth+(boxmarginwidth*0.5) 0]);
ta.Title.String='';
ta.Title.VerticalAlignment='middle';

% Create blank x axis
ta.XAxis.Color=[0 0 0];
ta.XAxis.FontName='Times';
ta.XAxis.FontSize=FontSize;
ta.XAxis.HandleVisibility='off';
ta.XAxis.Label=[];
ta.XAxis.Limits=[0 1];
ta.XAxis.LineWidth=LineWidth;
ta.XAxis.TickLabelInterpreter='latex';
ta.XAxis.TickLabels='';
ta.XAxis.TickValues=[];
ta.XAxis.Visible='off';
ta.XColor=[0 0 0];
ta.XGrid='off';
ta.XLabel.BackgroundColor='none';
ta.XLabel.Color=[0 0 0];
ta.XLabel.FontName='Times';
ta.XLabel.FontSize=FontSize;
ta.XLabel.FontUnits='points';
ta.XLabel.HandleVisibility='off';
ta.XLabel.HorizontalAlignment='center';
ta.XLabel.Interpreter='latex';
ta.XLabel.LineWidth=LineWidth;
ta.XLabel.Position=[0.5 -0.1 0];
ta.XLabel.String='';
ta.XLabel.Units='data';
ta.XLabel.VerticalAlignment='middle';
ta.XLabel.Visible='off';
ta.XLim=[0 1];
ta.XTick=[];
ta.XTickLabel='';

% Create blank y axis
ta.YAxis.Color=[0 0 0];
ta.YAxis.FontName='Times';
ta.YAxis.FontSize=FontSize;
ta.YAxis.HandleVisibility='off';
ta.YAxis.Label=[];
ta.YAxis.Limits=[0 1];
ta.YAxis.LineWidth=LineWidth;
ta.YAxis.TickLabelInterpreter='latex';
ta.YAxis.TickLabels='';
ta.YAxis.TickValues=[];
ta.YAxis.Visible='off';
ta.YColor=[0 0 0];
ta.YGrid='off';
ta.YLabel.BackgroundColor='none';
ta.YLabel.Color=[0 0 0];
ta.YLabel.FontName='Times';
ta.YLabel.FontSize=FontSize;
ta.YLabel.FontUnits='points';
ta.YLabel.HandleVisibility='off';
ta.YLabel.HorizontalAlignment='center';
ta.YLabel.Interpreter='latex';
ta.YLabel.LineWidth=LineWidth;
ta.YLabel.Position=[0.5 -0.1 0];
ta.YLabel.String='';
ta.YLabel.Units='data';
ta.YLabel.VerticalAlignment='middle';
ta.YLabel.Visible='off';
ta.YLim=[0 1];
ta.YTick=[];
ta.YTickLabel='';

% Create blank z axis
ta.ZAxis.Color=[0 0 0];
ta.ZAxis.FontName='Times';
ta.ZAxis.FontSize=FontSize;
ta.ZAxis.HandleVisibility='off';
ta.ZAxis.Label=[];
ta.ZAxis.Limits=[0 1];
ta.ZAxis.LineWidth=LineWidth;
ta.ZAxis.TickLabelInterpreter='latex';
ta.ZAxis.TickLabels='';
ta.ZAxis.TickValues=[];
ta.ZAxis.Visible='off';
ta.ZColor=[0 0 0];
ta.ZGrid='off';
ta.ZLabel.BackgroundColor='none';
ta.ZLabel.Color=[0 0 0];
ta.ZLabel.FontName='Times';
ta.ZLabel.FontSize=FontSize;
ta.ZLabel.FontUnits='points';
ta.ZLabel.HandleVisibility='off';
ta.ZLabel.HorizontalAlignment='center';
ta.ZLabel.Interpreter='latex';
ta.ZLabel.LineWidth=LineWidth;
ta.ZLabel.Position=[0.5 -0.1 0];
ta.ZLabel.String='';
ta.ZLabel.Units='data';
ta.ZLabel.VerticalAlignment='middle';
ta.ZLabel.Visible='off';
ta.ZLim=[0 1];
ta.ZTick=[];
ta.ZTickLabel='';

% Create polar axis diagram
CWToggle=strcmpi(ThetaDir,'clockwise');
CCWToggle=strcmpi(ThetaDir,'counterclockwise');
if UseAxisDiagram==true
    AxLength=0.08;
    RLineLength=AxLength*0.75;
    ArrowHeadSize=0.01;
    line([0.1 0.1+RLineLength],[0.1 0.1],[1 1],...
        'Color',[0 0 0],...
        'HandleVisibility','off',...
        'LineStyle','-',...
        'LineWidth',LineWidth);
    fill3([0.1+RLineLength 0.1+RLineLength-ArrowHeadSize 0.1+RLineLength-ArrowHeadSize],[0.1 0.1-(ArrowHeadSize/2) 0.1+(ArrowHeadSize/2)],[1 1 1],[0 0 0],...
        'FaceColor',[0 0 0],...
        'EdgeColor',[0 0 0],...
        'FaceAlpha',1,...
        'EdgeAlpha',1);
    line(0.1+(AxLength*cos(linspace(0,pi/2,2501))),0.1+(AxLength*sin(linspace(0,pi/2,2501))),ones(1,2501),...
        'Color',[0 0 0],...
        'HandleVisibility','off',...
        'LineStyle','-',...
        'LineWidth',LineWidth);
    if CWToggle==1
        fill3([0.1+AxLength 0.1+AxLength-(ArrowHeadSize/2) 0.1+AxLength+(ArrowHeadSize/2)],[0.1 0.1+ArrowHeadSize 0.1+ArrowHeadSize],[1 1 1],[0 0 0],...
            'FaceColor',[0 0 0],...
            'EdgeColor',[0 0 0],...
            'FaceAlpha',1,...
            'EdgeAlpha',1);
    else
    end
    if CCWToggle==1
        fill3([0.1 0.1+ArrowHeadSize 0.1+ArrowHeadSize],[0.1+AxLength 0.1+AxLength-(ArrowHeadSize/2) 0.1+AxLength+(ArrowHeadSize/2)],[1 1 1],[0 0 0],...
            'FaceColor',[0 0 0],...
            'EdgeColor',[0 0 0],...
            'FaceAlpha',1,...
            'EdgeAlpha',1);
    else
    end
    RL=text;
    RL.Color=[0 0 0];
    RL.EdgeColor=[1 1 1];
    RL.FontName='Times';
    RL.FontSize=FontSize;
    RL.FontUnits='points';
    RL.HandleVisibility='off';
    RL.HorizontalAlignment='center';
    RL.Interpreter='latex';
    RL.Position=[0.1+(RLineLength/2) 0.09 1];
    RL.String=RLabelString;
    RL.VerticalAlignment='top';
    ThetaL=text;
    ThetaL.Color=[0 0 0];
    ThetaL.EdgeColor=[1 1 1];
    ThetaL.FontName='Times';
    ThetaL.FontSize=FontSize;
    ThetaL.FontUnits='points';
    ThetaL.HandleVisibility='off';
    ThetaL.HorizontalAlignment='center';
    ThetaL.Interpreter='latex';
    ThetaL.Position=[0.1 0.1+AxLength 1];
    ThetaL.String=ThetaLabelString;
    ThetaL.VerticalAlignment='bottom';
else
end

% Write colorbar exponent label
if exist('CBarExponentLabel','var')
    CBarExponentText=text(0,0,CBarExponentLabel);
    CBarExponentText.Units='Points';
    CBarExponentText.BackgroundColor=[1 1 1];
    CBarExponentText.Color=[0 0 0];
    CBarExponentText.FontName='Times';
    CBarExponentText.FontSize=FontSize;
    CBarExponentText.FontUnits='Points';
    CBarExponentText.HandleVisibility='Off';
    CBarExponentText.HorizontalAlignment='Left';
    CBarExponentText.Interpreter='Latex';
    CBarExponentText.LineStyle='-';
    CBarExponentText.LineWidth=LineWidth;
    CBarExponentText.Position=CBarExponentXYZ;
    CBarExponentText.String=CBarExponentLabel;
    CBarExponentText.VerticalAlignment='Bottom';
else
end

% Create axes
ax=polaraxes;
axis on;
hold on;
ax.Units='points';
ax.PositionConstraint='innerposition';
ax.Box='off';
ax.CLim=[0 1];
ax.Color=[1 1 1];
ax.FontName='Times';
ax.FontSize=FontSize;
ax.FontUnits='points';
ax.GridColor=[0 0 0];
ax.LineWidth=LineWidth;
ax.MinorGridColor=[0 0 0];
ax.Position=double([boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth]);
ax.ThetaDir=ThetaDir;
ax.ThetaZeroLocation=ThetaZeroLocation;
ax.TickLabelInterpreter='latex';
ax.TickLength=[0 0];
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
ax.Title.Position=double([xaxiswidth/2 yaxiswidth+(0.5*boxmarginwidth) 0]);
ax.Title.String=TitleString;
ax.Title.VerticalAlignment='middle';
ax.Title.Visible='on';
ax.TitleFontSizeMultiplier=1;

% Create r axis
ax.RAxis.Color=[0 0 0];
ax.RAxis.FontName='Times';
ax.RAxis.FontSize=FontSize;
ax.RAxis.Label.Units='points';
ax.RAxis.Label.Color=[0 0 0];
ax.RAxis.Label.FontName='Times';
ax.RAxis.Label.FontSize=FontSize;
ax.RAxis.Label.FontUnits='points';
ax.RAxis.Label.HorizontalAlignment='center';
ax.RAxis.Label.Interpreter='latex';
ax.RAxis.Label.LineWidth=0.5;
ax.RAxis.Label.Position=[0 0 0];
if UseAxisDiagram==true
    ax.RAxis.Label.String='';
else
    ax.RAxis.Label.String=RLabelString;
end
ax.RAxis.Label.VerticalAlignment='middle';
ax.RAxis.Limits=[double(RMin) double(RMax)];
ax.RAxis.LineWidth=LineWidth;
ax.RAxis.TickLabelInterpreter='latex';
ax.RAxis.TickLabels='';
ax.RAxis.TickValues=double(RTicks);

% Create r axis labels
if UseRTickLabels==true
    for a=1:NRTicks
        text(double(RLabelAngle),double(RTicks(a)),RTickLabels(a),...
            'Color',[0 0 0],...
            'FontName','Times',...
            'FontSize',FontSize,...
            'FontUnits','points',...
            'HorizontalAlignment','center',...
            'Interpreter','latex',...
            'VerticalAlignment','middle');
    end
else
end

% Create theta axis labels
for a=1:NThetaTicks-1
    text(double(ThetaTicks(a))*pi/180,double((RMax-RMin)*1.05),ThetaTickLabels(a),...
        'Color',[0 0 0],...
        'FontName','Times',...
        'FontSize',FontSize,...
        'FontUnits','points',...
        'HorizontalAlignment','center',...
        'Interpreter','latex',...
        'VerticalAlignment','middle');
end

% Create theta axis
ax.ThetaAxis.Color=[0 0 0];
ax.ThetaAxis.FontName='Times';
ax.ThetaAxis.FontSize=FontSize;
ax.ThetaAxis.Label.Units='points';
ax.ThetaAxis.Label.Color=[0 0 0];
ax.ThetaAxis.Label.FontName='Times';
ax.ThetaAxis.Label.FontSize=FontSize;
ax.ThetaAxis.Label.FontUnits='points';
ax.ThetaAxis.Label.HorizontalAlignment='center';
ax.ThetaAxis.Label.Interpreter='latex';
ax.ThetaAxis.Label.LineWidth=0.5;
if UseAxisDiagram==true
    ax.ThetaAxis.Label.String='';
else
    ax.ThetaAxis.Label.String=ThetaLabelString;
end
ax.ThetaAxis.Label.VerticalAlignment='middle';
ax.ThetaAxis.Limits=[0 360];
ax.ThetaAxis.LineWidth=LineWidth;
ax.ThetaAxis.TickLabelInterpreter='latex';
ax.ThetaAxis.TickLabels='';
ax.ThetaAxis.TickValues=linspace(0,360,NThetaTicks);

% Use standard axis for non-polar data
if UsePolarAxisType==false
    % Create blank axis for polar axis diagram
    tb=axes;
    hold on;
    axis on;
    tb.Units='points';
    tb.PositionConstraint='innerposition';
    tb.Box='off';
    tb.BoxStyle='back';
    tb.CLim=[double(CBarMin) double(CBarMax)];
    tb.Color='none';
    tb.DataAspectRatio=[1 1 1];
    tb.FontName='Times';
    tb.FontSize=FontSize;
    tb.FontUnits='points';
    tb.GridColor='none';
    tb.LabelFontSizeMultiplier=1;
    tb.LineWidth=LineWidth;
    tb.MinorGridColor='none';
    tb.PlotBoxAspectRatio=[1 1 1];
    tb.Position=[boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth];
    tb.TickLabelInterpreter='latex';
    tb.View=[0 90];

    % Create blank title
    tb.Title.BackgroundColor='none';
    tb.Title.Color='none';
    tb.Title.FontName='Times';
    tb.Title.FontSize=FontSize;
    tb.Title.FontUnits='points';
    tb.Title.HorizontalAlignment='center';
    tb.Title.Interpreter='latex';
    tb.Title.LineWidth=LineWidth;
    tb.Title.Units='points';
    tb.Title.Position=[xaxiswidth/2 yaxiswidth+(boxmarginwidth*0.5) 0];
    tb.Title.String='';
    tb.Title.VerticalAlignment='middle';

    % Create x axis
    tb.XAxis.Color='none';
    tb.XAxis.FontName='Times';
    tb.XAxis.FontSize=FontSize;
    tb.XAxis.HandleVisibility='off';
    tb.XAxis.Label=[];
    tb.XAxis.Limits=[0 1];
    tb.XAxis.LineWidth=LineWidth;
    tb.XAxis.TickLabelInterpreter='latex';
    tb.XAxis.TickLabels='';
    tb.XAxis.TickValues=[];
    tb.XAxis.Visible='off';
    tb.XColor='none';
    tb.XGrid='off';
    tb.XLabel.BackgroundColor='none';
    tb.XLabel.Color='none';
    tb.XLabel.FontName='Times';
    tb.XLabel.FontSize=FontSize;
    tb.XLabel.FontUnits='points';
    tb.XLabel.HandleVisibility='off';
    tb.XLabel.HorizontalAlignment='center';
    tb.XLabel.Interpreter='latex';
    tb.XLabel.LineWidth=LineWidth;
    tb.XLabel.Position=[0.5 -0.1 0];
    tb.XLabel.String='';
    tb.XLabel.Units='data';
    tb.XLabel.VerticalAlignment='middle';
    tb.XLabel.Visible='off';
    tb.XLim=[-double(RMax) double(RMax)];
    tb.XTick=[];
    tb.XTickLabel='';

    % Create y axis
    tb.YAxis.Color='none';
    tb.YAxis.FontName='Times';
    tb.YAxis.FontSize=FontSize;
    tb.YAxis.HandleVisibility='off';
    tb.YAxis.Label=[];
    tb.YAxis.Limits=[0 1];
    tb.YAxis.LineWidth=LineWidth;
    tb.YAxis.TickLabelInterpreter='latex';
    tb.YAxis.TickLabels='';
    tb.YAxis.TickValues=[];
    tb.YAxis.Visible='off';
    tb.YColor='none';
    tb.YGrid='off';
    tb.YLabel.BackgroundColor='none';
    tb.YLabel.Color='none';
    tb.YLabel.FontName='Times';
    tb.YLabel.FontSize=FontSize;
    tb.YLabel.FontUnits='points';
    tb.YLabel.HandleVisibility='off';
    tb.YLabel.HorizontalAlignment='center';
    tb.YLabel.Interpreter='latex';
    tb.YLabel.LineWidth=LineWidth;
    tb.YLabel.Position=[0.5 -0.1 0];
    tb.YLabel.String='';
    tb.YLabel.Units='data';
    tb.YLabel.VerticalAlignment='middle';
    tb.YLabel.Visible='off';
    tb.YLim=[-double(RMax) double(RMax)];
    tb.YTick=[];
    tb.YTickLabel='';

    % Create blank z axis
    tb.ZAxis.Color='none';
    tb.ZAxis.FontName='Times';
    tb.ZAxis.FontSize=FontSize;
    tb.ZAxis.HandleVisibility='off';
    tb.ZAxis.Label=[];
    tb.ZAxis.Limits=[0 1];
    tb.ZAxis.LineWidth=LineWidth;
    tb.ZAxis.TickLabelInterpreter='latex';
    tb.ZAxis.TickLabels='';
    tb.ZAxis.TickValues=[];
    tb.ZAxis.Visible='off';
    tb.ZColor='none';
    tb.ZGrid='off';
    tb.ZLabel.BackgroundColor='none';
    tb.ZLabel.Color='none';
    tb.ZLabel.FontName='Times';
    tb.ZLabel.FontSize=FontSize;
    tb.ZLabel.FontUnits='points';
    tb.ZLabel.HandleVisibility='off';
    tb.ZLabel.HorizontalAlignment='center';
    tb.ZLabel.Interpreter='latex';
    tb.ZLabel.LineWidth=LineWidth;
    tb.ZLabel.Position=[0.5 -0.1 0];
    tb.ZLabel.String='';
    tb.ZLabel.Units='data';
    tb.ZLabel.VerticalAlignment='middle';
    tb.ZLabel.Visible='off';
    tb.ZLim=[-double(RMax) double(RMax)];
    tb.ZTick=[];
    tb.ZTickLabel='';
else
    fig.CurrentAxes=ax;
end

if UseBorder==true
    plot3(double(RMax)*cos(linspace(0,2*pi,10001)),double(RMax)*sin(linspace(0,2*pi,10001)),ones(1,10001),...
        'Color',[0 0 0],...
        'LineStyle','-',...
        'LineWidth',0.5);
else
end

end