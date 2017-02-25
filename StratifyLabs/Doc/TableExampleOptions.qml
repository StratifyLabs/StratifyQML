import QtQuick 2.6
import StratifyLabs.UI 2.0

SColumn {
    property alias tableData: libraryModel;
    ListModel {
        id: libraryModel;
        ListElement {
            title: "A Masterpiece"
            author: "Gabriel"
        }
        ListElement {
            title: "Brilliance"
            author: "Jens"
        }
        ListElement {
            title: "Outstanding"
            author: "Frederik"
        }
        ListElement {
            title: "A Masterpiece"
            author: "Gabriel"
        }
    }

    SContainer {
        height: 450;
        style: "padding-zero";
        /* The following table will fill the container
          rather than simply taking up its
          implicitHeight. */
        STable{
            model: tableData;
            style: "fill table-striped";

            STableColumn {
                span: 6;
                role: "title";
                title: "Title";
            }

            STableColumn {
                span: 6;
                role: "author"
                title: "Author"
            }
        }

    }

    STable{
        model: tableData;
        style: "table-condensed";

        STableColumn {
            span: 6;
            role: "title";
            title: "Title";
        }

        STableColumn {
            span: 6;
            role: "author"
            title: "Author"
        }
    }

    STable {
        model: tableData;
        style: "table-bordered";

        STableColumn {
            span: 6;
            role: "title";
            title: "Title";
        }

        STableColumn {
            span: 6;
            role: "author"
            title: "Author"
        }
    }

}


