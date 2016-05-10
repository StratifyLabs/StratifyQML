import QtQuick 2.5
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.1
import "."

import "Fa-4.5.0.js" as Fa

SItem {
    type: "breadcrumb"

    signal linkCliked(string hrefAddress);
    padding_vertical: Theme.breadcrumb_padding_vertical;
    padding_horizontal: Theme.breadcrumb_padding_horizontal;

    property alias model: listView.model;

    height: childrenRect.height;
    width: childrenRect.width;


    ListView {
        id: listView;
        model: xmlModel
        anchors.fill: parent;
//        width: 200;height:100;
        orientation: ListView.Horizontal;
        delegate: viewDelegate;
    }

    Component {
        id: viewDelegate;

        SRoundedRectangle {
            color: Theme.breadcrumb_bg;
            borderColor: Theme.breadcrumb_bg;
            width: childrenRect.width;
            height: mainText.height;
            Text {
                id: mainText;
                text: model.active==="active" ?
                          model.activeText
                        : model.text;
                color: Theme.breadcrumb_color;
//                textObject.linkColor: model.active ? Theme.breadcrumb_active_color : Theme.breadcrumb_color;
                Connections {
                    target: mainText/*.textObject*/
                    ignoreUnknownSignals: true
                    onLinkActivated: {
                        linkCliked(model.href);
                        console.log("############# href: ", model.href);
                    }
                }
            }
            Text {
                color: Theme.breadcrumb_color
                text: Theme.breadcrumb_separator;
                anchors.left: mainText.right
//                visible:  model.index < model.count -1;
            }
        }
    }

     XmlListModel {
         id: xmlModel;
         xml:  '<?xml version="1.0" encoding="UTF-8"?>
               <ol class="breadcrumb">
                <li><a class="" href="google.com">Home</a></li>
                <li><a class="" href="#">Private</a></li>
                <li><a class="" href="#">Pictures</a></li>
                <li><a class="active" href="#">Vacation</a></li>
               </ol>';
         query: "/ol/li"
         XmlRole { name: "text"; query: "a/string()";}
         XmlRole { name: "textActive"; query: "string()";}
         XmlRole { name: "href"; query: "@href/string()";}
         XmlRole { name: "active"; query: "@class/string()";}
     }
}
