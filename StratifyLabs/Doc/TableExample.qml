import QtQuick 2.6
import StratifyLabs.UI 2.0

STable{

    model: ListModel {
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

    style: "fill block table-hover";

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
