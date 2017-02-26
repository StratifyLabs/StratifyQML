import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "JsonModels";
    EHeading {
        title: "Json Models";
        inherits: "ListModel";
        stratifyName: "SJsonModel";
    }

    ESectionTitle { text: "Description"; }
    SText {
        style: "block";
        text: '\
The SJsonModel object allows you to use JSON objects \
as list model (and table model) information. The example \
below shows how the JSON is formatted. By default, SJsonModel \
looks for a root item named "data" contains an array \
of objects. Each named string value in the object is made \
available to the delegate. In the example, below,
the delegate item uses "model.text". \
';
        }

    SHLine{}

    ESectionTitle { text: "Example"; }
    JsonModelExample{}
    ECodeExample { source: "JsonModelExample"; }

}
