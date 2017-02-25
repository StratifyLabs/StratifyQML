import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "FontAwesome";
    SText { style: "left text-bold"; text: "Introduction"; }
    SText { style: "block"; text: 'StratifyLabs UI icons are based on the latest release of Font Awesome. \
The icons can be used using SIcon, SButton, and SBadge. You can also set the font.family of any text to "STheme.fontFontAwesome.name" \
to use the font in other objects.'; }

    FontAwesomeExampleObjects{}
    ECodeExample { source: "FontAwesomeExampleObjects"; }

    SText { style: "left text-bold"; text: "The Icons"; }

    SText {
        id: fontList;
        font.family: STheme.fontFontAwesome.name;
        style: "block text-lg";
        Component.onCompleted: {
            var value = "";
            for(var ico in Fa.Icon){
                value += Fa.Icon[ico] + " ";
            }
            fontList.text = value;
        }
    }




    SText { style: "block"; text: 'The current icon set is Font Awesome 4.7. The icons are available as \
Fa.Icon.[name] where name is the name in the Font Awesome cheatsheet with "-" changed to "_".  Also, only \
the original names are supported rather than the alias (e.g. use "Fa.Icon.times" rather than "Fa.Icon.remove"; see the link \
below for more information).';
    }

    SButton {
        style: "btn-outline-info block";
        text: "Font Awesome Cheatsheet";
        icon: Fa.Icon.external_link;
        onClicked: Qt.openUrlExternally("http://fontawesome.io/cheatsheet/");
    }
}
