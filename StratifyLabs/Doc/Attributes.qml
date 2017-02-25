import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Attributes";
    SText { style: "left text-bold text-lg"; text: "Introduction"; }
    SText { style: "block"; text: '\
Stratify Labs UI allows you to quickly layout and style \
QML applications. It does this by attaching an "SAttributes" \
object to each item that defines the size and color scheme of \
each object. There are two ways to change an objects attributes: \
1) using "style" 2) using "attr" directly.';
    }
    SText { style: "block"; text: '\
Additionally, each item has quick access to "span" which \
defines the width of an S{Object} in an SRow. The code looks \
like this:';
    }

    SWell {
        text: 'property alias style: attr.style;
property alias span: attr.span;
property alias attr: attr;
SAttributes {
    id: attr;
    type: "button";
}
';
    }

    SText { style: "block"; text: '\
Most S{Objects} use SAttributes as the "attr" object. \
S{Objects} that don\'t have any color (e.g. SPane) use \
SSizeAttributes (which SAttributes inherits). If an object \
has additional attibutes, the object will be S{Object}Attributes \
(such as SAlertAttributes).'; }

    SText { style: "left text-bold text-lg"; text: "Changing the Style"; }
    SText { style: "block"; text: '\
When a new value is assigned to the "style" property, \
the string is parsed and the styling is bound to the object.';
    }
    SText { style: "block text-bold"; text: 'SSizeAttributes'; }
    SText { style: "block"; text: '\
SSizeAttributes (all objects) support the following style \
options.';
    }

    SContainer {
        SColumn {
            SText { style: "left text-bold"; text: "Padding"; }
            EBullet { text: "padding-zero"; }
            EBullet { text: "padding-xs"; }
            EBullet { text: "padding-lg"; }

            SHLine {}

            SText { style: "left text-bold"; text: "Horizontal Alignment"; }
            EBullet { text: "left"; }
            EBullet { text: "right"; }
            EBullet { text: "center"; }

            SText { style: "left text-bold"; text: "Vertical Alignment"; }
            EBullet { text: "top"; }
            EBullet { text: "bottom"; }
            EBullet { text: "middle"; }

            AttributeExampleAlignment{}
            ECodeExample { source: "AttributeExampleAlignment"; }

            SHLine {}


            SText { style: "left text-bold"; text: "Sizing"; }
            EBullet { text: "fill: fill height"; }
            EBullet { text: "block: fill width"; }
            EBullet { text: "default: align middle-center, implicit size"; }

            AttributeExampleSize{}
            ECodeExample { source: "AttributeExampleSize"; }
        }
    }

    SText { style: "block text-bold"; text: 'SAttributes'; }
    SText { style: "block"; text: 'SAttributes (most objects) support the following style \
options.'; }

    SContainer {
        SColumn {
            SText { style: "left text-bold"; text: "Size"; }
            SText { style: "left text-sm"; text: "Changes text size and padding"; }
            EBullet { text: "xs"; }
            EBullet { text: "sm"; }
            EBullet { text: "lg"; }

            SHLine {}

            SText { style: "left text-bold"; text: "Text Sizes"; }
            EBullet { text: "text-h1"; }
            EBullet { text: "text-h2"; }
            EBullet { text: "text-h3"; }
            EBullet { text: "text-h4"; }
            EBullet { text: "text-h5"; }
            EBullet { text: "text-h6"; }
            EBullet { text: "text-sm"; }
            EBullet { text: "text-lg"; }

            AttributeExampleTextSize{}
            ECodeExample { source: "AttributeExampleTextSize"; }

            SHLine {}

            SText { style: "left text-bold"; text: "Text Alignment"; }

            EBullet { text: "text-right"; }
            EBullet { text: "text-left"; }
            EBullet { text: "text-center"; }
            EBullet { text: "text-top"; }
            EBullet { text: "text-bottom"; }
            EBullet { text: "text-middle"; }

            AttributeExampleTextAlignment{}
            ECodeExample { source: "AttributeExampleTextAlignment"; }

            SHLine {}

            SText { style: "left text-bold"; text: "Text Weight"; }
            EBullet { text: "text-bold"; }
            EBullet { text: "text-light"; }
            EBullet { text: "text-demi-bold"; }
            EBullet { text: "text-extra-bold"; }
            EBullet { text: "text-extra-light"; }
            SRow {
                SText { span: 4; style: "text-bold"; text: "Text Bold"; }
                SText { span: 4; style: "text-light"; text: "Text Light"; }
                SText { span: 4; style: "text-demi-bold"; text: "Text Demi Bold"; }
                SText { span: 4; style: "text-extra-bold"; text: "Text Extra Bold"; }
                SText { span: 4; style: "text-extra-ligh"; text: "Text Extra Light"; }
                SText { span: 4; text: "Text"; }
            }

            SHLine {}
            SText { style: "left text-bold"; text: "Text Color"; }

            EBullet { text: "text-on-primary: color when on primary"; }
            EBullet { text: "text-on-secondary: color when on secondary"; }
            EBullet { text: "text-on-info: color when on info"; }
            EBullet { text: "text-on-warning: color when on warning"; }
            EBullet { text: "text-on-danger: color when on danger"; }
            EBullet { text: "text-on-success: color when on success"; }
            EBullet { text: "text-primary: set text color to primary"; }
            EBullet { text: "text-secondary: set text color to secondary"; }
            EBullet { text: "text-info: set text color to info"; }
            EBullet { text: "text-warning: set text color to warning"; }
            EBullet { text: "text-danger: set text color to danger"; }
            EBullet { text: "text-success: set text color to success"; }


            SHLine {}

            SText { style: "left text-bold"; text: "Color Schemes"; }
            SText { style: "left text-sm"; text: "Change font, object, and border colors"; }
            EBullet { text: "primary"; }
            EBullet { text: "secondary"; }
            EBullet { text: "info"; }
            EBullet { text: "warning"; }
            EBullet { text: "danger"; }
            EBullet { text: "success"; }
        }
    }

    SText { style: "block"; text: '\
Each S{Object} may add additional styling options. For example \
SButton uses "btn-outline-primary" for setting the color.';
    }


    SText { style: "left text-bold text-lg"; text: "Further Customization"; }

    SText { style: "block"; text: '\
If the styling options above don\'t meet your needs, \
you can directly access an item\'s attributes using the \
"attr" property. This is useful if you want to bind to \
specific attributes. The following example binds the icon "spin" \
attribute to a variable.';
    }

    AttributeExampleCustomAttributes{}
    ECodeExample { source: "AttributeExampleCustomAttributes"; }
}



