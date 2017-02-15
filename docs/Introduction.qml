import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Introduction";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI 2.0 is a QML framework that works, looks, \
and feels much like the twitter bootstrap HTML framework. The colors and shapes of components can be \
customized using a theme which uses variables similar to those available in the Twitter bootstrap framework. \
The UI also provides a responsive grid system that mimics bootstrap\'s ability to fit any screen.'; }
            SText { style: "left text-bold"; text: "Theme"; }
            SText { style: "block"; text: 'The look and feel are defined by the theme \
which is contained in the QML singleton object STheme. The following example shows how to change the primary and \
secondary brand colors. This code typically goes in the main "ApplicationWindow".'; }
            SWell {
                text: 'Component.onCompleted: {
        STheme.brand_primary = "#244E99";
        STheme.brand_secondary = "#666";
}';
            }

            SText { style: "block"; text: 'Individual components can also be styled and customized using \
the "style" or "attr" properties. Here is an example of making a button that uses the "warning" color scheme.'; }
            SButton {
                    style: "btn-warning";
                    text: "Warning Button";
            }
            SWell {
                text: 'SButton {
        style: "btn-warning";
        text: "Warning Button";
}';
            }

            SText { style: "block"; text: 'S{Objects} can be further customized by directly accessing \
the "attr" property.'; }

            SButton {
                    style: "btn-primary";
                    text: "Round Button";
                    attr.radius: height/2;
            }
            SWell {
                text: 'SButton {
                    style: "btn-warning";
                    text: "Round Button";
                    attr.radius: height;
}';
            }

            SText { style: "left text-bold"; text: "Grid System"; }
            SText { style: "block"; text: 'The responsive grid is based on two S{Objects}: SRow and \
SColumn. SRow directly inherits GridLayout while SColumn inherits SRow.  SRow requires its children \
to set the "span" value while SColumn assumes all items have a maximum "span" value.  Also, SRow \
will convert rows to columns based on the screen width. For the conversion to work, the following code \
should be in the main "ApplicationWindow" object.'; }
            SWell {
                text: 'onWidthChanged: {
        STheme.updateScreenSize(width);
}';
            }

            SText { style: "block"; text: 'The following code block shows how two columns can change \
to one when the screen is narrow. Small mode is ' + STheme.isScreenSm + '.'; }

            SRow {
                SButton { span: 6; style: "block"; text: "Button 1"; }
                SButton { span: 6; style: "block"; text: "Button 2"; }
            }

            SWell {
                text: 'SRow {
                SButton { span: 6; style: "block"; text: "Button 1"; }
                SButton { span: 6; style: "block"; text: "Button 2"; }
}';
            }

            SText { style: "left text-bold"; text: "Icons"; }
            SText { style: "block"; text: 'FontAwesome 4.7 is integrated in the UI. Icons can be used \
in SIcon, SButton and SBadge. Here is a sample.'; }

            SRow {
                SIcon { span: 3; icon: Fa.Icon.anchor; }
                SIcon { span: 3; icon: Fa.Icon.ban; }
                SIcon { span: 3; icon: Fa.Icon.bolt; }
                SIcon { span: 3; icon: Fa.Icon.camera; }
            }

            SWell {
                text: 'SRow {
                SIcon { span: 3; icon: Fa.Icon.anchor; }
                SIcon { span: 3; icon: Fa.Icon.ban; }
                SIcon { span: 3; icon: Fa.Icon.bolt; }
                SIcon { span: 3; icon: Fa.Icon.camera; }
}';
            }



        }

    }
}
