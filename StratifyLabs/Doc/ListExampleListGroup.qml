import StratifyLabs.UI 2.0

SRow {
    SListGroup {
        span: 8;
        style: "block center";
        model: SJsonModel {
            id: model;
            json: "{ \"data\": [{ \"text\": \"List Item 1\" },
                { \"text\": \"List Item 2\" },
                { \"text\": \"List Item 3\" },
                { \"text\": \"List Item 4\" } ] }";
        }
    }
}
