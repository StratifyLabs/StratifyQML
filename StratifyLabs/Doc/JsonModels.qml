import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "JsonModels";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Json Models";
                inherits: "Item";
                stratifyName: "SJsonModel";
            }

            SLabel { style: "left"; text: "Description"; }

            SListGroup {
                model: SJsonModel {
                    id: model;
                    json: "{ \"data\": [{ \"text\": \"List Item 1\" },
                    { \"text\": \"List Item 2\" },
                    { \"text\": \"List Item 3\" },
                    { \"text\": \"List Item 4\" } ] }";
                }
            }

        }
    }
}
