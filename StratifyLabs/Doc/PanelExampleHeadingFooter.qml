import StratifyLabs.UI 2.0

SRow {
    SPanel {
        span: 4;
        SColumn {
            SText { style: "block"; text: "Panel with no EHeading and no footer"; }
        }
    }
    SPanel {
        span: 4;
        footer: "Panel Footer";
        SColumn {
            SText { style: "block"; text: "Panel with footer and no EHeading"; }
        }
    }
    SPanel {
        span: 4;
        heading: "Panel EHeading";
        footer: "Panel Footer";
        SColumn {
            SText { style: "block"; text: "Panel with Heading and footer"; }
        }
    }
}
