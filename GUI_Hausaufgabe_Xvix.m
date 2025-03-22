classdef GUI_Hausaufgabe_Xvix < matlab.apps.AppBase

    % Properties that correspond to app components  
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        UIAxes              matlab.ui.control.UIAxes
        EllipseCheckBox     matlab.ui.control.CheckBox
        CircleCheckBox      matlab.ui.control.CheckBox
        SpiralCheckBox      matlab.ui.control.CheckBox
        CardioidCheckBox    matlab.ui.control.CheckBox
        aEditFieldLabel     matlab.ui.control.Label
        aEditField          matlab.ui.control.NumericEditField
        bEditFieldLabel     matlab.ui.control.Label
        bEditField          matlab.ui.control.NumericEditField
        GridSwitch          matlab.ui.control.Switch
    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.aEditField.Value = 5;
            app.bEditField.Value = 3;
            plotCurves(app);
        end

        % Function to plot the selected curves
        function plotCurves(app)
            t = linspace(0, 2*pi, 75);
            cla(app.UIAxes);
            hold(app.UIAxes, 'on');
            if app.EllipseCheckBox.Value
                xt1 = app.aEditField.Value * cos(t);
                yt1 = app.bEditField.Value * sin(t);
                zt1 = asinh(xt1 .* yt1);
                plot(app.UIAxes, t, zt1, 'DisplayName', 'Ellipse');
            end
            if app.CircleCheckBox.Value
                xt2 = 2 * cos(t);
                yt2 = 2 * sin(t);
                zt2 = asinh(xt2 .* yt2);
                plot(app.UIAxes, t, zt2, 'DisplayName', 'Circle');
            end
            if app.SpiralCheckBox.Value
                xt3 = (log(2*t + 1) + 1) .* cos(t);
                yt3 = (log(2*t + 1) + 1) .* sin(t);
                zt3 = asinh(xt3 .* yt3);
                plot(app.UIAxes, t, zt3, 'DisplayName', 'Spiral');
            end
            if app.CardioidCheckBox.Value
                xt4 = 2 * (1 - cos(t)) .* cos(t);
                yt4 = 2 * (1 - cos(t)) .* sin(t);
                zt4 = asinh(xt4 .* yt4);
                plot(app.UIAxes, t, zt4, 'DisplayName', 'Cardioid');
            end
            legend(app.UIAxes, 'show');
            hold(app.UIAxes, 'off');
        end

        % Value changed function for checkboxes
        function CheckBoxValueChanged(app, event)
            plotCurves(app);
        end

        % Value changed function for grid switch
        function GridSwitchValueChanged(app, event)
            if app.GridSwitch.Value == "On"
                grid(app.UIAxes, 'on');
            else
                grid(app.UIAxes, 'off');
            end
        end

    end

    % App initialization and construction
    methods (Access = public)

        % Construct app
        function app = GUI_Hausaufgabe_Xvix

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)
        end

        % Code that executes before app deletion
        function delete(app)
            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Schnittverläufe mit asinh(x*y) entlang verschiedener Parameterkurven')
            xlabel(app.UIAxes, 't in rad')
            ylabel(app.UIAxes, 'zt')
            app.UIAxes.Position = [50 150 540 300];

            % Create EllipseCheckBox
            app.EllipseCheckBox = uicheckbox(app.UIFigure);
            app.EllipseCheckBox.ValueChangedFcn = createCallbackFcn(app, @CheckBoxValueChanged, true);
            app.EllipseCheckBox.Text = 'Ellipse';
            app.EllipseCheckBox.Position = [50 100 70 22];
            app.EllipseCheckBox.Value = true;

            % Create CircleCheckBox
            app.CircleCheckBox = uicheckbox(app.UIFigure);
            app.CircleCheckBox.ValueChangedFcn = createCallbackFcn(app, @CheckBoxValueChanged, true);
            app.CircleCheckBox.Text = 'Circle';
            app.CircleCheckBox.Position = [150 100 70 22];

            % Create SpiralCheckBox
            app.SpiralCheckBox = uicheckbox(app.UIFigure);
            app.SpiralCheckBox.ValueChangedFcn = createCallbackFcn(app, @CheckBoxValueChanged, true);
            app.SpiralCheckBox.Text = 'Spiral';
            app.SpiralCheckBox.Position = [250 100 70 22];
            app.SpiralCheckBox.Value = true;

            % Create CardioidCheckBox
            app.CardioidCheckBox = uicheckbox(app.UIFigure);
            app.CardioidCheckBox.ValueChangedFcn = createCallbackFcn(app, @CheckBoxValueChanged, true);
            app.CardioidCheckBox.Text = 'Cardioid';
            app.CardioidCheckBox.Position = [350 100 70 22];

            % Create aEditFieldLabel
            app.aEditFieldLabel = uilabel(app.UIFigure);
            app.aEditFieldLabel.HorizontalAlignment = 'right';
            app.aEditFieldLabel.Position = [450 100 25 22];
            app.aEditFieldLabel.Text = 'a =';

            % Create aEditField
            app.aEditField = uieditfield(app.UIFigure, 'numeric');
            app.aEditField.Position = [480 100 50 22];
            app.aEditField.Value = 5;

            % Create bEditFieldLabel
            app.bEditFieldLabel = uilabel(app.UIFigure);
            app.bEditFieldLabel.HorizontalAlignment = 'right';
            app.bEditFieldLabel.Position = [550 100 25 22];
            app.bEditFieldLabel.Text = 'b =';

            % Create bEditField
            app.bEditField = uieditfield(app.UIFigure, 'numeric');
            app.bEditField.Position = [580 100 50 22];
            app.bEditField.Value = 3;

            % Create GridSwitch
            app.GridSwitch = uiswitch(app.UIFigure, 'slider');
            app.GridSwitch.Items = {'Off', 'On'};
            app.GridSwitch.ValueChangedFcn = createCallbackFcn(app, @GridSwitchValueChanged, true);
            app.GridSwitch.Position = [580 50 50 22];
            app.GridSwitch.Value = 'On';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end
end
